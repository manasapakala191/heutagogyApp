import 'package:flutter/material.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/math_match.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';


class DragDropTextScore extends StatelessWidget {
  final MathMatchTest mathMatchTest;
  final Progress progress;

  DragDropTextScore({this.mathMatchTest,this.progress});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: HexColor('#ed2a26'),
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
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
              ListTile(
                title: Text(mathMatchTest.testName),
                subtitle: Text(mathMatchTest.testDescription),
                trailing: Text(mathMatchTest.subject),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DragDropTextResponseViewer(
                  mathMatchTest: mathMatchTest,
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


class DragDropTextResponseViewer extends StatelessWidget {
  final MathMatchTest mathMatchTest;
  final List responseList;
  DragDropTextResponseViewer({this.mathMatchTest, this.responseList});

  final checkList = <bool>[];

  void getCheckList(){
    for(int i=0; i<mathMatchTest.questions.length; i++){
      if(responseList[i] == mathMatchTest.questions[i].second)
        checkList.add(true);
      else{
        checkList.add(false);
      }
    }
  }

  List<DataRow> getDataRows(BuildContext context){
    List<DataRow> dataRows = [];
    for(int j=0; j<mathMatchTest.questions.length; j++){
      dataRows.add(DataRow(
          cells: [
            // DataCell(checkList[j] ? Icon(Icons.check, color: Colors.green,) : Icon(Icons.close, color: Colors.red,)),
            DataCell(Text(mathMatchTest.questions[j].first)),
            DataCell(
                Text(responseList[j],style: TextStyle(color: checkList[j] ? Colors.green : Colors.red),)),
            DataCell(Text(mathMatchTest.questions[j].second))
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
        dataRowHeight: _screensize.height*0.1,
        columns: [
          // DataColumn(
          //   label: Icon(Icons.stacked_bar_chart)
          // ),
          DataColumn(
              label: Text('Questions')
          ),
          DataColumn(
              label: Text('Responses')
          ),
          DataColumn(
              label: Text('Correct')
          )
        ],
        rows: getDataRows(context),
      ),
    );
  }
}
