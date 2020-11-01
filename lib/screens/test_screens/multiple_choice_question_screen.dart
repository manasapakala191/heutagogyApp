import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/test_type_models/multiple_choice_question_test.dart';
import 'package:faker/faker.dart';
import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/models/test_type_models/question_class.dart';
import 'package:heutagogy/models/time_object_model.dart';

class MultipleChoiceQuestionScreen extends StatefulWidget {
  @override
  _MultipleChoiceQuestionScreenState createState() => _MultipleChoiceQuestionScreenState();
}

class _MultipleChoiceQuestionScreenState extends State<MultipleChoiceQuestionScreen> {

  final TimeObject timeObject = TimeObject(
    screen: 'Multiple Choice Questions Screen',
    courseId: 'Default Course ID',
    testId: 'Default Test ID'
  );

  final SingleCorrectTest singleCorrectTest = SingleCorrectTest(
    testName: "Test",
    subject: "Lorem Ipsum",
    testDescription: "Simple test description",
    questions: List.generate(10, (index) => QuestionData(
        text: faker.lorem.sentence(),
        options: [
          Option(
              text: faker.lorem.sentence().substring(0, 10),
              choice: faker.randomGenerator.boolean()
          ),
          Option(
              text: faker.lorem.sentence().substring(0, 10),
              choice: faker.randomGenerator.boolean()
          ),
          Option(
              text: faker.lorem.sentence().substring(0, 10),
              choice: faker.randomGenerator.boolean()
          ),
          Option(
              text: faker.lorem.sentence().substring(0, 10),
              choice: faker.randomGenerator.boolean()
          ),
        ]
    ))
  );

  @override
  void initState(){
    timeObject.setStartTime(DateTime.now());
    super.initState();
  }

  @override
  void dispose(){
    timeObject.setEndTime(DateTime.now());
    timeObject.addTimeObjectToStudentPerformance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeObject.getStudent(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${singleCorrectTest.subject}'),
        backgroundColor: HexColor("#ed2a26"),
      ),
      backgroundColor: HexColor('#f7f7f7'),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7))
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: HexColor("#ed2a26"),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(7), topLeft: Radius.circular(7))
                    ),
                  ),
                  ListTile(
                    title: Text('${singleCorrectTest.testName}'),
                    subtitle: Text('${singleCorrectTest.testDescription}'),
                    isThreeLine: true,
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(
                singleCorrectTest.questions.length, 
                (index) => QuestionWidget(question: singleCorrectTest.questions[index])
              ),
            )
          ],
        )
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final QuestionData question;
  QuestionWidget({this.question});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            blurRadius: 3
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.all(7),
            child: Text(question.text),
          ),
          OptionBuilder(options: question.options,)
        ],
      ),
    );
  }
}

class OptionBuilder extends StatefulWidget {
  final List<Option> options;
  OptionBuilder({this.options});
  @override
  _OptionBuilderState createState() => _OptionBuilderState();
}

class _OptionBuilderState extends State<OptionBuilder> {
  int groupValue = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.options.length, (index) => RadioListTile(
          groupValue: groupValue,
          value: index,
          title: Text('${widget.options[index].text}'),
          onChanged: (int val) {
            setState(() {
              groupValue = val;
            });
          },
          activeColor: HexColor('#ed2a26'),
        ))
    );
  }
}