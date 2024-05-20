import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/constants.dart';
import 'package:mobile/dto/out/create_sleep_dto.dart';
import 'package:mobile/dto/out/create_user_dto.dart';

class AuthService {
  static final instance = AuthService._();

  AuthService._();

  final _fa = FirebaseAuth.instance;
  final _fs = FirebaseFirestore.instance;

  Future<void> signIn(String email, String password) async {
    await _fa.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(CreateUserDto createUser, String password) async {
    await _fa.createUserWithEmailAndPassword(
      email: createUser.email,
      password: password,
    );
    await _createFsUser(createUser);
  }

  Future<void> _createFsUser(CreateUserDto createUser) async {
    final user = _fa.currentUser!;
    createUser.id = user.uid;
    await _fs
        .collection(usersCollectionName)
        .doc(user.uid)
        .set(createUser.toJson());
  }

  Future<void> createSleepRecord(SleepData sleepData) async {
    final user = _fa.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated.');
    }

    final userQuery = await _fs
        .collection(usersCollectionName)
        .where('email', isEqualTo: user.email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      final userDoc = userQuery.docs.first;
      await userDoc.reference.collection('sleep_records').add(sleepData.toJson());
    } else {
      throw Exception('User document not found.');
    }
  }

  Future<List<SleepData>> loadSleepRecordsForUser() async {
    final user = _fa.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated.');
    }

    final userQuery = await _fs
        .collection(usersCollectionName)
        .where('email', isEqualTo: user.email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      final userDoc = userQuery.docs.first;
      final sleepRecordsQuery = await userDoc.reference.collection('sleep_records').get();

      final sleepRecords = <SleepData>[];
      for (final doc in sleepRecordsQuery.docs) {
        final sleepDataMap = doc.data() as Map<String, dynamic>;
        final sleepData = SleepData.fromJson(sleepDataMap);
        sleepRecords.add(sleepData);
      }

      return sleepRecords;
    } else {
      throw Exception('User document not found.');
    }
  }
}
