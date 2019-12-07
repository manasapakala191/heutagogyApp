import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Test6Page extends StatefulWidget {
  @override
  _Test6PageState createState() => _Test6PageState();
}

class _Test6PageState extends State<Test6Page> {
  Map<String, String> animals;
  List<String> myAnimal = [];

  @override
  void initState() {
    myAnimal = [
      'Cow',
      'bull',
      'dolphin',
      'seal',
      'fish',
      'tiger',
      'lion',
      'elephant',
      'goat',
      'giraffe',
      'snake',
      'rabbit'
    ];
    super.initState();
    animals = Map<String, String>();
    for (String x in myAnimal) {
      animals[x] = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "Drag animals to the correct group.",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20,)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DragTarget<String>(
                builder: (BuildContext context, List<String> incoming, List rejected) {
                  return Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent, borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "Wild Animals",
                        style: TextStyle(
                            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                onWillAccept: (txt) => true,
                onAccept: (txt) {
                  setState(() {
                    animals[txt] = "Wild";
                  });
                },
              ),
              DragTarget<String>(
                builder: (BuildContext context, List<String> incoming, List rejected) {
                  return Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent, borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "Domestic Animals",
                        style: TextStyle(
                            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                onWillAccept: (txt) => true,
                onAccept: (txt) {
                  setState(() {
                    animals[txt] = "Domestic";
                  });
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
          ),
          Wrap(
            children: _buildDraggables(),
          )
        ],
      ),
    );
  }

  _buildDraggables() {
    List<Widget> items = [];
    for (String x in myAnimal) {
      items.add(Draggable<String>(
        data: x,
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: (animals[x] == "") ? Colors.white54 : Colors.blueAccent,
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Text(
            (animals[x] == "") ? x : "$x (${animals[x]})",
            style: TextStyle(
                fontSize: 16, color: (animals[x] != "") ? Colors.white : Colors.blueAccent),
          ),
        ),
        feedback: Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: Text(
              (animals[x] == "") ? x : "$x (${animals[x]})",
              style: TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),
          ),
        ),
        childWhenDragging: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Text(
            (animals[x] == "") ? x : "$x (${animals[x]})",
            style: TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
        ),
      ));
    }
    return items;
  }
}
