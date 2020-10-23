import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
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
      rows.add(Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[drags[i], dragTargets[i]],
        ),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(testdata.heading,style: TextStyle(color: HexColor("ed2a26")),),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace_rounded,color: HexColor("#ed2a26")),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
        child: Column(
          children: rows,
        ),
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
            width: 135,
            height: 80,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10, left: 40),
            decoration:
                BoxDecoration(color: HexColor("ed2a26"), borderRadius: BorderRadius.circular(10)),
            child: data[x.second] == true? Icon(
              Icons.assignment_turned_in,
              color: Colors.white,
              size: 32,
            ) : Text(
              x.second,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          childWhenDragging: Material(
              child: Container(
                width: 135,
                height: 80,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10, left: 40),
            decoration:
                BoxDecoration(color: HexColor("ed2a26"), borderRadius: BorderRadius.circular(10)),
            child: Text(
              x.second,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )),
          feedback: Material(
              color: Colors.transparent,
              child: Container(
                width: 135,
                height: 80,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10, left: 40),
                decoration: BoxDecoration(
                    color: HexColor("ed2a26"), borderRadius: BorderRadius.circular(10)),
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
          width: 135,
          height: 80,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 10, right: 40),
          decoration: BoxDecoration(
              color: HexColor("ed2a26"),
              border: Border.all(color: HexColor("ed2a26")),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            "Matched",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ));
      } else {
        items.add(DragTarget<String>(
          builder: (BuildContext context, List<String> incoming, List rejected) {
            return Container(
              width: 135,
              height: 80,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10, right: 40),
              decoration:
                  BoxDecoration(color: HexColor("ed2a26"), borderRadius: BorderRadius.circular(10)),
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