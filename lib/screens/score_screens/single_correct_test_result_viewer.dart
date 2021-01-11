import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/multiple_choice_question_test.dart';
import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/models/test_type_models/question_class.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';

class SingleCorrectResultViewer extends StatelessWidget {
  final Progress progress;
  final SingleCorrectTest singleCorrectTest;
  SingleCorrectResultViewer({this.progress, this.singleCorrectTest});
  @override
  Widget build(BuildContext context) {
    // var total = responseMap['totalQuestions'];
    // var correct = responseMap['correctAnswers'];
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PieChartWidget(
                        right:  progress.partsDone,
                        wrong: progress.total - progress.partsDone,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Responses',style: GoogleFonts.varelaRound(fontSize: 20),),
                  ),
                  ListTile(
                    title: Text(singleCorrectTest.testName),
                    subtitle: Text(singleCorrectTest.testDescription),
                    trailing: Text(singleCorrectTest.subject),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: singleCorrectTest.questions.length,
                      itemBuilder: (context,index){
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: QuestionResponseViewer(
                        questionData: singleCorrectTest.questions[index],
                        responseList: progress.responses,
                        idx: index,
                      ),
                    );
                  })
                ]
            )
          ],
        ),
      ),
    );
  }
}

class QuestionResponseViewer extends StatelessWidget {
  final QuestionData questionData;
  final List responseList;
  int idx;
  QuestionResponseViewer({this.questionData, this.responseList,this.idx});

  Widget check(int index, Option option){
    if(option.choice == true){
      return Icon(Icons.check, color: Colors.green,);
    }else{
      if(responseList[index] == option.text){
        return Icon(Icons.close, color: Colors.red,);
      }else{
        return SizedBox(
          height: 10,
          width: 10,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(questionData.text),
          Image.network(questionData.image),
          Column(
            children: questionData.options.map((e) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                margin: EdgeInsets.all(7),
                child:ListTile(
                  title: Text(e.text),
                  trailing: check(idx, e),
                )
              )
            )).toList(),
          )
        ],
      ),
    );
  }
}
