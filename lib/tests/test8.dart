import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Test8Page extends StatefulWidget {
  final List<int> numbers;
  final List<int> missing;

  Test8Page(this.numbers, this.missing);

  @override
  _Test8PageState createState() => _Test8PageState(numbers, missing);
}

class _Test8PageState extends State<Test8Page> {
  List<int> numbers;
  Map<int, int> data;

  _Test8PageState(List<int> numbers, List<int> missing) {
    this.numbers = List.from(numbers);
    data = Map<int, int>();
    for (int num in numbers) {
      data[num] = 1;
    }
    for (int num in missing) {
      data[num] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              "Enter The missing numbers",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            padding: EdgeInsets.only(top: 20, bottom: 15),
          ),
          _buildWidgets(),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
          ),
        ],
      ),
    );
  }

  _buildWidgets() {
    List<Widget> myWidgets = [];
    for (var num in this.numbers) {
      if (data[num] == 1) {
        myWidgets.add(
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black54),
                borderRadius: BorderRadius.circular(50)),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.only(top: 8, bottom: 8),
            width: 240,
            child: Center(
              child: Text(
                num.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      } else if (data[num] == 2) {
        myWidgets.add(
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.green),
                borderRadius: BorderRadius.circular(50)),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.only(top: 8, bottom: 8),
            width: 240,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                Padding(padding: EdgeInsets.only(left: 2)),
                Text(
                  num.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
//                textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      } else {
        myWidgets.add(
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(50)),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            width: 240,
            child: TextField(
              style: TextStyle(fontSize: 18, color: Colors.blueAccent, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: "Enter number",
                  hintStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      color: Color.fromRGBO(40, 40, 240, 0.3)),
                  border: InputBorder.none),
              onChanged: (text) {
                if (text == num.toString()) {
                  setState(() {
                    data[num] = 2;
                  });
                }
              },
              enabled: (data[num] == 0),
              keyboardType: TextInputType.number,
            ),
          ),
        );
      }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: myWidgets,
    );
  }
}
