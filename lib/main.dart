import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/constants.dart';
import 'package:mobile/firebase_options.dart';
import 'package:mobile/pages/common/Survey_page.dart';
import 'package:mobile/pages/common/audio_library_page.dart';
import 'package:mobile/pages/common/exercise_page.dart';
import 'package:mobile/pages/common/history_page.dart';
import 'package:mobile/pages/common/landing_page.dart';
import 'package:mobile/pages/common/signin_page.dart';
import 'package:mobile/pages/common/signup_page.dart';
import 'package:mobile/pages/common/camera_page.dart';
import 'package:mobile/pages/common/sleep_form_page.dart';
import 'package:mobile/pages/common/sleep_records_page.dart';
import 'package:mobile/pages/common/user_records_page.dart';
import 'package:mobile/theme.dart';

List <CameraDescription>? cameras;

Future<void> _initEnv() async {
  await dotenv.load(fileName: ".env");
  const environment = kDebugMode ? ".env.development" : ".env.production";
  await dotenv.load(fileName: environment);
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (useEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator(hostAddress!, 8080);
    await FirebaseAuth.instance.useAuthEmulator(hostAddress!, 9099);
  }
}

Future<void> main() async {
  await _initEnv();
  await _initFirebase();

  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CALM MIND',
      theme: themeData,
      initialRoute: LandingPage.path,
      routes: {
        LandingPage.path: (context) => const LandingPage(),
        SignInPage.path: (context) => const SignInPage(),
        SignUpPage.path: (context) => const SignUpPage(),
        HistoryPage.path: (context) => const HistoryPage(maxEmotion: '', rate: 0,),
        CameraPage.path: (context) => const CameraPage(),
        AudioLibrary.path: (context) => AudioLibrary(),
        ExerciseArticleScreen.path: (context) => ExerciseArticleScreen(),
        SurveyScreen.path: (context) => SurveyScreen(),
        UserRecordsScreen.path: (context) => UserRecordsScreen(),
        SleepScreen.path: (context) => SleepScreen(),
        SleepDataScreen.path: (context) => SleepDataScreen(),
      },
    );
  }
}
