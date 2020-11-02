import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/studentProgress.dart';
import 'package:heutagogy/models/test_type_models/multiple_choice_question_test.dart';
import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/models/test_type_models/question_class.dart';
import 'package:faker/faker.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';


class MultipleChoiceImageQuestionScreen extends StatefulWidget {
  final ImageQuestionTest imageQuestionTest;
  MultipleChoiceImageQuestionScreen({this.imageQuestionTest});
  @override
  _MultipleChoiceImageQuestionScreenState createState() => _MultipleChoiceImageQuestionScreenState(this.imageQuestionTest);
}

class _MultipleChoiceImageQuestionScreenState extends State<MultipleChoiceImageQuestionScreen> {
  
  var choices=Map(),answers = Map();
  final ImageQuestionTest imageQuestionTest;
  _MultipleChoiceImageQuestionScreenState(this.imageQuestionTest);

  void initState(){
    for(var _ in imageQuestionTest.questions){
      choices[_.question] = null;
      answers[_.question] = false;
    }
    print(choices);
    print(answers);
  }

  void _updateProgress(){
    var progress = Provider.of<StudentProgress>(context,listen: false);
    List<String> responses = List<String>();
    for(var _ in choices.values){
      responses.add(_);
    }
    print(responses);
    progress.addResponses("5",responses);
    int count = 0, total = 0;
    for(var _ in answers.values){
      if(_){
        count++;
      }
      total++;
    }
    progress.setPerformance("5", count, total);
    DatabaseService().writeProgress(progress.getPerformance(), "5");
  }

  // final ImageQuestionTest imageQuestionTest = ImageQuestionTest(
  //   testName: faker.lorem.word(),
  //   subject: faker.lorem.word(),
  //   testDescription: faker.lorem.sentence(),
  //   questions: List.generate(10, (index) => ImageQuestionData(
  //     question: faker.lorem.sentence(),
  //     options: [
  //       ImageChoice(
  //         text: faker.lorem.word(),
  //         correct: faker.randomGenerator.boolean(),
  //         picture: 'https://picsum.photos/200'
  //       ),
  //       ImageChoice(
  //           text: faker.lorem.word(),
  //           correct: faker.randomGenerator.boolean(),
  //           picture: 'https://picsum.photos/200'
  //       ),
  //       ImageChoice(
  //           text: faker.lorem.word(),
  //           correct: faker.randomGenerator.boolean(),
  //           picture: 'https://picsum.photos/200'
  //       ),
  //       ImageChoice(
  //           text: faker.lorem.word(),
  //           correct: faker.randomGenerator.boolean(),
  //           picture: 'https://picsum.photos/200'
  //       )
  //     ]
  //   ))
  // );

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
                children: imageQuestionTest.questions.map((e) => QuestionWidget(e,this.choices,this.answers)).toList(),
              ),
              SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: RaisedButton(
                onPressed: (){
                  _updateProgress();
                  Navigator.pop(context);
                },
                elevation: 8,
                child: Text("Submit"),
                color: HexColor("#ed2a26"),
              ),
            )
            ],
          )
      ),
    );
  }
}


class QuestionWidget extends StatelessWidget {
  final ImageQuestionData question;
  final Map choices,answers;
  QuestionWidget(this.question,this.choices,this.answers);
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
          ImageOptionBuilder(question.options,this.choices,this.answers,question.question),
        ],
      ),
    );
  }
}


class ImageOptionBuilder extends StatefulWidget {
  final List<ImageChoice> options;
  final Map choices,answers;
  final String question;
  ImageOptionBuilder(this.options,this.choices,this.answers,this.question);
  @override
  _ImageOptionBuilderState createState() => _ImageOptionBuilderState(this.choices,this.answers,this.question);
}

class _ImageOptionBuilderState extends State<ImageOptionBuilder> {

  int groupValue = -1;

  int i=0;
  Map choices,answers;
  String question;

  _ImageOptionBuilderState(this.choices,this.answers,this.question);

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
                if(widget.options[index].correct){
                  choices[this.question] = widget.options[index].text;
                  answers[this.question] = true;
                }
                else{
                  choices[this.question] = widget.options[index].text;
                }
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
