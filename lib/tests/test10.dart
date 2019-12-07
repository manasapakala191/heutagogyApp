import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Test10Page extends StatefulWidget {
  @override
  _Test10PageState createState() => _Test10PageState();
}

class _Test10PageState extends State<Test10Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "క్రింది గుణింతం చూసి ఆ గుణింత అక్షరంతో ఒక పదం చెప్పండి.",
              style: TextStyle(fontSize: 30,color: Colors.black),
            ),
          ),
          SizedBox(height:40),
          Center(
            child: Text(
              "కి",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Center(
              child: Text(
            "గో",
            style: TextStyle(fontSize: 25),
          )),
          Center(
              child: Text(
            "గో",
            style: TextStyle(fontSize: 25),
          )),
          Center(
              child: Text(
            "టం",
            style: TextStyle(fontSize: 25),
          )),
          Center(
              child: Text(
            "డే",
            style: TextStyle(fontSize: 25),
          )),
          Center(
              child: Text(
            "పొ",
            style: TextStyle(fontSize: 25),
          )),
          Center(
              child: Text(
            "రా",
            style: TextStyle(fontSize: 25),
          )),
          Center(
              child: Text(
            "తూ",
            style: TextStyle(fontSize: 25),
          )),
        ],
      ),
    );
  }
}
