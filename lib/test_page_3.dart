import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

class TestPage3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestPage3State();
  }
}

class _TestPage3State extends State<TestPage3> {
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
        child: Container(
      height: 1000,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100.0,
            margin: new EdgeInsets.only(left: 0.5, right: 0.5, top: 1),
            child: new Text(
              'the numbers are given in wrong manner set them according to ascending and descending order ',
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
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.blueGrey[100],
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
          ),
          Container(
            margin: new EdgeInsets.only(left: 0.5, right: 0.5, top: 10),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.blueGrey[100],
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            padding: const EdgeInsets.all(0.0),
            width: 600.0,
            height: 200.0,
            child: Column(children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: new Text(
                  'a. 6,18,12,4,20',
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                  child: Row(children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
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
                  width: 10.0,
                  height: 10.0,
                ),
                Container(
                    width: 40.0,
                    height: 30.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: in1,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: pressed ? (check ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed ? (check1 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed ? (check2 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed ? (check3 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed ? (check4 ? Colors.green : Colors.red) : Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ))
              ])),
              Container(
                child: new RaisedButton(
                  color: Colors.blueGrey[100],
                  child: Text("Check here"),
                  onPressed: () {
                    bool b = f1(int.parse(in1.text));
                    bool c = f2(int.parse(in2.text));
                    bool d = f3(int.parse(in3.text));
                    bool e = f4(int.parse(in4.text));
                    bool f = f5(int.parse(in5.text));

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
                  child: Row(children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
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
                    width: 40.0,
                    height: 30.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: in6,
                      style: new TextStyle(fontSize: 11.0, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: pressed1 ? (check10 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed1 ? (check11 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed1 ? (check12 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed1 ? (check13 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed1 ? (check14 ? Colors.green : Colors.red) : Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ))
              ])),
              Container(
                child: new RaisedButton(
                  color: Colors.blueGrey[100],
                  child: Text("Check here"),
                  onPressed: () {
                    bool b = f5(int.parse(in6.text));
                    bool c = f4(int.parse(in7.text));
                    bool d = f3(int.parse(in8.text));
                    bool e = f2(int.parse(in9.text));
                    bool f = f1(int.parse(in10.text));
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
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.blueGrey[100],
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            width: 600.0,
            height: 200.0,
            child: Column(children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: new Text(
                  'b. 11,10,7,19,1',
                  style: new TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Roboto',
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  child: Row(children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
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
                  width: 10.0,
                  height: 10.0,
                ),
                Container(
                    width: 40.0,
                    height: 30.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: in11,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: pressed2 ? (check5 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed2 ? (check6 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed2 ? (check7 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed2 ? (check8 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed2 ? (check9 ? Colors.green : Colors.red) : Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ))
              ])),
              Container(
                child: new RaisedButton(
                  color: Colors.blueGrey[100],
                  child: Text("Check here"),
                  onPressed: () {
                    bool b = f6(int.parse(in11.text));
                    bool c = f7(int.parse(in12.text));
                    bool d = f8(int.parse(in13.text));
                    bool e = f9(int.parse(in14.text));
                    bool f = f10(int.parse(in15.text));

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
                  child: Row(children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
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
                    width: 40.0,
                    height: 30.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: in16,
                      style: new TextStyle(fontSize: 11.0, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: pressed3 ? (check15 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed3 ? (check16 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed3 ? (check17 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed3 ? (check18 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed3 ? (check19 ? Colors.green : Colors.red) : Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ))
              ])),
              Container(
                child: new RaisedButton(
                  color: Colors.blueGrey[100],
                  child: Text("Check here"),
                  onPressed: () {
                    bool b = f10(int.parse(in16.text));
                    bool c = f9(int.parse(in17.text));
                    bool d = f8(int.parse(in18.text));
                    bool e = f7(int.parse(in19.text));
                    bool f = f6(int.parse(in20.text));

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
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.blueGrey[100],
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            width: 600.0,
            height: 200.0,
            child: Column(children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: new Text(
                  'c. 11,17,9,5,18',
                  style: new TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Roboto',
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  child: Row(children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
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
                  width: 10.0,
                  height: 10.0,
                ),
                Container(
                    width: 40.0,
                    height: 30.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: in21,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              pressed4 ? (check21 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed4 ? (check22 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed4 ? (check23 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed4 ? (check24 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed4 ? (check25 ? Colors.green : Colors.red) : Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ))
              ])),
              Container(
                child: new RaisedButton(
                  color: Colors.blueGrey[100],
                  child: Text("Check here"),
                  onPressed: () {
                    bool b = f21(int.parse(in21.text));
                    bool c = f22(int.parse(in22.text));
                    bool d = f23(int.parse(in23.text));
                    bool e = f24(int.parse(in24.text));
                    bool f = f25(int.parse(in25.text));

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
                  child: Row(children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
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
                    width: 40.0,
                    height: 30.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: in26,
                      style: new TextStyle(fontSize: 11.0, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: pressed5 ? (check26 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed5 ? (check27 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed5 ? (check28 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed5 ? (check29 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed5 ? (check30 ? Colors.green : Colors.red) : Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ))
              ])),
              Container(
                child: new RaisedButton(
                  color: Colors.blueGrey[100],
                  child: Text("Check here"),
                  onPressed: () {
                    bool b = f25(int.parse(in26.text));
                    bool c = f24(int.parse(in27.text));
                    bool d = f23(int.parse(in28.text));
                    bool e = f22(int.parse(in29.text));
                    bool f = f21(int.parse(in30.text));
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
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.blueGrey[100],
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            width: 600.0,
            height: 200.0,
            child: Column(children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: new Text(
                  'd. 3,16,8,19,2',
                  style: new TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Roboto',
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  child: Row(children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
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
                  width: 10.0,
                  height: 10.0,
                ),
                Container(
                    width: 40.0,
                    height: 30.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      controller: in31,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              pressed7 ? (check31 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed7 ? (check32 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed7 ? (check33 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed7 ? (check34 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed7 ? (check35 ? Colors.green : Colors.red) : Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ))
              ])),
              Container(
                child: new RaisedButton(
                  color: Colors.blueGrey[100],
                  child: Text("Check here"),
                  onPressed: () {
                    bool b = f26(int.parse(in31.text));
                    bool c = f27(int.parse(in32.text));
                    bool d = f28(int.parse(in33.text));
                    bool e = f29(int.parse(in34.text));
                    bool f = f30(int.parse(in35.text));

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
                  child: Row(children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
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
                    width: 40.0,
                    height: 30.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: in36,
                      style: new TextStyle(fontSize: 11.0, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: pressed6 ? (check36 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed6 ? (check37 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed6 ? (check38 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed6 ? (check39 ? Colors.green : Colors.red) : Colors.white,
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
                        fillColor: pressed6 ? (check40 ? Colors.green : Colors.red) : Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ))
              ])),
              Container(
                child: new RaisedButton(
                  color: Colors.blueGrey[100],
                  child: Text("Check here"),
                  onPressed: () {
                    bool b = f30(int.parse(in36.text));
                    bool c = f29(int.parse(in37.text));
                    bool d = f28(int.parse(in38.text));
                    bool e = f27(int.parse(in39.text));
                    bool f = f26(int.parse(in40.text));
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
              child: Row(children: <Widget>[
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
            Container(
                margin: new EdgeInsets.only(left: 180, top: 10),
                child: new RaisedButton(
                    color: Colors.blueGrey[100], child: Text("next"), onPressed: () {}))
          ]))
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
