import 'package:flutter/material.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/fill_the_blank_test.dart';
import 'package:heutagogy/screens/widgets/customAppBar.dart';
import 'package:heutagogy/screens/widgets/slideHeading.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';

class FillInTheBlanksResultViewer extends StatelessWidget {
  final FillInBlankTest fillInBlankTest;
  final Progress progress;
  FillInTheBlanksResultViewer({this.fillInBlankTest,this.progress});

  List<DataRow> getDataRows() {
    final List<DataRow> dataRows = [];
    for (int i = 0; i < fillInBlankTest.choices.length; i++) {
      dataRows.add(DataRow(cells: [
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(fillInBlankTest.choices[i].question,style: TextStyle(fontSize: 17),),
        )),
        DataCell(Text(fillInBlankTest.choices[i].correctText,style: TextStyle(fontSize: 17),)),
        DataCell(Text(progress.responses[i],style: TextStyle(fontSize:17,color: fillInBlankTest.choices[i].correctText == progress.responses[i]?Colors.green:Colors.red),)),
        // DataCell(fillInBlankTest.choices[i].correctText == progress.responses[i]
        //     ? Icon(Icons.check, color: Colors.green)
        //     : Icon(
        //         Icons.close,
        //         color: Colors.red,
        //       ))
      ]));
    }
    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Your Progress",
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                  shrinkWrap: true,
                  children: [
                    SlideHeader(
                      testName: fillInBlankTest.testName,
                      testDescription: fillInBlankTest.testDescription,
                    ),
                Container(
                  height: 300,
                  padding: const EdgeInsets.all(8.0),
                  child: PieChartWidget(
                      right: progress.partsDone,
                      wrong: progress.total -
                          progress.partsDone),
                ),
                DataTable(
                  columnSpacing: 7,
                    columns: [
                  DataColumn(label: Text('Question',style: TextStyle(fontSize: 17),)),
                  DataColumn(label: Text('Answer',style: TextStyle(fontSize: 17),)),
                  DataColumn(label: Text('Response',style: TextStyle(fontSize: 17),)),
                ], rows: getDataRows())
              ]),
            )));
  }
}
