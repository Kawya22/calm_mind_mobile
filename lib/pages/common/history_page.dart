import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/emotion_icons_menu.dart';
import 'package:mobile/pages/common/signin_page.dart';

class HistoryPage extends StatelessWidget {
  static const path = "history";

  static MaterialPageRoute homeRoute(String maxEmotion, int rate) {
    return MaterialPageRoute(
      builder: (context) => HistoryPage(maxEmotion: maxEmotion, rate: rate),
    );
  }

  static final _fa = FirebaseAuth.instance;
  final String maxEmotion;
  final int rate;
  static const Map<String, List<String>> emotionActivities = {
    'Angry': ['Take a deep breath and count to ten',
      'Go for a brisk walk or run',
      'Write your thoughts and feelings in a journal',
      'Talk to a trusted person about what is bothering you'],
    'Disgust': ['Take a walk in nature',
      'Listen to calming music',
      'Avoid dwelling on negative emotions',
      'Practice self-compassion and forgiveness'],
    'Fear': ['Practice deep breathing or meditation',
      'Reach out to a trusted person for support',
      'Positive self-affirmations',
      'Confront your fears by breaking them into manageable steps'],
    'Happy': ['Engage in an enjoyable activity you love',
      'Spend time with loved ones or friends',
      'Express your happiness through art or music',
      'Practice gratitude by listing things you are thankful for'],
    'Normal': ['Maintain a balanced routine',
      'Continue pursuing your hobbies and interests',
      'Set small goals for personal growth',
      'Practice mindfulness to stay in touch with your emotions'],
    'Sad': ['Watch a comedy movie',
      'Take a warm bath, read, listen to calming music',
      'Engage in a workout or take a walk',
      'Connect with a supportive person'],
    'Surprise': ['Explore new experiences or activities',
      'Share your surprise with someone',
      'Embrace the feeling of surprise',
      'Reflect on how the surprise has positively impacted your day'],
  };

  const HistoryPage({super.key, required this.maxEmotion, required this.rate});

  Future<void> _onSignOut(BuildContext context) async {
    try {
      await _fa.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }

    // ignore: use_build_context_synchronously
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(SignInPage.path, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final activitiesForMaxEmotion = emotionActivities[maxEmotion] ?? ['No activities found'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _onSignOut(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (maxEmotion.isNotEmpty)
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Image.asset('assets/emotion_prediction/$maxEmotion.png'),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Max Emotion: $maxEmotion",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rating: $rate",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Text(
                            "Activities Suggested",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 1),
                          for (var activity in activitiesForMaxEmotion)
                            Text(activity, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 20),

                    ],
                  )
                else
                  Column(
                    children: [
                      Text(
                        "Use Following Actions.",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      // Add any other content or widgets you want when maxEmotion is empty
                    ],
                  ),
              ],
            )
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              // Replace with your slidable table widget
              child: EmotionIconMenu(emotion: maxEmotion),
            ),
          ),
        ],
      ),
    );
  }
}