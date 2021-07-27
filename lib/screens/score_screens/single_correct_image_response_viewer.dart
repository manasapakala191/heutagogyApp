import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/multiple_choice_question_test.dart';
import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/models/test_type_models/question_class.dart';
import 'package:heutagogy/screens/widgets/customAppBar.dart';
import 'package:heutagogy/screens/widgets/slideHeading.dart';
import 'package:heutagogy/screens/score_screens/line_chart_widget.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';

class SingleCorrectImageResponseViewer extends StatelessWidget {
  final Progress progress;
  final ImageQuestionTest imageQuestionTest;
  SingleCorrectImageResponseViewer({this.progress, this.imageQuestionTest});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Your Progress',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            SlideHeader(
              testName: imageQuestionTest.testName,
              testDescription: imageQuestionTest.testDescription,
            ),
            Container(
              height: 300,
              padding: const EdgeInsets.all(8.0),
              child: PieChartWidget(
                wrong: progress.total-progress.partsDone ,
                right: progress.partsDone
              ),
            ),
            ListTile(
              title: Text('Responses',style: GoogleFonts.varelaRound(fontSize: 20),),
            ),
            ListView.builder(
              itemCount: imageQuestionTest.questions.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context,index){
                return  SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ImageQuestionResponseViewer(
                    responseList: progress.responses,
                    imageQuestionData: imageQuestionTest.questions[index],
                    idx: index,
                  ),
                );
                })
          ],
        ),
      ),
    );
  }
}

class ImageQuestionResponseViewer extends StatelessWidget {
  final ImageQuestionData imageQuestionData;
  final List responseList;
  int idx;
  ImageQuestionResponseViewer({this.imageQuestionData, this.responseList,this.idx});

  Widget check(int index, ImageChoice option){
    if(option.correct == true){
      return Text('Correct', style: GoogleFonts.varelaRound(color: Colors.green),);
    }else{
      if(responseList[index] == option.text){
        return Text('Wrong', style: GoogleFonts.varelaRound(color: Colors.red));
      }else{
        return SizedBox(
          height: 1,
          width: 1,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              title: Text(imageQuestionData.question),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width/3,
                      child: OptionWidget(option: imageQuestionData.options[0],
                      widget: check(idx, imageQuestionData.options[0]),),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/3,
                      child: OptionWidget(option: imageQuestionData.options[1],
                      widget: check(idx, imageQuestionData.options[1]),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width/3,
                      child: OptionWidget(option: imageQuestionData.options[2],
                      widget: check(idx, imageQuestionData.options[2]),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/3,
                      child: OptionWidget(option: imageQuestionData.options[3],
                      widget: check(idx, imageQuestionData.options[3]),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  final ImageChoice option;
  final Widget widget;
  OptionWidget({this.option, this.widget});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height/4,
            child: Image.network(option.picture, fit: BoxFit.contain,),
          )
        ],
      ),
    );
  }
}


