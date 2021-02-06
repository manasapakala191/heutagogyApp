import 'package:flutter/material.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';

class FillInTheBlanksResultViewer extends StatelessWidget {
  FillInTheBlanksResultViewer({this.answers, this.questions, this.responseMap});

  final questions;
  final answers;
  final responseMap;

  List<DataRow> getDataRows() {
    final List<DataRow> dataRows = [];
    for (int i = 0; i < questions.length; i++) {
      dataRows.add(DataRow(cells: [
        DataCell(Text(questions[i]['question'])),
        DataCell(Text(questions[i]['correctText'])),
        DataCell(Text(answers[i])),
        DataCell(questions[i]['correctText'] == answers[i]
            ? Icon(Icons.check, color: Colors.green)
            : Icon(
                Icons.close,
                color: Colors.red,
              ))
      ]));
    }
    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PieChartWidget(
                  right: responseMap['correctAnswers'],
                  wrong: responseMap['totalQuestions'] -
                      responseMap['correctAnswers']),
            ),
            DataTable(columns: [
              DataColumn(label: Text('Question')),
              DataColumn(label: Text('Answer')),
              DataColumn(label: Text('Response')),
              DataColumn(label: Text('Status'))
            ], rows: getDataRows())
          ]),
        )));
  }
}
