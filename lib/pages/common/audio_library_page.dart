import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mobile/pages/common/history_page.dart';

class AudioLibrary extends StatefulWidget {
  static const path = "audio";
  @override
  _AudioLibraryState createState() => _AudioLibraryState();
}

class _AudioLibraryState extends State<AudioLibrary> {
  List<String> audioList = [
    'audios/audio_1.mp3',
    'audios/audio_2.mp3',
    'audios/audio_3.mp3',
  ];
  AudioPlayer audioPlayer = AudioPlayer();
  String currentAudio = '';
  Duration audioDuration = Duration();
  Duration audioPosition = Duration();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        currentAudio = '';
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        audioPosition = event;
      });
    });
  }

  Future<void> playAudio(String audioPath) async {
    await audioPlayer.stop();
    await audioPlayer.play(AssetSource(audioPath));
    setState(() {
      currentAudio = audioPath;
      isPlaying = true;
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        audioDuration = event;
      });
    });
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
      currentAudio = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calm Music'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage(maxEmotion: '', rate: 0)));
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Select calming musics from below library",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: audioList.length,
              itemBuilder: (context, index) {
                final audioPath = audioList[index];
                final isCurrentAudio = audioPath == currentAudio;

                // Define border and shading color
                final borderColor = Colors.grey[300];
                final backgroundColor = isCurrentAudio ? Colors.blue[100] : null;

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70),
                    color: backgroundColor,
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Calm Music ${index + 1}', style: TextStyle(fontSize: 16)),
                        if (isCurrentAudio)
                          IconButton(
                            icon: Icon(Icons.stop),
                            onPressed: () {
                              stopAudio();
                            },
                          ),
                      ],
                    ),
                    onTap: () {
                      if (isCurrentAudio) {
                        stopAudio();
                      } else {
                        playAudio(audioPath);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          if (currentAudio.isNotEmpty)
            Column(
              children: [
                Text('Now Playing: ${currentAudio.split('/').last}'),
                Slider(
                  value: audioPosition.inSeconds.clamp(0, audioDuration.inSeconds).toDouble(),
                  min: 0.0,
                  max: audioDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      audioPlayer.seek(Duration(seconds: value.toInt()));
                    });
                  },
                  onChangeEnd: (value) {
                    audioPlayer.seek(Duration(seconds: value.toInt()));
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.stop),
                      onPressed: stopAudio,
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}