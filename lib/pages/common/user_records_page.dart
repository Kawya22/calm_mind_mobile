import 'package:flutter/material.dart';
import 'package:mobile/components/slidable_table_user_records.dart';

class UserRecordsScreen extends StatelessWidget {
  static const path = "user_records";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Records'),
      ),
      body: SlidableTableUserRecordsWidget(), // Include the widget here
    );
  }
}
