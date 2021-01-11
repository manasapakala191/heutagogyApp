import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_test.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';


class DragDropImageScore extends StatelessWidget {
  final DragDropImageTest dragDropImageTest;
  final Progress progress;

  DragDropImageScore({this.dragDropImageTest,this.progress});
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
                title: Text(dragDropImageTest.testName),
                subtitle: Text(dragDropImageTest.testDescription),
                trailing: Text(dragDropImageTest.subject),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DragDropImageResponseViewer(
                  dragDropImageTest: dragDropImageTest,
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


class DragDropImageResponseViewer extends StatelessWidget {
  final DragDropImageTest dragDropImageTest;
  final List responseList;
  DragDropImageResponseViewer({this.dragDropImageTest, this.responseList});

  final checkList = <bool>[];

  void getCheckList(){
    for(int i=0; i<dragDropImageTest.pictures.length; i++){
      if(responseList[i] == dragDropImageTest.pictures[i].description)
        checkList.add(true);
      else{
        checkList.add(false);
      }
    }
  }

  List<DataRow> getDataRows(BuildContext context){
    List<DataRow> dataRows = [];
    for(int j=0; j<dragDropImageTest.pictures.length; j++){
      dataRows.add(DataRow(
          cells: [
            DataCell(SizedBox(
                child: Image.network(dragDropImageTest.pictures[j].picture, fit: BoxFit.contain,))),
            DataCell(
                Text(responseList[j],style: TextStyle(color: checkList[j] ? Colors.green : Colors.red),)),
            DataCell(Text(dragDropImageTest.pictures[j].description))
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
