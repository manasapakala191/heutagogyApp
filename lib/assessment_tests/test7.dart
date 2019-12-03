
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test7Page extends StatefulWidget {
  final int L, B;
  final List<int> numbers;

  Test7Page(this.L, this.B, this.numbers, {Key key}) : super(key: key);

  @override
  _Test7PageState createState() => _Test7PageState(L, B, numbers);
}

class _Test7PageState extends State<Test7Page> {
  int L, B;
  List<int> numbers;
  Map<int, int> data;

  // 1->Fixed, 2->Filled, 0->Empty
  _Test7PageState(this.L, this.B, this.numbers);

  @override
  void initState() {
    data = Map<int, int>();
    super.initState();
    for (int i = 1; i <= this.L; i++) {
      for (int j = 1; j <= this.B; j++) {
        data[(i - 1) * this.B + j] = -1;
      }
    }
    for (int i in this.numbers) {
      if (i <= this.L * this.B) {
        data[i] = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Center(
              child: Text(
                "Fill in the Missing Numbers",
                style: TextStyle(fontSize: 20, fontFamily: 'Nunito'),
              ),
            ),
          ),
          _buildGrid(),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
          Padding(
              padding: EdgeInsets.only(left: 40, right: 40, bottom: 40),
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.spaceEvenly,
                children: _buildDraggable(),
              )),
        ],
      ),
    );
  }

  _buildGrid() {
    List<Widget> rows = [];
    for (int i = 1; i <= this.L; i++) {
      List<Widget> row = [];
      for (int j = 1; j <= this.B; j++) {
        int tmp = (i - 1) * this.B + j;
        if (data[tmp] == -1) {
          row.add(ClipRect(
            clipBehavior: Clip.antiAlias,
            child: Container(
              margin: EdgeInsets.all(2),
              width: 32,
              height: 32,
              child: Center(
                child: Text(
                  tmp.toString(),
                  style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black54, width: 1)),
            ),
          ));
        } else {
          row.add(
            DragTarget<int>(
              builder: (BuildContext context, List<int> incoming, List rejected) {
                return ClipRect(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      margin: EdgeInsets.all(2),
                      width: 32,
                      height: 32,
                      child: Center(
                        child: Text(
                          (data[tmp] == 0) ? "" : data[tmp].toString(),
                          style: TextStyle(
                              color: (data[tmp] == 0) ? Colors.black54 : Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black54, width: 1)),
                    ));
              },
              onAccept: (x) {
                setState(() {
                  data[tmp] = x;
                });
              },
              onWillAccept: (x) => true,
              onLeave: (x) {},
            ),
          );
        }
      }
      rows.add(Row(
        children: row,
        mainAxisAlignment: MainAxisAlignment.center,
      ));
    }
    return Container(
      child: Column(children: rows),
    );
  }

  _buildDraggable() {
    List<Widget> buttons = [];
    for (int i in numbers) {
      buttons.add(Draggable<int>(
        data: i,
        child: ClipRect(
          clipBehavior: Clip.antiAlias,
          child: Container(
            margin: EdgeInsets.all(5),
            width: 40,
            height: 40,
            child: Center(
              child: Text(
                i.toString(),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.black54, width: 1)),
          ),
        ),
        childWhenDragging: ClipRect(
          clipBehavior: Clip.antiAlias,
          child: Container(
            margin: EdgeInsets.all(5),
            width: 32,
            height: 32,
            child: Center(
              child: Text(
                i.toString(),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.black54, width: 1)),
          ),
        ),
        feedback: Material(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            clipBehavior: Clip.hardEdge,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(100)),
              width: 36,
              height: 36,
              child: Center(
                child: Text(
                  i.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          color: Colors.transparent,
        ),
      ));
    }
    return buttons;
  }
}
