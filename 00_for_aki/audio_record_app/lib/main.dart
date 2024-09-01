import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Record audioRecorder = Record();
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isRecord = false;
  bool isPlay = false;
  String audioPath = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    audioRecorder.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecorder.hasPermission()) {
        await audioRecorder.start();
        setState(() {
          isRecord = true;
        });
      }
    } catch (e) {
      print("Error Start Recording: $e");
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecorder.stop();
      if (path != null) {
        setState(() {
          audioPath = path;
          isRecord = false;
        });

        print("path: $path");
      }
    } catch (e) {
      print("Error Stop Recording: $e");
    }
  }

  Future<void> startPlaying() async {
    try {
      Source urlSource = UrlSource(audioPath);
      await audioPlayer.play(urlSource);
      setState(() {
        isPlay = true;
      });

      /** 정지 버튼 누르지않고, 끝난 경우 */
      audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          isPlay = false;
        });
      });
    } catch (e) {
      print("Error Start Playing: $e");
    }
  }

  Future<void> stopPlaying() async {
    try {
      await audioPlayer.stop();
        setState(() {
          isPlay = false;
        });
    } catch (e) {
      print("Error Stop Playing: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Recorder"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: !isRecord ? startRecording : stopRecording, child: !isRecord ? const Text("Start Record") : const Text("Stop Record")),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                onPressed: !isPlay ? startPlaying : stopPlaying, child: !isPlay ? const Text("Start Play") : const Text("Stop Play")),
          ],
        ),
      ),
    );
  }
}
