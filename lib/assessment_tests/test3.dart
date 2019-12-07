import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

import 'package:heutagogy/data_models.dart';

class MyNumber<T, S> {
  T first;
  S second;

  MyNumber(this.first, this.second);
}

class Test3Page extends StatefulWidget {
  final Test3Data test3data;

  Test3Page(this.test3data, {Key key}) : super(key: key);

  _Test3PageState createState() => _Test3PageState(test3data);
}

class _Test3PageState extends State<Test3Page> {
  Test3Data test3data;

  _Test3PageState(this.test3data);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0);

    return Center(
      child: Column(
        children: <Widget>[
          Text(
            "Sort the numbers correctly",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          Container(
            height: 400,
            child: PageView(
                controller: pageController,
                scrollDirection: Axis.vertical,
                children: _buildChildren()),
          ),
          Text(
            "Swipe Up for More!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  _buildChildren() {
    List<Widget> numberPuzzles = [];
    for (var x in test3data.numberLists) {
      numberPuzzles.add(NumberPuzzle(
//            key: PageStorageKey<String>(String.fromCharCodes(nu)),
        numbers: x.numbers,
      ));
    }
    return numberPuzzles;
  }
}

class NumberPuzzle extends StatefulWidget {
  final List<int> numbers;

  NumberPuzzle({Key key, this.numbers}) : super(key: key);

  _NumberPuzzleState createState() => _NumberPuzzleState(numbers);
}

class _NumberPuzzleState extends State<NumberPuzzle>
    with AutomaticKeepAliveClientMixin<NumberPuzzle> {
  @override
  bool get wantKeepAlive => true;
  List<int> numbers;

  _NumberPuzzleState(this.numbers);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
        child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              "Sort in Ascending Order",
              style: TextStyle(fontSize: 20),
            ),
          ),
          NumberPuzzleSub(receivedNumbers: numbers, order: "ASC"),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              "Sort in Descending Order",
              style: TextStyle(fontSize: 20),
            ),
          ),
          NumberPuzzleSub(receivedNumbers: numbers, order: "DESC"),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
        ],
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ));
  }
}

class NumberPuzzleSub extends StatefulWidget {
  final List<int> receivedNumbers;
  final String order;

  NumberPuzzleSub({Key key, @required this.receivedNumbers, this.order}) : super(key: key);

  _NumberPuzzleSubState createState() => _NumberPuzzleSubState(receivedNumbers, order);
}

class _NumberPuzzleSubState extends State<NumberPuzzleSub> {
  List<int> receivedNumbers;
  List<MyNumber<int, int>> numbers;
  String order;

  _NumberPuzzleSubState(this.receivedNumbers, this.order);

  @override
  void initState() {
    receivedNumbers.shuffle(Random(41));
    numbers = List<MyNumber<int, int>>();
    for (var number in receivedNumbers) {
      numbers.add(MyNumber<int, int>(number, 0));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _dragTargetBuilder(numbers, order, 1),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _draggableItemBuilder(numbers, order, 1),
          ),
        ],
      ),
    );
  }

  List<Widget> _dragTargetBuilder(List<MyNumber<int, int>> numbers, String order, int id) {
    List<MyNumber<int, int>> correctOrder = List<MyNumber<int, int>>.from(numbers);
    List<Widget> myList = [];
    // Ascending Order
    correctOrder = List<MyNumber<int, int>>.from(numbers);
    if (order == "ASC") {
      correctOrder.sort((a, b) => a.first.compareTo(b.first));
    }
    if (order == "DESC") {
      correctOrder.sort((a, b) => -a.first.compareTo(b.first));
    }
    // Descending Order
    for (var number in correctOrder) {
      myList.add(DragTarget<String>(
        builder: (BuildContext context, List<String> incoming, List rejected) {
          return Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueAccent)),
            child: Center(
              child: Text(
                (number.second == 0) ? "?" : number.second.toString(),
                style: TextStyle(fontSize: 24),
              ),
            ),
          );
        },
        onWillAccept: (value) => value.startsWith("$id:$order"),
        onAccept: (value) {
          int j = 0;
          for (int i = 0; i < numbers.length; i++) {
            if (numbers[i].first == number.first) {
              j = i;
              break;
            }
          }
          setState(() {
            numbers[j].second = int.parse(value.split(":")[2]);
          });
        },
        onLeave: (value) {},
      ));
    }
    return myList;
  }

  List<Widget> _draggableItemBuilder(List<MyNumber<int, int>> numbers, String order, int id) {
    List<Widget> myList = [];
    for (var number in numbers) {
      Widget aColumn = AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blueAccent,
        ),
        child: Center(
            child: Text(
          "${number.first}",
          style: TextStyle(fontSize: 20),
        )),
      );
      myList.add(Transform.translate(
          offset: Offset(0, 0),
          child: Draggable<String>(
            child: aColumn,
            childWhenDragging: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.lightBlueAccent),
              ),
              child:
                  AnimatedOpacity(opacity: 0.5, duration: Duration(milliseconds: 200), child: null),
            ),
            feedback: Material(
              borderRadius: BorderRadius.circular(16),
              child: AnimatedOpacity(
                opacity: 0.8,
                duration: Duration(milliseconds: 200),
                child: Material(
                  type: MaterialType.transparency,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.lightBlueAccent,
                    ),
                    child: Center(
                        child: Text(
                      "${number.first}",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ),
                ),
              ),
            ),
            data: "$id:$order:${number.first}",
          )));
    }
    return myList;
  }
}
