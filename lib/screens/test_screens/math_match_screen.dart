import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/models/test_type_models/math_match.dart';

class MathMatchScreen extends StatefulWidget {
  final MathMatchTest data;

  MathMatchScreen(this.data);

  @override
  _MathMatchScreenState createState() => _MathMatchScreenState(data);
}

class _MathMatchScreenState extends State<MathMatchScreen> {
  MathMatchTest testdata;
  Map<String, bool> data;

  _MathMatchScreenState(this.testdata);

  @override
  void initState() {
    super.initState();
    data = Map<String, bool>();
    for (var x in testdata.questions) {
      data[x.second] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drags = _buildDraggables();
    List<Widget> dragTargets = _buildDragTargets();
    dragTargets..shuffle(Random(2));
    List<Widget> rows = [];
    rows.add(
      Text(testdata.heading, style: TextStyle(fontSize: 20)),
    );
    for (int i = 0; i < drags.length; i++) {
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[drags[i], dragTargets[i]],
      ));
    }
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
        children: rows,
      ),
    )
    );
  }

  _buildDraggables() {
    List<Widget> items = [];
    for (var x in testdata.questions) {
      items.add(Draggable<String>(
          data: x.second,
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10, left: 40),
            decoration:
                BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
            child: Text(
              x.second,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          childWhenDragging: Material(
              child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10, left: 40),
            decoration:
                BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
            child: Text(
              x.second,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )),
          feedback: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10, left: 40),
                decoration: BoxDecoration(
                    color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  x.second,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ))));
    }

    return items;
  }

  _buildDragTargets() {
    List<Widget> items = [];
    for (var x in testdata.questions) {
      if (data[x.second]) {
        items.add(Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 10, right: 40),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            "Matched",
            style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ));
      } else {
        items.add(DragTarget<String>(
          builder: (BuildContext context, List<String> incoming, List rejected) {
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10, right: 40),
              decoration:
                  BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
              child: Text(
                x.first,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          },
          onWillAccept: (t) => true,
          onAccept: (t) {
            setState(() {
              data[x.second] = true;
            });
          },
        ));
      }
    }
    return items;
  }
}