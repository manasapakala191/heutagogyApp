import 'package:flutter/material.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_multiple_test.dart';
import 'package:heutagogy/models/test_type_models/math_match.dart';
import 'package:heutagogy/screens/widgets/customAppBar.dart';
import 'package:heutagogy/screens/widgets/slideHeading.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';


class DragDropMultipleScore extends StatelessWidget {
  final DragDropMultipleTest dragDropMultipleTest;
  final Progress progress;

  DragDropMultipleScore({this.dragDropMultipleTest,this.progress});
  @override
  Widget build(BuildContext context) {
    // print(progress.partsDone);
    // print(progress.total.toString()+"fjsjkgjk");
    return Scaffold(
        appBar: CustomAppBar(title: "Your Progress",),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              SlideHeader(testName: dragDropMultipleTest.testName,testDescription: dragDropMultipleTest.testDescription,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PieChartWidget(
                  right: progress.partsDone,
                  wrong: progress.total - progress.partsDone,
                ),
              ),
              ListTile(
                title: Text('Responses',style: GoogleFonts.varelaRound(fontSize: 20),),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DragDropMultipleResponseViewer(
                  dragDropMultipleTest: dragDropMultipleTest,
                  responseList: progress.responses,
                  // List.from(Map.from(responseMap["responses"]).values),
                ),
              )
            ],
          ),
        )
    );
  }
}


class DragDropMultipleResponseViewer extends StatelessWidget {
  final DragDropMultipleTest dragDropMultipleTest;
  final List responseList;
  DragDropMultipleResponseViewer({this.dragDropMultipleTest, this.responseList});

  final checkList = <bool>[];

  void getCheckList(){
    for(int i=0; i<dragDropMultipleTest.questions.length; i++){
      if(responseList[i] == dragDropMultipleTest.questions[i].first)
        checkList.add(true);
      else{
        checkList.add(false);
      }
    }
  }

  List<DataRow> getDataRows(BuildContext context){
    List<DataRow> dataRows = [];
    for(int j=0; j<dragDropMultipleTest.questions.length; j++){
      dataRows.add(DataRow(
          cells: [
            // DataCell(checkList[j] ? Icon(Icons.check, color: Colors.green,) : Icon(Icons.close, color: Colors.red,)),
            DataCell(Text(dragDropMultipleTest.questions[j].second,style: TextStyle(fontSize: 17),)),
            DataCell(
                Text(responseList[j] == null?"-":responseList[j],style: TextStyle(color: checkList[j] ? Colors.green : Colors.red,fontSize: 17),)),
            DataCell(Text(dragDropMultipleTest.questions[j].first,style: TextStyle(fontSize: 17)))
          ]
      ));
    }
    return dataRows;
  }
  @override
  Widget build(BuildContext context) {
    getCheckList();
    final _screensize=MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      child: DataTable(
        columnSpacing: 10,
        dataRowHeight: _screensize.height*0.07,
        columns: [
          // DataColumn(
          //   label: Icon(Icons.stacked_bar_chart)
          // ),
          DataColumn(
              label: Text('Questions',style: TextStyle(fontSize: 17))
          ),
          DataColumn(
              label: Text('Responses',style: TextStyle(fontSize: 17))
          ),
          DataColumn(
              label: Text('Correct',style: TextStyle(fontSize: 17))
          )
        ],
        rows: getDataRows(context),
      ),
    );
  }
}
