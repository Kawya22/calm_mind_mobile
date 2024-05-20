import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile/dto/out/create_user_record_dto.dart';
import 'package:mobile/services/user_record_service.dart';

const _darkBlue = 0xFFE0B2B2;

class SlidableTableUserRecordsWidget extends StatefulWidget {
  SlidableTableUserRecordsWidget({super.key});

  @override
  _SlidableTableUserRecordsWidgetState createState() => _SlidableTableUserRecordsWidgetState();
}

class _SlidableTableUserRecordsWidgetState extends State<SlidableTableUserRecordsWidget> {
  List<CreateUserRecordDto> userRecords = [];

  @override
  void initState() {
    super.initState();
    loadUserRecords();
  }

  Future<void> loadUserRecords() async {
    try {
      userRecords = await UserRecordService.instance.getUserRecords();
      setState(() {});
    } catch (e) {
      // Handle the exception, e.g., show an error message.
      print('Error loading user records: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userRecords.length,
      itemBuilder: (context, index) {
        final userRecord = userRecords[index];
        final isOddRow = index % 2 == 1;

        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            color: isOddRow ? const Color(_darkBlue) : Colors.transparent,
            child: ListTile(
              title: Text("Emotion: ${userRecord.emotion}"),
              subtitle: Text("Date: ${userRecord.createdOn}"),
              tileColor: isOddRow ? Colors.white : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          secondaryActions: [
            IconSlideAction(
              caption: 'Edit',
              color: Colors.blue,
              icon: Icons.edit,
              onTap: () {
                // Implement your edit action here
              },
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                // Implement your delete action here
              },
            ),
          ],
        );
      },
    );
  }
}