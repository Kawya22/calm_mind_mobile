import 'package:flutter/material.dart';
import 'package:mobile/components/slidable_sleep_records.dart';
import 'package:mobile/components/slidable_table_user_records.dart';
import 'package:mobile/pages/common/sleep_form_page.dart';

class SleepScreen extends StatelessWidget {
  static const path = "sleep_records";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleep Data'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SlidableSleepRecordsWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SleepDataScreen()));
              },
              child: Text('Sleep Quality Form'),
            ),
          ),
        ],
      ),
    );
  }
}

