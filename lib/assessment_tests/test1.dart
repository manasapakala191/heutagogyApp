import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heutagogy/data_models.dart';
//import 'package:youtube_player/youtube_player.dart';

import 'animated_button.dart';

class Test1Page extends StatefulWidget {
  final Test1Data test1data;

  Test1Page(this.test1data, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Test1PageState(test1data);
}

class Test1PageState extends State<Test1Page> {
  Test1Data data;

  Test1PageState(this.data);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 50),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: _buildQuestions((this.data.heading != "" && this.data.heading != null)),
      ),
    );
  }

  List<Widget> _buildQuestions(bool addHeading) {
    List<Widget> questionsList = [];
    if (addHeading) {
      questionsList.add(Center(
        child: Text(
          this.data.heading,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ));
    }
    for (var x in data.questions) {
      questionsList.add(Padding(
        padding: EdgeInsets.only(bottom: 20),
      ));
      questionsList.add(QuestionWidget(
        question: x,
      ));
    }
    return questionsList;
  }
}

class QuestionWidget extends StatefulWidget {
  final QuestionData question;

  QuestionWidget({this.question});

  @override
  State<StatefulWidget> createState() => QuestionWidgetState(question);
}

class QuestionWidgetState extends State<StatefulWidget> {
  QuestionData question;

  QuestionWidgetState(this.question);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "Q. ${question.text}",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
//            (question.youtubeVideo != "" && question.youtubeVideo != null)
//                ? YoutubePlayer(
//                    width: 360,
//                    context: context,
//                    source: question.youtubeVideo,
//                    quality: YoutubeQuality.HIGH,
//                    autoPlay: false,
//                    showVideoProgressbar: true,
//                  )
//                :
            (question.image != "")
                    ? CachedNetworkImage(
                        imageUrl: question.image,
                        width: 256,
                        placeholder: (context, data) => CircularProgressIndicator(),
                        placeholderFadeInDuration: Duration(seconds: 1),
                      )
                    : Container(),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Wrap(
              // runAlignment: WrapAlignment.spaceEvenly,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: _buildChildren(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
          ],
        ));
  }

  List<Widget> _buildChildren() {
    List<Widget> children = [];
    ButtonStyle buttonStyle = ButtonStyle(
        initialColour: Colors.blueAccent,
        finalColour: Colors.white10,
        intialTextstyle: TextStyle(fontSize: 14, color: Colors.white),
        finalTextStyle: TextStyle(fontSize: 16, color: Colors.blueAccent),
        elevation: 3);
    for (ChoiceData x in question.options) {
      children.add(Padding(
          padding: EdgeInsets.all(5),
          child: AnimatedButton(
            initialText: x.text,
            finalText: x.text,
            buttonStyle: buttonStyle,
            animationduration: Duration(seconds: 1),
            iconData: Icons.check,
            iconsize: 14,
            radius: 14,
          )));
    }
    return children;
  }
}
