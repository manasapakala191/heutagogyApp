import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:heutagogy/data_models.dart';
import 'package:heutagogy/lesson_1_tests.dart';
import 'package:heutagogy/lesson_2_tests.dart';
import 'package:heutagogy/lesson_3_tests.dart';

class LessonDetail extends StatefulWidget {
  final LessonData lessonData;
  final int id;

  LessonDetail(this.lessonData, {this.id});

  @override
  State<StatefulWidget> createState() => LessonDetailState(lessonData, id: id);
}

enum TtsState { playing, stopped }

class LessonDetailState extends State<LessonDetail> {
  LessonData lessonData;
  int id;

  LessonDetailState(this.lessonData, {this.id});

  // Related to TTS
  FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;
  String _newVoiceText;

  @override
  void initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    if (Platform.isAndroid) {
      flutterTts.ttsInitHandler(() {
        _getLanguages();
        _getVoices();
      });
    } else if (Platform.isIOS) {
      _getLanguages();
      _getVoices();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
    flutterTts.setLanguage('en-IN');
//    flutterTts.setLanguage('en-US');
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _getVoices() async {
    voices = await flutterTts.getVoices;
    if (voices != null) setState(() => voices);
  }

  Future _speak() async {
    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  // EOB: TTS

  playLesson() {
    _newVoiceText = lessonData.studyText;
    _speak();
  }

  @override
  Widget build(BuildContext context) {
    this.flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            _stop();
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Hero(
            tag: "lesson${lessonData.title}",
            child: Material(
              color: Colors.transparent,
              child: Text(
                lessonData.title,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (ttsState == TtsState.stopped) ? playLesson : _stop,
            icon: Icon(
              ((ttsState == TtsState.stopped) ? Icons.volume_up : Icons.cancel),
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: 1,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
          itemBuilder: (context, i) {
//            if (id == 3) {
//              return Padding(
//                  padding: EdgeInsets.fromLTRB(20, 30, 20, 40),
//                  child: Column(
//                    children: <Widget>[
//                      Text(
//                        lessonData.studyText,
//                        style: TextStyle(fontSize: 16, wordSpacing: 2),
//                      ),
//                      Padding(padding: EdgeInsets.only(bottom: 20)),
//                      YoutubePlayer(
//                        width: 360,
//                        context: context,
//                        source: "https://www.youtube.com/watch?v=1KwAhTF8cXg",
//                        quality: YoutubeQuality.HIGH,
//                        autoPlay: false,
//                        showVideoProgressbar: true,
//                        hideShareButton: true,
//                      ),
//                      Padding(padding: EdgeInsets.only(bottom: 20)),
//                      YoutubePlayer(
//                        width: 360,
//                        context: context,
//                        source: "https://www.youtube.com/watch?v=6_PiAF4wEFQ",
//                        quality: YoutubeQuality.HIGH,
//                        autoPlay: false,
//                        showVideoProgressbar: true,
//                        hideShareButton: true,
//                      ),
//                      Padding(padding: EdgeInsets.only(bottom: 20)),
//                      YoutubePlayer(
//                        width: 360,
//                        context: context,
//                        source: "https://www.youtube.com/watch?v=H8atgJjtJUI",
//                        quality: YoutubeQuality.HIGH,
//                        autoPlay: false,
//                        showVideoProgressbar: true,
//                        hideShareButton: true,
//                      )
//                    ],
//                  ));
//            }
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 40),
              child: Text(
                lessonData.studyText,
                style: TextStyle(fontSize: 16, wordSpacing: 2),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.assignment_turned_in,
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
        splashColor: Colors.lightBlueAccent,
        onPressed: () {
          _stop();
          if (id == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyLesson1Tests(lessonData)));
          }
          if (id == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyLesson2Tests(lessonData)));
          }
          if (id == 3) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyLesson3Tests(lessonData)));
          }
        },
        highlightElevation: 0,
        shape: CircleBorder(side: BorderSide(color: Colors.blue, width: 1)),
      ),
    );
  }
}
