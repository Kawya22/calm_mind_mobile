import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/star_rating.dart';
import 'package:mobile/dto/out/create_user_record_dto.dart';
import 'package:mobile/main.dart';
import 'package:mobile/pages/common/history_page.dart';
import 'package:mobile/services/user_record_service.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:mobile/services/auth_service.dart';


class CameraPage extends StatefulWidget {
  static const path = "camera";
  const CameraPage({Key? key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  Map<String, int> emotionCounts = {};
  int selectedRating = 5; // Default rating value

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  loadCamera() async {
    cameraController = CameraController(cameras![1], ResolutionPreset.medium);
    await cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            cameraImage = imageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel() async {
    try {
      if (cameraImage != null) {
        var bytesList = cameraImage!.planes.map((plane) => plane.bytes).toList();
        var predictions = await Tflite.runModelOnFrame(
          bytesList: bytesList,
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 1,
          threshold: 0.4,
          asynch: true,
        );
        if (predictions != null && predictions.isNotEmpty) {
          setState(() {
            output = predictions[0]['label'];
          });
          emotionCounts.update(output, (count) => count + 1, ifAbsent: () => 1);
        }
      }
    } catch (e) {
      print('Error in runModel: $e');
    }
  }

  loadModel() async {
    log("LOAD MODEL");
    await Tflite.loadModel(
      model: "assets/emotion_prediction/model.tflite",
      labels: "assets/emotion_prediction/labels.txt",
    );
  }

  String getEmotionWithMaxCount() {
    if (emotionCounts.isEmpty) {
      return "No emotion detected";
    }
    var maxCount = 0;
    var maxEmotion = "";
    emotionCounts.forEach((emotion, count) {
      if (count > maxCount) {
        maxCount = count;
        maxEmotion = emotion;
      }
    });
    return maxEmotion;
  }

  static final _authService = AuthService.instance;

  final _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  Future<void> onCapturing(int selectedRating) async {
    try {
      if (!mounted) return;
      final maxEmotion = getEmotionWithMaxCount();
      final userEmail = FirebaseAuth.instance.currentUser?.email ?? '';
      if (maxEmotion != null) {
        var userRecord = CreateUserRecordDto(email: userEmail, emotion: maxEmotion, rate: selectedRating);
        await UserRecordService.instance.createUserRecord(userRecord);
        await cameraController!.dispose();
        await Navigator.of(context).pushAndRemoveUntil(
            HistoryPage.homeRoute(maxEmotion, selectedRating), (route) => false);
      } else {
        await cameraController!.dispose();
        await Navigator.of(context).pushAndRemoveUntil(
            HistoryPage.homeRoute('', selectedRating), (route) => false);
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            'assets/common/p.jpg',
            fit: BoxFit.values[2],
            width: double.infinity,
            height: double.infinity,
          ),
          const Positioned(
            top: 60,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Capture Yourself",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: const Color(0xffffffff).withOpacity(0.8),
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text("Your Preview",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            )),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height - 400,
                          width: MediaQuery.of(context).size.width,
                          child: !cameraController!.value.isInitialized
                              ? Container()
                              : AspectRatio(
                            aspectRatio: cameraController!.value.aspectRatio,
                            child: CameraPreview(cameraController!),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("Rate Your Day"),
                        StarRating(
                          rating: selectedRating,
                          onRatingChanged: (rating) {
                            setState(() {
                              selectedRating = rating;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 140.0,
                              vertical: 20.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onPressed: () {
                            onCapturing(selectedRating);
                          },
                          child: FittedBox(
                            child: const Text(
                              "Capture",
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You Seem $output",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
