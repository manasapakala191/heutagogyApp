import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {

  final int right;
  final int wrong;

  PieChartWidget({this.wrong, this.right});

  final data = Map<String, int>();

  final List<Color> colors = [
    Colors.green,
    Colors.red,
    Colors.yellow
  ];

  void setData(){
    this.data['correct'] = right;
    this.data['wrong'] = wrong;
  }

  List<PieChartSectionData> sections(){
    final List<PieChartSectionData> sectionWidgets = [];
    if(data['correct'] != 0){
      sectionWidgets.add(PieChartSectionData(
          color: Colors.green,
          title: data['correct'].toString(),
          showTitle: true,
          value: data['correct'].toDouble(),
          radius: 120
      ));
    }

    if(data['wrong'] != 0){
      sectionWidgets.add(PieChartSectionData(
          color: Colors.red,
          title: data['wrong'].toString(),
          showTitle: true,
          value: data['wrong'].toDouble(),
          radius: 120
      ));
    }

    return sectionWidgets;
  }

  @override
  Widget build(BuildContext context) {
    setData();
    int index = 0;
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 0,
                    sectionsSpace: 0,
                    borderData: FlBorderData(
                      show: false
                    ),
                      sections: sections()
                  )
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: data.keys.map((e) => Tile(
              color: colors[index++%2],
              title: e,
            )).toList(),
          )
        ],
      )
    );
  }
}

class Tile extends StatelessWidget {
  final Color color;
  final String title;
  Tile({this.color, this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          color: color,
          height: 15,
          width: 15,
        ),
        Padding(
          padding: EdgeInsets.all(3),
          child: Text(title),
        )
      ],
    );
  }
}
