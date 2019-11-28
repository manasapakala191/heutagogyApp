import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test7Page extends StatefulWidget {
  final int L, B;
  final List<int> numbers;

  Test7Page(this.L, this.B, this.numbers);

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
        data[(i - 1) * this.B + j] = 1;
      }
    }
    for (int i in this.numbers) {
      if (i <= this.L * this.B) {
        data[i] = 0;
      }
    }
    data[1] = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Center(
              child: Text(
                "Heading",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          _buildGrid(),
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
        if (data[tmp] == 1) {
          row.add(ClipRect(
            clipBehavior: Clip.antiAlias,
            child: Container(
              margin: EdgeInsets.all(5),
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
          if (data[tmp] == 0) {
            row.add(ClipRect(
              clipBehavior: Clip.antiAlias,
              child: DragTarget<int>(
                builder: (BuildContext context, List<int> incoming, List rejected) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    width: 32,
                    height: 32,
                    child: Center(
                      child: Text(
                        (data[tmp] == 0) ? "" : tmp.toString(),
                        style: TextStyle(
                            color: (data[tmp] == 0) ? Colors.black54 : Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black54, width: 1)),
                  );
                },
                onAccept: (received){
                  setState(() {
                    data[received] = 2;
                  });
                },
              ),
            ));
          } else {
            row.add(ClipRect(
              clipBehavior: Clip.antiAlias,
              child: Container(
                margin: EdgeInsets.all(5),
                width: 32,
                height: 32,
                child: Center(
                  child: Text(
                    tmp.toString(),
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.blueAccent, width: 1)),
              ),
            ));
          }
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

  _buildDraggables(){

  }
}
