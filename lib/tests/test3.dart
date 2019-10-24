import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

class MyNumber<T, S> {
  T first;
  S second;
  MyNumber(this.first, this.second);
}

class NewPageTest extends StatefulWidget {
  NewPageTest({Key key}) : super(key: key);

  _NewPageTestState createState() => _NewPageTestState();
}

class _NewPageTestState extends State<NewPageTest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0);
    List<int> nums1 = [6, 18, 12, 4, 20];
    List<int> nums2 = [10, 11, 7, 1, 19];
    List<int> nums3 = [11, 17, 9, 5, 18];
    List<int> nums4 = [3, 16, 2, 19, 8];

    return Center(
      child: Container(
        height: 400,
        child: PageView(
          controller: pageController,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            NumberPuzzle(
              key: PageStorageKey<String>(String.fromCharCodes(nums1)),
              numbers: nums1,
            ),
            NumberPuzzle(
              key: PageStorageKey<String>(String.fromCharCodes(nums2)),
              numbers: nums2,
            ),
            NumberPuzzle(
              key: PageStorageKey<String>(String.fromCharCodes(nums3)),
              numbers: nums3,
            ),
            NumberPuzzle(
              key: PageStorageKey<String>(String.fromCharCodes(nums4)),
              numbers: nums4,
            )
          ],
        ),
      ),
    );

    // return SafeArea(
    //   child: Column(
    //     children: <Widget>[
    //       NumberPuzzle(
    //         numbers: nums,
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(top: 30),
    //       ),
    //       NumberPuzzle(
    //         numbers: [2, 54, 6, 32, 61, 8],
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(top: 30),
    //       ),
    //       NumberPuzzle(
    //         numbers: [3, 65, 2, 12],
    //       ),
    //     ],
    //   ),
    // );
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
  // bool mustCallSuper() => true;
  List<int> numbers;
  _NumberPuzzleState(this.numbers);
  @override
  Widget build(BuildContext context) {
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
          NumberPuzzleSub(recievedNumbers: numbers, order: "ASC"),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              "Sort in Descending Order",
              style: TextStyle(fontSize: 20),
            ),
          ),
          NumberPuzzleSub(recievedNumbers: numbers, order: "DESC"),
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
  final List<int> recievedNumbers;
  final String order;
  NumberPuzzleSub({Key key, @required this.recievedNumbers, this.order}) : super(key: key);
  _NumberPuzzleSubState createState() => _NumberPuzzleSubState(recievedNumbers, order);
}

class _NumberPuzzleSubState extends State<NumberPuzzleSub> {
  List<int> recievedNumbers;
  List<MyNumber<int, bool>> numbers;
  String order;
  _NumberPuzzleSubState(this.recievedNumbers, this.order);

  @override
  void initState() {
    recievedNumbers.shuffle(Random(41));
    numbers = List<MyNumber<int, bool>>();
    for (var number in recievedNumbers) {
      numbers.add(MyNumber<int, bool>(number, false));
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

  List<Widget> _dragTargetBuilder(List<MyNumber<int, bool>> numbers, String order, int id) {
    List<MyNumber<int, bool>> correctOrder = List<MyNumber<int, bool>>.from(numbers);
    List<Widget> myList = [];
    // Ascending Order
    correctOrder = List<MyNumber<int, bool>>.from(numbers);
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
          if (number.second == false) {
            return Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blueAccent)),
              child: Center(
                child: Text(
                  "?",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            );
          } else {
            return Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.greenAccent,
              ),
              child: Center(
                  child: Text(
                "${number.first}",
                style: TextStyle(fontSize: 20),
              )),
            );
          }
        },
        onWillAccept: (value) => value == "$id:$order:${number.first}",
        onAccept: (value) {
          int j = 0;
          for (int i = 0; i < numbers.length; i++) {
            if (numbers[i].first == number.first) {
              j = i;
              break;
            }
          }
          setState(() {
            numbers[j].second = true;
          });
        },
        onLeave: (value) {},
      ));
    }
    return myList;
  }

  List<Widget> _draggableItemBuilder(List<MyNumber<int, bool>> numbers, String order, int id) {
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
      if (number.second == false) {
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
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: AnimatedOpacity(
                    opacity: 0.5, duration: Duration(milliseconds: 200), child: null),
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
                        color: Colors.blueAccent,
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
      } else {
        myList.add(AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.green,
          ),
          child: Center(
            child: Icon(Icons.check_circle_outline),
          ),
        ));
      }
    }
    return myList;
  }
}
