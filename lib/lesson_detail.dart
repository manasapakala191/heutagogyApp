import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:heutagogy/data_models.dart';
import 'my_step_progress.dart';

class LessonDetail extends StatefulWidget {
  final LessonData lessonData;
  LessonDetail(this.lessonData);
  @override
  State<StatefulWidget> createState() => LessonDetailState(lessonData);
}

enum TtsState { playing, stopped }

class LessonDetailState extends State<LessonDetail> {
  LessonData lessonData;
  LessonDetailState(this.lessonData);
  
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
          child: Text(
            'Lesson 1: Story',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (ttsState == TtsState.stopped) ? playLesson : _stop,
            icon: Icon( ( (ttsState == TtsState.stopped)?
              Icons.volume_up : Icons.cancel),
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
            if (i == 0) {
              return Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 40),
                child: Text(
                  lessonData.studyText,
                  style: TextStyle(fontSize: 16, wordSpacing: 2),
                ),
              );
            } else {
              return ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  "Overview",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                children: <Widget>[
                  Column(
                    children: _buildExpandableTile(lessons, i),
                  ),
                ],
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.assignment_turned_in, color: Colors.blue,),
        backgroundColor: Colors.white,
        splashColor: Colors.lightBlueAccent,
        onPressed: () {
          _stop();
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyProgressPage(lessonData)));
        },
        highlightElevation: 0,
        shape: CircleBorder(side: BorderSide(color: Colors.blue, width: 1)),
      ),
    );
  }
}

_buildExpandableTile(List<Lesson> lesson, int i) {
  return <Widget>[
    Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Text(lesson[i - 1].lessonText),
    ),
    Padding(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
    ),
  ];
}

class Lesson {
  final String lessonTitle;
  final String lessonText;

  Lesson(this.lessonTitle, this.lessonText);
}

List<Lesson> lessons = [
  new Lesson(
      "The last Lesson",
      "st fuga, labore quos soluta ut quidem obcaecati hic voluptatibus commodi doloremque officii" +
          "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quo officia beatae, officiis ab, " +
          "obcaecati dignissimos ipsum unde nihil, at fugiat recusandae. Voluptates provident a perfer" +
          "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique maiores hic quisquam na" +
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus, reiciendis debitis obca" +
          "ecati a pariatur provident inventore sit. Placeat tenetur mollitia quaerat nisi ratione min" +
          "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eveniet, neque alias? Dolores pra" +
          "esentium provident, aliquam doloribus eligendi iste tempore modi id fuga accusamus. Molesti" +
          "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Soluta, numquam. Nesciunt illum i"),
  new Lesson(
      "Something Else",
      "st fuga, labore quos soluta ut quidem obcaecati hic voluptatibus commodi doloremque officii" +
          "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quo officia beatae, officiis ab, " +
          "obcaecati dignissimos ipsum unde nihil, at fugiat recusandae. Voluptates provident a perfer" +
          "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique maiores hic quisquam na" +
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus, reiciendis debitis obca" +
          "ecati a pariatur provident inventore sit. Placeat tenetur mollitia quaerat nisi ratione min" +
          "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eveniet, neque alias? Dolores pra" +
          "esentium provident, aliquam doloribus eligendi iste tempore modi id fuga accusamus. Molesti" +
          "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Soluta, numquam. Nesciunt illum i"),
];

