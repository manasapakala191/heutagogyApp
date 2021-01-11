// import 'package:flutter/material.dart';

// class DragDropScoreWidget extends StatelessWidget {

//   final Map<String,dynamic> correct;
//   final Map<String,dynamic> choices;

//   DragDropScoreWidget({this.correct,this.choices});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/test_type_models/match_audio.dart';
import 'package:heutagogy/models/test_type_models/multiple_choice_question_test.dart';
import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/models/test_type_models/question_class.dart';
import 'package:heutagogy/screens/score_screens/line_chart_widget.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';

class DragDropScoreWidget extends StatelessWidget {
  final Map<String,dynamic> responseMap;
  final DragDropAudioTest questionTest;
  DragDropScoreWidget({this.responseMap, this.questionTest});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PieChartWidget(
                // wrong: responseMap['totalQuestions'] - responseMap['correctAnswers'] ,
                wrong: 2,
                right: 1,
                // right: responseMap['correctAnswers'],
              ),
            ),
            ListTile(
              title: Text('Responses',style: GoogleFonts.varelaRound(fontSize: 20),),
            ),
            ListTile(
              title: Text("testname"),
              subtitle: Text("test description"),
              trailing: Text("subject"),
            ),
            Column(
              children: questionTest.audios.map((e) => SizedBox(
                width: MediaQuery.of(context).size.width,
                child: AudioQuestionResponseViewer(
                  responseMap: responseMap,
                  questionData: e,
                ),
              )).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class AudioQuestionResponseViewer extends StatelessWidget {
  final AudioPair questionData;
  final Map<String, dynamic> responseMap;

  AudioQuestionResponseViewer({this.questionData, this.responseMap});

  // Widget check(String question, ImageChoice option){
  //   if(option.correct == true){
  //     return Text('Correct', style: GoogleFonts.varelaRound(color: Colors.green),);
  //   }else{
  //     if(responseMap[question] == option.text){
  //       return Text('Wrong', style: GoogleFonts.varelaRound(color: Colors.red));
  //     }else{
  //       return SizedBox(
  //         height: 1,
  //         width: 1,
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("mm"),
          ),
          // Column(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Row(
          //       mainAxisSize: MainAxisSize.max,
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width/3,
          //           child: OptionWidget(option: questionData.options[0],
          //           widget: check(questionData.question, questionData.options[0]),),
          //         ),
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width/3,
          //           child: OptionWidget(option: questionData.options[1],
          //           widget: check(questionData.question, questionData.options[1]),
          //           ),
          //         ),
          //       ],
          //     ),
          //     Row(
          //       mainAxisSize: MainAxisSize.max,
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width/3,
          //           child: OptionWidget(option: questionData.options[2],
          //           widget: check(questionData.question, questionData.options[2]),
          //           ),
          //         ),
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width/3,
          //           child: OptionWidget(option: questionData.options[3],
          //           widget: check(questionData.question, questionData.options[3]),
          //           ),
          //         ),
          //       ],
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}

// class OptionWidget extends StatelessWidget {
//   final ImageChoice option;
//   final Widget widget;
//   OptionWidget({this.option, this.widget});
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 10,
//       margin: EdgeInsets.all(3),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               widget
//             ],
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height/4,
//             child: Image.network(option.picture, fit: BoxFit.contain,),
//           )
//         ],
//       ),
//     );
//   }
// }