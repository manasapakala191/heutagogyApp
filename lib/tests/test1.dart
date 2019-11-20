import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heutagogy/data_models.dart';

import 'animated_button.dart';

class Test1Page extends StatefulWidget {
  final Test1Data test1data;
  Test1Page(this.test1data);

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
        children: _buildQuestions(),
      ),
    );
  }

  List<Widget> _buildQuestions() {
    List<Widget> questionsList = [];
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
        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(
                child: Text(
              "Q. ${question.text}",
              style: TextStyle(fontSize: 18),
            )),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Wrap(
              // runAlignment: WrapAlignment.spaceEvenly,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: _buildChildren(),
            ),
          ],
        ));
  }

  List<Widget> _buildChildren() {
    List<Widget> children = [];
    ButtonStyle correctButtonStyle = ButtonStyle(
        initialColour: Colors.blueAccent,
        finalColour: Colors.white10,
        intialTextstyle: TextStyle(fontSize: 12, color: Colors.white),
        finalTextStyle: TextStyle(fontSize: 12, color: Colors.green),
        elevation: 3);
    ButtonStyle incorrectButtonStyle = ButtonStyle(
        initialColour: Colors.blueAccent,
        finalColour: Colors.white10,
        intialTextstyle: TextStyle(fontSize: 12, color: Colors.white),
        finalTextStyle: TextStyle(fontSize: 12, color: Colors.red),
        elevation: 3);
    for (ChoiceData x in question.options) {
      children.add(Padding(
          padding: EdgeInsets.all(5),
          child: AnimatedButton(
            initialText: x.text,
            finalText: x.correct ? "Correct" : "Wrong",
            buttonStyle: x.correct ? correctButtonStyle : incorrectButtonStyle,
            animationduration: Duration(seconds: 1),
            iconData: x.correct ? Icons.check : Icons.close,
            iconsize: 12,
            onTap: () {},
            radius: 14,
          )));
    }
    return children;
  }
}
