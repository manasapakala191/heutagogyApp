import 'package:flutter/material.dart';
import 'package:faker/faker.dart' as faker;
import 'package:heutagogy/screens/score_screens/fill_in_the_blanks_result_viewer.dart';

class FillInTheBlankType extends StatelessWidget {
  final questions = List.generate(
      3,
      (index) => {
            'question': faker.faker.lorem.sentence(),
            'correctText': faker.faker.lorem.word()
          });

  final answers = List.generate(3, (index) => '');

  final responseMap = {
    'totalQuestions': 0,
    'correctAnswers': 0,
  };

  void evaluateResponses() {
    responseMap['totalQuestions'] = questions.length;
    for (int i = 0; i < questions.length; i++) {
      if (questions[i]['correctText'] == answers[i]) {
        responseMap['correctAnswers'] = responseMap['correctAnswers'] + 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.of(context).pop();
          }),
          title: Text('Fill in the blanks'),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: ListTile(title: Text('Fill in the blanks')),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: questions.length + 1,
                        itemBuilder: (context, index) => index == questions.length ? RaisedButton(
                    child: Text('Submit'),
                    color: Colors.white,
                    elevation: 100,
                    onPressed: () {
                    evaluateResponses();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FillInTheBlanksResultViewer(
                              answers: answers,
                              questions: questions,
                              responseMap: responseMap,
                            )));
                  }) : Card(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  width: MediaQuery.of(context).size.width,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 10, 5, 20),
                                        child: Text(questions
                                            .elementAt(index)['question']),
                                      ),
                                      TextField(
                                        onChanged: (val) {
                                          answers[index] = val;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Enter your answer here!!',
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                        ),
                                      )
                                    ],
                                  )),
                            ))),
              ],
            )));
  }
}
