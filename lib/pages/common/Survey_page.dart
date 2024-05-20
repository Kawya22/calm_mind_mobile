import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class SurveyScreen extends StatefulWidget {
  static const path = "survey";
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List<String> answers = [];
  int currentQuestionIndex = 0;
  List<String> activitiesForMaxEmotion =['Set Personal Goals','Create a Support Network',
    'Practice Self-Care','Stay Mindful and Active','Engage in Social Activities',
    'Stay Hydrated and Eat Nutritiously','Get Sufficient Sleep','Celebrate Small Wins'];

  List<SurveyQuestion> questions = [
    SurveyQuestion('Did you get a good nights sleep last night?'),
    SurveyQuestion('Are you feeling happy right now?'),
    SurveyQuestion('Have you experienced any recent stress or anxiety?'),
    SurveyQuestion('Do you feel motivated to accomplish your tasks today?'),
    SurveyQuestion('Have you had any enjoyable social interactions today?'),
    SurveyQuestion('Have you had any recent negative thoughts or emotions that are bothering you?'),
  ];

  void answerQuestion(String answer) {
    if (currentQuestionIndex < questions.length - 1) {
      answers.add(answer);
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      double overallProgress = (answers.where((answer) => answer == 'Yes').length / answers.length);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Survey Completed'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Overall Progress: ${(overallProgress * 100).toStringAsFixed(1)}%'),
                SizedBox(height: 16),
                Container(
                  width: 150, // Set the desired width
                  height: 150, // Set the desired height
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.lightGreen,
                          value: overallProgress,
                          title: (overallProgress * 100).toStringAsFixed(1) + "%",
                        ),
                        PieChartSectionData(
                          color: Colors.grey,
                          value: 1.0 - overallProgress,
                          title: '',
                        ),
                      ],
                      centerSpaceRadius: 30, // Adjust this value to control the chart size
                      sectionsSpace: 0,
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
                Text("Instructions", style: TextStyle(fontSize: 20),),
                for (var activity in activitiesForMaxEmotion)
                  Text(activity, style: TextStyle(fontSize: 16))
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Mood Tracker Survey',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (currentQuestionIndex < questions.length)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Question ${currentQuestionIndex + 1}: ' + questions[currentQuestionIndex].question),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              answerQuestion('Yes');
                            },
                            child: Text('Yes'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              answerQuestion('No');
                            },
                            child: Text('No'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SurveyQuestion {
  final String question;

  SurveyQuestion(this.question);
}
