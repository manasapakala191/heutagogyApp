import 'package:flutter/material.dart';

class DragDropScoreWidget extends StatelessWidget {

  final Map<String, dynamic> correct;
  final Map<String, dynamic> choices;

  DragDropScoreWidget({this.correct, this.choices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
