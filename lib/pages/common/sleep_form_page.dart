import 'package:flutter/material.dart';
import 'package:mobile/dto/out/create_sleep_dto.dart';
import 'package:mobile/pages/common/sleep_records_page.dart';
import 'package:mobile/services/auth_service.dart';

class SleepDataScreen extends StatefulWidget {
  static const path = "sleep_form";
  @override
  _SleepDataScreenState createState() => _SleepDataScreenState();
}

class _SleepDataScreenState extends State<SleepDataScreen> {
  static final authService = AuthService.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _sleepDuration = "";

  void _calculateSleepDuration() {
    if (_startTime != null && _endTime != null) {
      final int startHour = _startTime!.hour;
      final int endHour = _endTime!.hour;
      final int startMinute = _startTime!.minute;
      final int endMinute = _endTime!.minute;

      int hours;
      int minutes;

      if (endHour < startHour || (endHour == startHour && endMinute < startMinute)) {
        // Handle the case where the end time is before the start time (overnight)
        hours = 24 - (startHour - endHour);
        if (endMinute < startMinute) {
          hours--;
          minutes = 60 - (startMinute - endMinute);
        } else {
          minutes = endMinute - startMinute;
        }
      } else {
        // Handle the case where the end time is after the start time (same day)
        hours = endHour - startHour;
        if (endMinute < startMinute) {
          hours--;
          minutes = 60 - (startMinute - endMinute);
        } else {
          minutes = endMinute - startMinute;
        }
      }

      setState(() {
        _sleepDuration = "$hours hours $minutes minutes";
      });
    }
  }


  void _submitForm() {
    if ( _startTime != null && _endTime != null) {
      final sleepStart = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        _startTime!.hour,
        _startTime!.minute,
      );

      final sleepEnd = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        _endTime!.hour,
        _endTime!.minute,
      );

      final sleepDuration = sleepEnd.difference(sleepStart);

      final sleepData = SleepData(
        sleepStart: sleepStart,
        sleepEnd: sleepEnd,
        duration: sleepDuration,
      );

      // Call the service method to create the sleep record
      AuthService.instance.createSleepRecord(sleepData);

      // Clear the form or navigate to a different screen
      _startTime = null;
      _endTime = null;
      Navigator.push(context, MaterialPageRoute(builder: (context) => SleepScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleep Data Form (24-hour Clock)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Sleep Start Time'),
                trailing: ElevatedButton(
                  onPressed: () async {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      setState(() {
                        _startTime = selectedTime;
                      });
                    }
                  },
                  child: Text(
                    _startTime != null
                        ? '${_startTime!.hour.toString().padLeft(2, '0')}:${_startTime!.minute.toString().padLeft(2, '0')}'
                        : 'Pick Time',
                  ),
                ),
              ),
              ListTile(
                title: Text('Sleep End Time'),
                trailing: ElevatedButton(
                  onPressed: () async {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      setState(() {
                        _endTime = selectedTime;
                      });
                    }
                  },
                  child: Text(
                    _endTime != null
                        ? '${_endTime!.hour.toString().padLeft(2, '0')}:${_endTime!.minute.toString().padLeft(2, '0')}'
                        : 'Pick Time',
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _calculateSleepDuration();
                },
                child: Text('Calculate Sleep Duration'),
              ),
              SizedBox(height: 16.0),
              Text('Sleep Duration: $_sleepDuration'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}





