import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {

  final List yData = List.generate(10, (index) => Random.secure().nextDouble()*30);
  final List xData = List.generate(10, (index) => (index+1).toDouble());

  List<FlSpot> getData(){
    List<FlSpot> flSpots = [];
    for(int i=0; i<10; i++){
      flSpots.add(FlSpot(
        xData[i], yData[i]
      ));
    }
    return flSpots;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: false
          ),
          borderData: FlBorderData(
            show: false
          ),
          minX: 0.0,
          maxX: 10.0,
          minY: 0.0,
          maxY: 30.0,
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => const TextStyle(
                fontSize: 20,
                color: Colors.black
              ),
              getTitles: (value) {
                switch(value.toInt()){
                  case 0 : return 0.toString();
                  case 5 : return 5.toString();
                  case 10 : return 10.toString();
                  default : return ' ';
                }
              }
            ),
            leftTitles: SideTitles(
              showTitles: false,

            )
          ),
          lineBarsData: [
            LineChartBarData(
              spots:getData(),
              isCurved: true
            ),
          ]
        )
      ),
    );
  }
}
