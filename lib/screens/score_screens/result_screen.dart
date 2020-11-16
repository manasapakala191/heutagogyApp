import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/test_type_models/match_text_test.dart';
import 'package:heutagogy/screens/score_screens/line_chart_widget.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';

class ResultScreen extends StatelessWidget {

  final MatchPicWithText matchPicWithText;
  final List<String> responseMap;
  final int total;
  final int count;

  ResultScreen({this.matchPicWithText, this.responseMap, this.total, this.count});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pop();
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
                right: count,
                wrong: total - count,
              ),
            ),
            ListTile(
              title: Text('Responses',style: GoogleFonts.varelaRound(fontSize: 20),),
            ),
            ListTile(
              title: Text(matchPicWithText.testName),
              subtitle: Text(matchPicWithText.testDescription),
              trailing: Text(matchPicWithText.subject),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: MatchTextResponseViewer(
                matchPicWithText: matchPicWithText,
                responseMap: responseMap,
                total: total,
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
  final List<String> responseMap;
  final int total;
  MatchTextResponseViewer({this.matchPicWithText, this.responseMap, this.total});

  final checkList = <bool>[];

  void getCheckList(){
    for(int i=0; i<total; i++){
      if(responseMap[i] == matchPicWithText.choices[i].correctText)
        checkList.add(true);
      checkList.add(false);
    }
  }

  List<DataRow> getDataRows(BuildContext context){
    List<DataRow> dataRows = [];
    for(int j=0; j<total; j++){
      dataRows.add(DataRow(
        cells: [
          DataCell(checkList[j] ? Icon(Icons.check, color: Colors.green,) : Icon(Icons.close, color: Colors.red,)),
          DataCell(SizedBox(
              child: Image.network(matchPicWithText.choices[j].picture, fit: BoxFit.contain,))),
          DataCell(Text(responseMap[j])),
          DataCell(Text(matchPicWithText.choices[j].correctText))
        ]
      ));
    }
    return dataRows;
  }
  @override
  Widget build(BuildContext context) {
    getCheckList();
    return Container(
      margin: EdgeInsets.all(10),
      child: DataTable(
        columns: [
          DataColumn(
            label: Icon(Icons.stacked_bar_chart)
          ),
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
