import 'package:flutter/material.dart';
import 'package:mobile/pages/common/Survey_page.dart';
import 'package:mobile/pages/common/audio_library_page.dart';
import 'package:mobile/pages/common/exercise_page.dart';
import 'package:mobile/pages/common/sleep_records_page.dart';
import 'package:mobile/pages/common/user_records_page.dart';

class EmotionIconMenu extends StatefulWidget {
  final String emotion;

  EmotionIconMenu({required this.emotion});

  @override
  _EmotionIconMenuState createState() => _EmotionIconMenuState();
}

class _EmotionIconMenuState extends State<EmotionIconMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3, // Number of icons per row
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          // Icon 1
          GestureDetector(
            onTap: () {
              // Navigate to screen 1
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AudioLibrary.path, (route) => false);
            },
            child: IconMenuTile(icon: Icons.music_note, label: 'Calm Music'),
          ),
          // Icon 2
          GestureDetector(
            onTap: () {
              // Navigate to screen 2
              Navigator.push(context, MaterialPageRoute(builder: (context) => SurveyScreen()));
            },
            child: IconMenuTile(icon: Icons.track_changes, label: 'Mood Tracker'),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to screen 3
              Navigator.push(context, MaterialPageRoute(builder: (context) => ExerciseArticleScreen()));
            },
            child: IconMenuTile(icon: Icons.run_circle, label: 'Yoga and Exercise'),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to screen 3
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserRecordsScreen()));
            },
            child: IconMenuTile(icon: Icons.history, label: 'History'),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to screen 3
              Navigator.push(context, MaterialPageRoute(builder: (context) => SleepScreen()));
            },
            child: IconMenuTile(icon: Icons.ac_unit, label: 'Sleep Monitor'),
          ),
        ],
      ),
    );
  }
}

class IconMenuTile extends StatelessWidget {
  final IconData icon;
  final String label;

  IconMenuTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(icon, size: 48.0),
        SizedBox(height: 8.0),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
      ),
      body: Center(
        child: Text('Screen 1 content'),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
      ),
      body: Center(
        child: Text('Screen 2 content'),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 3'),
      ),
      body: Center(
        child: Text('Screen 3 content'),
      ),
    );
  }
}