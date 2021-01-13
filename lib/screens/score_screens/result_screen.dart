import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/match_text_test.dart';
import 'package:heutagogy/screens/score_screens/line_chart_widget.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';

class ResultScreen extends StatelessWidget {

  final MatchPicWithText matchPicWithText;
  final Progress progress;

  ResultScreen({this.matchPicWithText,this.progress});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Progress in Types of lines Quiz",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
            ListTile(
              title: Text(matchPicWithText.testName, style: TextStyle(color: Colors.red),),
              subtitle: Text(matchPicWithText.testDescription),
              trailing: Text(matchPicWithText.subject),
            ),
            
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
              child: MatchTextResponseViewer(
                matchPicWithText: matchPicWithText,
                responseList: progress.responses,
                total: matchPicWithText.choices.length,
              ),
            )
          ],
        ),
        )
      );
  }
}

class MatchTextResponseViewer extends StatelessWidget {
  final MatchPicWithText matchPicWithText;
  final List responseList;
  final int total;
  MatchTextResponseViewer({this.matchPicWithText, this.responseList, this.total});

  final checkList = <bool>[];

  void getCheckList(){
    for(int i=0; i<total; i++){
      if(responseList[i] == matchPicWithText.choices[i].correctText)
        checkList.add(true);
      else{
        checkList.add(false);
      }
    }
  }

  List<DataRow> getDataRows(BuildContext context){
    List<DataRow> dataRows = [];
    for(int j=0; j<total; j++){
      dataRows.add(DataRow(
        cells: [
          // DataCell(checkList[j] ? Icon(Icons.check, color: Colors.green,) : Icon(Icons.close, color: Colors.red,)),
          DataCell(SizedBox(
              child: Image.network(matchPicWithText.choices[j].picture, fit: BoxFit.contain,))),
          DataCell(
              Text(responseList[j] == null ? "-" : responseList[j],style: TextStyle(color: checkList[j] ? Colors.green : Colors.red),)),
          DataCell(Text(matchPicWithText.choices[j].correctText))
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
        dataRowHeight: _screensize.height*0.2,
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
