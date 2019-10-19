import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'my_step_progress.dart';

class LessonDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LessonDetailState();
}

enum TtsState { playing, stopped }

class LessonDetailState extends State<LessonDetail> {
  String lessonDetail =
    "Sujay was a class II student. He was fond of cats. He asked his parents to give permission to have a kitten as his pet. His parents asked him to earn the permission by winning a running race in the competition held by their colony people. Sujay agreed. He participated in the running race. The participants were standing in a row. Sujay counted them. they were 20. They had numbers on their shirts.\n\n Sujay noticed that they were not standing in proper sequence. He told his father. His father arranged them in proper sequence from number 1 to 20. When the race was about to begin, Sujay realized that he was standing in a wrong place. His number was 11. He was standing between 9 and 11. He changed his position and stood between 10 and 12. The race started. Sujay put all his efforts and won the race.\n\nThe next morning was Sujay’s birthday. His father arranged a party. His relatives and friends attended the party. Sujay gave plants as return gift to his friends and relatives. His grand father and grand mother were teachers. They gifted him an education kit. His aunt was a nurse and his uncle was a bank manager. They gifted him a business game.\n\n His friends gifted him different kinds of pens and sketches. Sujay was so happy. His father and mother gifted him a little kitten. He named it Gifty. Sujay’s dad was a forest officer. He had his duty in the forest during day time. Gifty was so cute. Sujay played with it after his school. \n\nOne day when he returned home, he found that Gifty was missing. He was afraid and sad. He could not sleep that night. He kept weeping. His father’s friend was a police. He helped Sujay and his family in searching the kitten in the forest the next day. Sujay was entering the forest for the first time. He saw different types of vegetation in the forest. There were vegetable and fruit gardens in the entrance of the forest.\n\nWhen Sujay asked about them, his father said that he encouraged the villagers to grow kitchen gardens in the entrance of the forest that could help them have organic vegetables and fruits for their survival. They were growing brinjal, potato, banana, guava, leafy vegetables, jack fruit etc., He remembered his Telugu lesson in the school, “sandade sandadi” He started humming the song and was imagining how it could be if all these vegetables and fruits danced and performed brinjal’s wedding as said in his lesson. \n\nHe was surprised to see many animals and birds in the forest. He saw a peacock that was dancing, a cuckoo that was singing, a parrot that was chattering, a pig that was grunting, a horse that was neighing, a dog that was barking etc.,They kept searching for Gifty. Sujay heard the cries of Gifty when they were in the middle of that forest. He told his police uncle to search the place from where the cries were heard. \n\nAt last they found her stuck in thick creepers. Gifty was so relieved after seeing Sujay. She stopping meowing. Sujay identified scratches on her back and legs. It was weak. They took her to one of Sujay’s father’s friend who was a veterinary doctor. The doctor gave an injection to Gifty and asked Sujay to relax. After the treatment, they took her home.  Gifty never went into the forest again. ";


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
    _newVoiceText = lessonDetail;
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
                  lessonDetail,
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
        child: Icon(Icons.assignment_turned_in),
        onPressed: () {
          _stop();
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyProgressPage()));
        },
        highlightElevation: 0,
        splashColor: Colors.white,
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
////        foregroundColor: Color.fromRGBO(16, 75, 200, 1),
////        backgroundColor: Colors.white,
////        shape: RoundedRectangleBorder(
////          borderRadius: BorderRadius.circular(50),
////          side: BorderSide(color: Color.fromRGBO(16, 75, 200, 1)),
////        ),
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
