import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heutagogy/data_models.dart';
import 'package:heutagogy/tests/test1.dart';
import 'package:heutagogy/tests/test2.dart';
import 'package:heutagogy/tests/test3.dart';
import 'package:heutagogy/tests/test4.dart';
import 'package:heutagogy/tests/test5.dart';
import 'dart:math';
import 'dart:io';
import 'package:heutagogy/tests/test8.dart';
import 'package:heutagogy/well_done_page.dart';
import 'package:youtube_player/youtube_player.dart';

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
