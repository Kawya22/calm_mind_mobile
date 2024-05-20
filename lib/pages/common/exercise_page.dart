import 'package:flutter/material.dart';

class ExerciseArticleScreen extends StatefulWidget {
  static const path = "exercise";
  @override
  _ExerciseArticleScreenState createState() => _ExerciseArticleScreenState();
}

class _ExerciseArticleScreenState extends State<ExerciseArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise and Yoga'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&q=80&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Z3ltfGVufDB8fDB8fHww&w=1000',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Exercise and Its Benefits',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Regular exercise is essential for maintaining good health and well-being. It offers a wide range of physical and mental benefits, including improved cardiovascular health, increased muscle strength, and reduced stress levels.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Tip 1: Stay hydrated during your workouts',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Tip 2: Don\'t forget to warm up before',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Tip 3: Focus on maintaining correct form for each exercise',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Tip 4: Pay attention to your breathing',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Tip 5: Change your routine regularly to avoid plateaus and keep things interesting',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Tip 6:  Give your body time to recover',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}