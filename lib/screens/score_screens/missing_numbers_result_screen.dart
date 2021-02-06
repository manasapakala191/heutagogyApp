import 'package:flutter/material.dart';
import 'package:heutagogy/screens/score_screens/pie_chart_widget.dart';

class MissingNumbersResultScreen extends StatelessWidget {
  final answers;
  final responses;

  MissingNumbersResultScreen({this.answers, this.responses});

  final evaluationMap = {'correct': 0, 'total': 0};

  void evaluate() {
    evaluationMap['total'] = answers.length;
    for (int i = 0; i < responses.length; i++) {
      if (responses[i] == answers[i]) {
        evaluationMap['correct'] = evaluationMap['correct'] + 1;
      }
    }
  }

  List<DataRow> getDataRows() {
    List<DataRow> dataRows = [];
    for (int i = 0; i < answers.length; i++) {
      dataRows.add(DataRow(cells: [
        DataCell(Text(answers[i].toString())),
        DataCell(Text(responses[i].toString())),
        DataCell(answers[i] == responses[i]
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
    evaluate();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PieChartWidget(
                right: evaluationMap['correct'],
                wrong: evaluationMap['total'] - evaluationMap['correct']),
          ),
          DataTable(
            columns: [
              DataColumn(label: Text('Answer')),
              DataColumn(label: Text('Response')),
              DataColumn(label: Text('Status'))
            ],
            rows: getDataRows(),
          )
        ])),
      ),
    );
  }
}
