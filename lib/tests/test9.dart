import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/data_models.dart';

class Test9Page extends StatefulWidget {
  final Test9Data test9data;

  Test9Page(this.test9data, {Key key}) : super(key: key);

  @override
  _Test9PageState createState() => _Test9PageState(test9data);
}

class _Test9PageState extends State<Test9Page> {
  Test9Data test9data;
  Map<String, bool> data;

  _Test9PageState(this.test9data);

  @override
  void initState() {
    super.initState();
    data = Map<String, bool>();
    for (var x in test9data.questions) {
      data[x.first] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drags = _buildDraggables();
    List<Widget> dragTargets = _buildDragTargets();
    dragTargets..shuffle(Random(2));
    List<Widget> rows = [];
    rows.add(
      Text(test9data.heading, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
    for (int i = 0; i < drags.length; i++) {
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[drags[i], dragTargets[i]],
      ));
    }
    return SingleChildScrollView(
      child: Column(
        children: rows,
      ),
    );
  }

  _buildDraggables() {
    List<Widget> items = [];
    for (var x in test9data.questions) {
      if (!data[x.first]) {
        items.add(Draggable<String>(
            data: x.first,
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
      } else {
        items.add(Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 10, left: 40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueAccent)),
          child: Text(
            x.second,
            style: TextStyle(color: Colors.green, fontSize: 16),
          ),
        ));
      }
    }
    return items;
  }

  _buildDragTargets() {
    List<Widget> items = [];
    for (var x in test9data.questions) {
      if (data[x.first]) {
        items.add(Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 10, right: 40),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            "Correct",
            style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
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
          onWillAccept: (t) => t == x.first,
          onAccept: (t) {
            setState(() {
              data[x.first] = true;
            });
          },
        ));
      }
    }
    return items;
  }
}