//
//class LessonDetail extends StatefulWidget {
//  @override
//  LessonDetailState createState() => LessonDetailState();
//}
//
//class LessonDetailState extends State<LessonDetail> {
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        elevation: 3,
//        leading: IconButton(
//          icon: Icon(
//            Icons.arrow_back_ios,
//            color: Colors.black,
//          ),
//          onPressed: () {},
//        ),
//        backgroundColor: Colors.white,
//        title: Center(
//          child: Text(
//            'Lesson 1: Words',
//            style: TextStyle(color: Colors.black),
//          ),
//        ),
//        actions: <Widget>[
//          IconButton(
//            onPressed: () {},
//            icon: Icon(
//              Icons.volume_up,
//              color: Colors.black,
//            ),
//          ),
//          Padding(
//            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
//          ),
//        ],
//      ),
//      body: Container(
//        color: Colors.white,
//        child: Column(
//          children: <Widget>[
//            Expanded(
//              child: SingleChildScrollView(
//                child: Padding(
//                  padding: EdgeInsets.fromLTRB(30, 25, 30, 75),
//                  child: RichText(
//                    text: TextSpan(
//                        style: TextStyle(color: Colors.black, wordSpacing: 1),
//                        children: <TextSpan>[
//                          TextSpan(text: "A Simple Heading.\n", style: TextStyle(fontSize: 20)),
//                          TextSpan(
//                              text: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Corporis quod, suscipit possimus q" +
//                                  "uas minima nobis saepe, inventore accusantium molestiae eius ad libero repudiandae? Sit, di" +
//                                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptates deleniti a ullam suscip" +
//                                  "it. Dolore modi voluptas perspiciatis, dolor in quo sint cumque maiores, quia deleniti accu" +
//                                  "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Incidunt quibusdam quam porro, co" +
//                                  "expedita rerum assumenda exercitationem hic laudanti\n\n"),
//                          TextSpan(
//                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Arial'),
//                              text: "nsectetur cupiditate, vero nam dolorum "),
//                          TextSpan(
//                              text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Numquam iste consectetur sequi! E" +
//                                  "plicabo consequatur facilis? Cupiditate unde, iusto ad placeat numquam ipsa ipsum vero odio" +
//                                  "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Voluptatem aspernatur officiis fa" +
//                                  "cilis, cum similique magnam dolorem dignissimos delectus quaerat rerum. Tempore dolores et " +
//                                  "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nobis, aliquam itaque. Labore ear" +
//                                  "um pariatur sint dolore ad, nihil quasi laboriosam quod porro tempora aperiam nesciunt, cup\n\n"),
//                          TextSpan(
//                              text: "Another Heading.\n",
//                              style: TextStyle(fontSize: 20, decoration: TextDecoration.underline)),
//                          TextSpan(
//                            style: TextStyle(color: Colors.blue),
//                            text: "st fuga, labore quos soluta ut quidem obcaecati hic voluptatibus commodi doloremque officii" +
//                                "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Quo officia beatae, officiis ab, " +
//                                "obcaecati dignissimos ipsum unde nihil, at fugiat recusandae. Voluptates provident a perfer" +
//                                "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique maiores hic quisquam na" +
//                                "Lorem ipsum dolor sit amet consectetur adipisicing elit. Doloribus, reiciendis debitis obca" +
//                                "ecati a pariatur provident inventore sit. Placeat tenetur mollitia quaerat nisi ratione min" +
//                                "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eveniet, neque alias? Dolores pra" +
//                                "esentium provident, aliquam doloribus eligendi iste tempore modi id fuga accusamus. Molesti" +
//                                "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Soluta, numquam. Nesciunt illum i" +
//                                "usto laborum eum? Dolore eum facere esse corporis quaerat consectetur ex porro ullam accusa" +
//                                "Lorem ipsum dolor sit amet consectetur, adipisicing elit. Repudiandae accusamus delectus ex\n\n",
//                          ),
//                          TextSpan(text: "A Simple Heading.\n", style: TextStyle(fontSize: 20)),
//                          TextSpan(
//                              style: TextStyle(fontStyle: FontStyle.italic),
//                              text: "m nisi sapiente officiis nostrum fugit deleniti mollitia voluptatibus molestiae, vitae volu" +
//                                  "Lorem ipsum dolor sit amet consectetur, adipisicing elit. Fugiat sunt minima ab, commodi qu" +
//                                  "os incidunt facere quis beatae vitae aspernatur. Laudantium repellat distinctio perspiciati" +
//                                  "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Laudantium aspernatur illo alias." +
//                                  " Assumenda blanditiis et quibusdam eum dignissimos atque sequi ipsum inventore, vitae dolor" +
//                                  "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Harum nulla dolorem aperiam corru" +
//                                  "pti expedita sapiente ipsum quo est ipsam repellendus deleniti itaque veniam dignissimos, v" +
//                                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Vero totam cum quo, odio cumque do" +
//                                  "lorem itaque maxime, animi, sit quisquam beatae consectetur fugit explicabo neque voluptas!" +
//                                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Deleniti magni eum, quae rem tempo" +
//                                  "ribus blanditiis maiores animi autem pariatur! Sunt, animi at inventore dignissimos consequ\n"),
//                        ]),
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: () {
//          Navigator.push(context, MaterialPageRoute(builder: (context) => App2()));
//        },
//        highlightElevation: 0,
//        splashColor: Colors.white,
//        foregroundColor: Color.fromRGBO(16, 75, 200, 1),
//        backgroundColor: Colors.white,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(50),
//          side: BorderSide(color: Color.fromRGBO(16, 75, 200, 1)),
//        ),
//        label: Text(
//          'Start Exam',
//          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//        ),
//        icon: Icon(Icons.arrow_forward),
//      ),
//    );
//  }
//}

// -------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------
