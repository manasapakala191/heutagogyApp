import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/test_type_models/multiple_choice_question_test.dart';
import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/models/test_type_models/question_class.dart';
import 'package:faker/faker.dart';


class MultipleChoiceImageQuestionScreen extends StatelessWidget {

  final ImageQuestionTest imageQuestionTest = ImageQuestionTest(
    testName: faker.lorem.word(),
    subject: faker.lorem.word(),
    testDescription: faker.lorem.sentence(),
    questions: List.generate(10, (index) => ImageQuestionData(
      question: faker.lorem.sentence(),
      options: [
        ImageChoice(
          text: faker.lorem.word(),
          correct: faker.randomGenerator.boolean(),
          picture: 'https://picsum.photos/200'
        ),
        ImageChoice(
            text: faker.lorem.word(),
            correct: faker.randomGenerator.boolean(),
            picture: 'https://picsum.photos/200'
        ),
        ImageChoice(
            text: faker.lorem.word(),
            correct: faker.randomGenerator.boolean(),
            picture: 'https://picsum.photos/200'
        ),
        ImageChoice(
            text: faker.lorem.word(),
            correct: faker.randomGenerator.boolean(),
            picture: 'https://picsum.photos/200'
        )
      ]
    ))
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageQuestionTest.subject),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(
          color: HexColor("#ed2a26"),
        ),
        iconTheme: IconThemeData(
          color: HexColor("#ed2a26"),
        ),
      ),
      // appBar: AppBar(
      //   title: Text(imageQuestionTest.subject),
      //   backgroundColor: HexColor('#ed2a26'),
      // ),
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
                      title: Text('${imageQuestionTest.testName}'),
                      subtitle: Text('${imageQuestionTest.testDescription}'),
                      isThreeLine: true,
                    ),
                  ],
                ),
              ),
              Column(
                children: imageQuestionTest.questions.map((e) => QuestionWidget(question: e,)).toList(),
              )
            ],
          )
      ),
    );
  }
}


class QuestionWidget extends StatelessWidget {
  final ImageQuestionData question;
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
            child: Text(question.question),
          ),
          ImageOptionBuilder(options: question.options,)
        ],
      ),
    );
  }
}


class ImageOptionBuilder extends StatefulWidget {
  final List<ImageChoice> options;
  ImageOptionBuilder({this.options});
  @override
  _ImageOptionBuilderState createState() => _ImageOptionBuilderState();
}

class _ImageOptionBuilderState extends State<ImageOptionBuilder> {

  int groupValue = -1;

  int i=0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*3/5,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
          itemCount: widget.options.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) => RadioListTile(
            onChanged: (int val){
              setState(() {
                groupValue = val;
              });
            },
            value: i++%4,
            groupValue: groupValue,
            title: Image.network(
              widget.options[index].picture,
              // scale: 1.5,
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width/3,
            ),
          )
      ),
    );
  }
}
