import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile/dto/out/create_sleep_dto.dart';
import 'package:mobile/services/auth_service.dart';

const _darkBlue = 0xFFE0B2B2;

class SlidableSleepRecordsWidget extends StatefulWidget {
  SlidableSleepRecordsWidget({Key? key}) : super(key: key);

  @override
  _SlidableSleepRecordsWidgetState createState() => _SlidableSleepRecordsWidgetState();
}

class _SlidableSleepRecordsWidgetState extends State<SlidableSleepRecordsWidget> {
  static final authService = AuthService.instance;
  List<SleepData> sleepRecords = [];

  @override
  void initState() {
    super.initState();
    loadSleepRecords();
  }

  Future<void> loadSleepRecords() async {
    try {
      // Call the service method to load sleep records
      sleepRecords = await authService.loadSleepRecordsForUser();
      setState(() {});
    } catch (e) {
      // Handle the exception, e.g., show an error message.
      print('Error loading sleep records: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sleepRecords.length,
      itemBuilder: (context, index) {
        final sleepRecord = sleepRecords[index];
        final isOddRow = index % 2 == 1;

        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            color: isOddRow ? const Color(_darkBlue) : Colors.transparent,
            child: ListTile(
              title: Text("Sleep Start: ${sleepRecord.sleepStart}"),
              subtitle: Text("Sleep End: ${sleepRecord.sleepEnd},\nSleep Duration: ${sleepRecord.duration}"),

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
                // For example, you can show a confirmation dialog
                showDialog(
                  context: context, // You should have access to the context
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Delete'),
                      content: Text('Are you sure you want to delete this item?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: Text('Delete'),
                          onPressed: () {
                            // Perform the actual delete operation here
                            // You should delete the item from your data source
                            // and update the UI accordingly
                            // Then, close the dialog
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            )

          ],
        );
      },
    );
  }
}
