import 'package:flutter/material.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_multiple_test.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_order_test.dart';
import 'package:heutagogy/screens/widgets/customAppBar.dart';
import 'package:heutagogy/screens/widgets/slideHeading.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';


class DragDropOrderScore extends StatelessWidget {
  final DragDropOrderTest dragDropOrderTest;
  final Progress progress;

  DragDropOrderScore({this.dragDropOrderTest,this.progress});
  @override
  Widget build(BuildContext context) {
    final _screenSize=MediaQuery.of(context).size;
    return Scaffold(
        appBar: CustomAppBar(
          title: "Your Progress",
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                SlideHeader(testName: dragDropOrderTest.testName,testDescription: dragDropOrderTest.testDescription,),
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
                  child: DragDropOrderResponseViewer(
                    dragDropOrderTest: dragDropOrderTest,
                    responseList: progress.responses,
                    // List.from(Map.from(responseMap["responses"]).values),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}


class DragDropOrderResponseViewer extends StatelessWidget {
  final DragDropOrderTest dragDropOrderTest;
  final List responseList;
  DragDropOrderResponseViewer({this.dragDropOrderTest, this.responseList});

  final checkList = <bool>[];

  listToString(List<String> listStr){
    String answer="";
    for(int i=0;i<listStr.length;i++){
      answer+=" "+listStr[i];
    }
    return answer.trim();
  }
  void getCheckList(){
    for(int i=0; i<dragDropOrderTest.questions.length; i++){
      if(responseList[i] == listToString(dragDropOrderTest.questions[i].elements))
        checkList.add(true);
      else{
        checkList.add(false);
      }
    }
  }

  List<DataRow> getDataRows(BuildContext context){
    List<DataRow> dataRows = [];
    for(int j=0; j<dragDropOrderTest.questions.length; j++){
      dataRows.add(DataRow(
          cells: [
            // DataCell(checkList[j] ? Icon(Icons.check, color: Colors.green,) : Icon(Icons.close, color: Colors.red,)),
            DataCell(Text(j.toString(),style: TextStyle(fontSize: 18),)),
            DataCell(
                Text(responseList[j] == null?"-":responseList[j],style: TextStyle(color: checkList[j] ? Colors.green : Colors.red,fontSize: 18),)),
            DataCell(Text(listToString(dragDropOrderTest.questions[j].elements),style: TextStyle(fontSize: 18),))
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
        dataRowHeight: _screensize.height*0.08,
        columns: [
          DataColumn(
              label: Text('Questions',style: TextStyle(fontSize: 18),)
          ),
          DataColumn(
              label: Text('Responses',style: TextStyle(fontSize: 18),)
          ),
          DataColumn(
              label: Text('Correct',style: TextStyle(fontSize: 18),)
          )
        ],
        rows: getDataRows(context),
      ),
    );
  }
}
