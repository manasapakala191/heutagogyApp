import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/missing_numbers_test.dart';
import 'package:heutagogy/screens/widgets/customAppBar.dart';
import 'package:heutagogy/screens/widgets/slideHeading.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';

class MissingNumbersResultScreen extends StatelessWidget {
  final MissingNumbersTest missingNumbersTest;
  final Progress progress;

  MissingNumbersResultScreen({this.missingNumbersTest, this.progress});


  List<DataRow> getDataRows() {
    List<DataRow> dataRows = [];
    for (int i = 0; i < progress.responses.length; i++) {
      dataRows.add(DataRow(cells: [
        DataCell(Text(missingNumbersTest.missingList[i].toString(),style: TextStyle(fontSize: 17))),
        DataCell(Text(progress.responses[i].toString(),style: TextStyle(fontSize: 17))),
        DataCell(missingNumbersTest.missingList[i] == progress.responses[i]
            ? Icon(
                Icons.check,
                color: Colors.green,
              )
            : Icon(Icons.close, color: Colors.red))
      ]));
    }
    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Your Progress",),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              SlideHeader(testName: missingNumbersTest.testName,testDescription: missingNumbersTest.testDescription,),
            Padding(
          padding: const EdgeInsets.all(8.0),
          child: PieChartWidget(
              right: progress.partsDone,
              wrong: progress.total - progress.partsDone),
            ),
            DataTable(
          columns: [
            DataColumn(label: Text('Answer',style: TextStyle(fontSize: 17))),
            DataColumn(label: Text('Response',style: TextStyle(fontSize: 17))),
            DataColumn(label: Text('Status',style: TextStyle(fontSize: 17)))
          ],
          rows: getDataRows(),
            )
          ]),
        ),
      ),
    );
  }
}
