import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Temp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'temp',
      home: Scaffold(
        body: TestPage3(),
      ),
    );
  }
}

class TestPage3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestPage3State();
  }
}

class _TestPage3State extends State<TestPage3> {
  TextEditingController in1 = new TextEditingController();
  TextEditingController in2 = new TextEditingController();
  TextEditingController in3 = new TextEditingController();
  TextEditingController in4 = new TextEditingController();
  TextEditingController in5 = new TextEditingController();
  TextEditingController in6 = new TextEditingController();
  TextEditingController in7 = new TextEditingController();
  TextEditingController in8 = new TextEditingController();
  TextEditingController in9 = new TextEditingController();
  TextEditingController in10 = new TextEditingController();
  TextEditingController in21 = new TextEditingController();
  TextEditingController in22 = new TextEditingController();
  TextEditingController in23 = new TextEditingController();
  TextEditingController in24 = new TextEditingController();
  TextEditingController in25 = new TextEditingController();
  TextEditingController in26 = new TextEditingController();
  TextEditingController in27 = new TextEditingController();
  TextEditingController in28 = new TextEditingController();
  TextEditingController in29 = new TextEditingController();
  TextEditingController in30 = new TextEditingController();
  TextEditingController in11 = new TextEditingController();
  TextEditingController in12 = new TextEditingController();
  TextEditingController in13 = new TextEditingController();
  TextEditingController in14 = new TextEditingController();
  TextEditingController in15 = new TextEditingController();
  TextEditingController in16 = new TextEditingController();
  TextEditingController in17 = new TextEditingController();
  TextEditingController in18 = new TextEditingController();
  TextEditingController in19 = new TextEditingController();
  TextEditingController in20 = new TextEditingController();
  TextEditingController in31 = new TextEditingController();
  TextEditingController in32 = new TextEditingController();
  TextEditingController in33 = new TextEditingController();
  TextEditingController in34 = new TextEditingController();
  TextEditingController in35 = new TextEditingController();
  TextEditingController in36 = new TextEditingController();
  TextEditingController in37 = new TextEditingController();
  TextEditingController in38 = new TextEditingController();
  TextEditingController in39 = new TextEditingController();
  TextEditingController in40 = new TextEditingController();

