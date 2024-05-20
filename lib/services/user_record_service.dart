import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/constants.dart';
import 'package:mobile/dto/out/create_user_record_dto.dart';

class UserRecordService {
  static final instance = UserRecordService._();

  UserRecordService._();

  final _fa = FirebaseAuth.instance;
  final _fs = FirebaseFirestore.instance;

  Future<void> createUserRecord(CreateUserRecordDto userRecord) async {
    final user = _fa.currentUser;

    if (user != null) {
      // userRecord.id = user.uid;

      await _fs
          .collection(userRecordsCollectionName)
          .add(userRecord.toJson());
    } else {
      throw Exception('User is not authenticated');
    }
  }

  Future<List<CreateUserRecordDto>> getUserRecords() async {
    final user = _fa.currentUser;

    if (user != null) {
      final querySnapshot = await _fs
          .collection(userRecordsCollectionName)
          .where('email', isEqualTo: user.email)
          .get();

      return querySnapshot.docs
          .map((doc) => CreateUserRecordDto.fromJson(doc.data()))
          .toList();
    } else {
      throw Exception('User is not authenticated and Records didn t save');
    }
  }
}