  bool pressed = false;
  bool pressed1 = false;
  bool pressed2 = false;
  bool pressed3 = false;
  bool pressed4 = false;
  bool pressed5 = false;
  bool pressed6 = false;
  bool pressed7 = false;
  bool check;
  bool check1;
  bool check2;
  bool check3;
  bool check4;
  bool check5;
  bool check6;
  bool check7;
  bool check8;
  bool check9;
  bool check10;
  bool check11;
  bool check12;
  bool check13;
  bool check14;
  bool check15;
  bool check16;
  bool check17;
  bool check18;
  bool check19;
  bool check21;
  bool check22;
  bool check23;
  bool check24;
  bool check25;
  bool check26;
  bool check27;
  bool check28;
  bool check29;
  bool check30;
  bool check31;
  bool check32;
  bool check33;
  bool check34;
  bool check35;
  bool check36;
  bool check37;
  bool check38;
  bool check39;
  bool check40;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Container(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: new EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: new Text(
                  'The numbers are given in wrong manner set them according to ascending and descending order ',
                  style: new TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(20.0),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.blueGrey[100],
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 0.0),
                    ),
                  ],
                ),
              ),
              Container(
                margin: new EdgeInsets.only(left: 0.5, right: 0.5, top: 10),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(20.0),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.blueGrey[100],
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 0.0),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.center,
                    child: new Text(
                      'a). 6, 18, 12, 4, 20',
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    child: new Text(
                      'ascending order:',
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in1,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      pressed ? (check ? Colors.green : Colors.red) : Colors.white,
                                  border: OutlineInputBorder()),
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in2,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed ? (check1 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in3,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed ? (check2 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in4,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed ? (check3 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in5,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed ? (check4 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ))
                      ])),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: new RaisedButton(
                      color: Colors.blueGrey[100],
                      child: Text("Check here"),
                      onPressed: () {
                        bool b = (in1.text != "") ? f1(int.parse(in1.text)) : false;
                        bool c = (in2.text != "") ? f2(int.parse(in2.text)) : false;
                        bool d = (in3.text != "") ? f3(int.parse(in3.text)) : false;
                        bool e = (in4.text != "") ? f4(int.parse(in4.text)) : false;
                        bool f = (in5.text != "") ? f5(int.parse(in5.text)) : false;

                        setState(() {
                          pressed = true;
                          check = b;
                          check1 = c;
                          check2 = d;
                          check3 = e;
                          check4 = f;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    child: new Text(
                      'descending order:',
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in6,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed1 ? (check10 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in7,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed1 ? (check11 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in8,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed1 ? (check12 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in9,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed1 ? (check13 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in10,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed1 ? (check14 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ))
                      ])),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: new RaisedButton(
                      color: Colors.blueGrey[100],
                      child: Text("Check here"),
                      onPressed: () {
                        bool b = (in6.text != "") ? f5(int.parse(in6.text)) : false;
                        bool c = (in7.text != "") ? f4(int.parse(in7.text)) : false;
                        bool d = (in8.text != "") ? f3(int.parse(in8.text)) : false;
                        bool e = (in9.text != "") ? f2(int.parse(in9.text)) : false;
                        bool f = (in10.text != "") ? f1(int.parse(in10.text)) : false;
                        setState(() {
                          pressed1 = true;
                          check10 = b;
                          check11 = c;
                          check12 = d;
                          check13 = e;
                          check14 = f;
                        });
                      },
                    ),
                  ),
                ]),
              ),
              Container(
                margin: new EdgeInsets.only(left: 0.5, right: 0.5, top: 10),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(20.0),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.blueGrey[100],
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 0.0),
                    ),
                  ],
                ),
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    child: new Text(
                      'b). 11, 10, 7, 19,1',
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Roboto',
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    child: new Text(
                      'ascending order:',
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in11,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: pressed2
                                      ? (check5 ? Colors.green : Colors.red)
                                      : Colors.white,
                                  border: OutlineInputBorder()),
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in12,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed2 ? (check6 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in13,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed2 ? (check7 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in14,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed2 ? (check8 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in15,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed2 ? (check9 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ))
                      ])),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: new RaisedButton(
                      color: Colors.blueGrey[100],
                      child: Text("Check here"),
                      onPressed: () {
                        bool b = (in11.text != "") ? f6(int.parse(in11.text)) : false;
                        bool c = (in12.text != "") ? f7(int.parse(in12.text)) : false;
                        bool d = (in13.text != "") ? f8(int.parse(in13.text)) : false;
                        bool e = (in14.text != "") ? f9(int.parse(in14.text)) : false;
                        bool f = (in15.text != "") ? f10(int.parse(in15.text)) : false;

                        setState(() {
                          pressed2 = true;

                          check5 = b;
                          check6 = c;
                          check7 = d;
                          check8 = e;
                          check9 = f;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    child: new Text(
                      'descending order:',
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in16,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed3 ? (check15 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in17,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed3 ? (check16 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in18,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed3 ? (check17 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in19,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed3 ? (check18 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in20,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed3 ? (check19 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ))
                      ])),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: new RaisedButton(
                      color: Colors.blueGrey[100],
                      child: Text("Check here"),
                      onPressed: () {
                        bool b = (in16.text != "") ? f10(int.parse(in16.text)) : false;
                        bool c = (in17.text != "") ? f9(int.parse(in17.text)) : false;
                        bool d = (in18.text != "") ? f8(int.parse(in18.text)) : false;
                        bool e = (in19.text != "") ? f7(int.parse(in19.text)) : false;
                        bool f = (in20.text != "") ? f6(int.parse(in20.text)) : false;

                        setState(() {
                          pressed3 = true;

                          check15 = b;
                          check16 = c;
                          check17 = d;
                          check18 = e;
                          check19 = f;
                        });
                      },
                    ),
                  ),
                ]),
              ),
              Container(
                margin: new EdgeInsets.only(left: 0.5, right: 0.5, top: 10),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(20.0),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.blueGrey[100],
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 0.0),
                    ),
                  ],
                ),
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    child: new Text(
                      'c). 11, 17, 9, 5, 18',
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Roboto',
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    child: new Text(
                      'ascending order:',
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in21,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: pressed4
                                      ? (check21 ? Colors.green : Colors.red)
                                      : Colors.white,
                                  border: OutlineInputBorder()),
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in22,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed4 ? (check22 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in23,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed4 ? (check23 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in24,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed4 ? (check24 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in25,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed4 ? (check25 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ))
                      ])),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: new RaisedButton(
                      color: Colors.blueGrey[100],
                      child: Text("Check here"),
                      onPressed: () {
                        bool b = (in21.text != "") ? f21(int.parse(in21.text)) : false;
                        bool c = (in22.text != "") ? f22(int.parse(in22.text)) : false;
                        bool d = (in23.text != "") ? f23(int.parse(in23.text)) : false;
                        bool e = (in24.text != "") ? f24(int.parse(in24.text)) : false;
                        bool f = (in25.text != "") ? f25(int.parse(in25.text)) : false;

                        setState(() {
                          pressed4 = true;
                          check21 = b;
                          check22 = c;
                          check23 = d;
                          check24 = e;
                          check25 = f;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    child: new Text(
                      'descending order:',
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in26,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed5 ? (check26 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in27,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed5 ? (check27 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in28,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed5 ? (check28 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in29,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed5 ? (check29 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in30,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed5 ? (check30 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ))
                      ])),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: new RaisedButton(
                      color: Colors.blueGrey[100],
                      child: Text("Check here"),
                      onPressed: () {
                        bool b = (in26.text != "") ? f25(int.parse(in26.text)) : false;
                        bool c = (in27.text != "") ? f24(int.parse(in27.text)) : false;
                        bool d = (in28.text != "") ? f23(int.parse(in28.text)) : false;
                        bool e = (in29.text != "") ? f22(int.parse(in29.text)) : false;
                        bool f = (in30.text != "") ? f21(int.parse(in30.text)) : false;
                        setState(() {
                          pressed5 = true;
                          check26 = b;
                          check27 = c;
                          check28 = d;
                          check29 = e;
                          check30 = f;
                        });
                      },
                    ),
                  ),
                ]),
              ),
              Container(
                margin: new EdgeInsets.only(left: 0.5, right: 0.5, top: 10),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(20.0),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.blueGrey[100],
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 0.0),
                    ),
                  ],
                ),
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    child: new Text(
                      'd). 3, 16, 8, 19, 2',
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Roboto',
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    child: new Text(
                      'ascending order:',
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in31,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: pressed7
                                      ? (check31 ? Colors.green : Colors.red)
                                      : Colors.white,
                                  border: OutlineInputBorder()),
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in32,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed7 ? (check32 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in33,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed7 ? (check33 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in34,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed7 ? (check34 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in35,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed7 ? (check35 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ))
                      ])),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: new RaisedButton(
                      color: Colors.blueGrey[100],
                      child: Text("Check here"),
                      onPressed: () {
                        bool b = (in31.text != "") ? f26(int.parse(in31.text)) : false;
                        bool c = (in32.text != "") ? f27(int.parse(in32.text)) : false;
                        bool d = (in33.text != "") ? f28(int.parse(in33.text)) : false;
                        bool e = (in34.text != "") ? f29(int.parse(in34.text)) : false;
                        bool f = (in35.text != "") ? f30(int.parse(in35.text)) : false;

                        setState(() {
                          pressed7 = true;
                          check31 = b;
                          check32 = c;
                          check33 = d;
                          check34 = e;
                          check35 = f;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    child: new Text(
                      'descending order:',
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in36,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed6 ? (check36 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in37,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed6 ? (check37 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in38,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed6 ? (check38 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in39,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed6 ? (check39 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Container(
                            width: 40.0,
                            height: 30.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: in40,
                              style: new TextStyle(fontSize: 11.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    pressed6 ? (check40 ? Colors.green : Colors.red) : Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ))
                      ])),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: new RaisedButton(
                      color: Colors.blueGrey[100],
                      child: Text("Check here"),
                      onPressed: () {
                        bool b = (in36.text != "") ? f30(int.parse(in36.text)) : false;
                        bool c = (in37.text != "") ? f29(int.parse(in37.text)) : false;
                        bool d = (in38.text != "") ? f28(int.parse(in38.text)) : false;
                        bool e = (in39.text != "") ? f27(int.parse(in39.text)) : false;
                        bool f = (in40.text != "") ? f26(int.parse(in40.text)) : false;
                        setState(() {
                          pressed6 = true;
                          check36 = b;
                          check37 = c;
                          check38 = d;
                          check39 = e;
                          check40 = f;
                        });
                      },
                    ),
                  ),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: new EdgeInsets.only(left: 0.0, top: 10),
                        child: new RaisedButton(
                            color: Colors.blueGrey[100],
                            child: Text("reset"),
                            onPressed: () {
                              in1.clear();
                              in2.clear();
                              in3.clear();
                              in4.clear();
                              in5.clear();
                              in6.clear();
                              in7.clear();
                              in8.clear();
                              in9.clear();
                              in10.clear();
                              in11.clear();
                              in12.clear();
                              in13.clear();
                              in14.clear();
                              in15.clear();
                              in16.clear();
                              in17.clear();
                              in18.clear();
                              in19.clear();
                              in20.clear();
                              in21.clear();
                              in22.clear();
                              in23.clear();
                              in24.clear();
                              in25.clear();
                              in26.clear();
                              in27.clear();
                              in28.clear();
                              in29.clear();
                              in30.clear();
                              in31.clear();
                              in32.clear();
                              in33.clear();
                              in34.clear();
                              in35.clear();
                              in36.clear();
                              in37.clear();
                              in38.clear();
                              in39.clear();
                              in40.clear();
                            })),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  bool f1(a) {
    if (a == 4)
      return true;
    else
      return false;
  }

  bool f2(b) {
    if (b == 6)
      return true;
    else
      return false;
  }

  bool f3(c) {
    if (c == 12)
      return true;
    else
      return false;
  }

  bool f4(d) {
    if (d == 18)
      return true;
    else
      return false;
  }

  bool f5(e) {
    if (e == 20)
      return true;
    else
      return false;
  }

  bool f6(a) {
    if (a == 1)
      return true;
    else
      return false;
  }

  bool f7(b) {
    if (b == 7)
      return true;
    else
      return false;
  }

  bool f8(c) {
    if (c == 10)
      return true;
    else
      return false;
  }

  bool f9(d) {
    if (d == 11)
      return true;
    else
      return false;
  }

  bool f10(e) {
    if (e == 19)
      return true;
    else
      return false;
  }

  bool f21(a) {
    if (a == 5)
      return true;
    else
      return false;
  }

  bool f22(b) {
    if (b == 9)
      return true;
    else
      return false;
  }

  bool f23(c) {
    if (c == 11)
      return true;
    else
      return false;
  }

  bool f24(d) {
    if (d == 17)
      return true;
    else
      return false;
  }

  bool f25(e) {
    if (e == 18)
      return true;
    else
      return false;
  }

  bool f26(a) {
    if (a == 2)
      return true;
    else
      return false;
  }

  bool f27(b) {
    if (b == 3)
      return true;
    else
      return false;
  }

  bool f28(c) {
    if (c == 8)
      return true;
    else
      return false;
  }

  bool f29(d) {
    if (d == 16)
      return true;
    else
      return false;
  }

  bool f30(e) {
    if (e == 19)
      return true;
    else
      return false;
  }
}
