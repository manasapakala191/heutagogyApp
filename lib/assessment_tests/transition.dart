import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heutagogy/assessment_tests/test5.dart';
import 'package:heutagogy/data_models.dart';
import 'package:heutagogy/assessment_tests/test1.dart';
import 'package:heutagogy/assessment_tests/test2.dart';
import 'package:heutagogy/assessment_tests/test3.dart';
import 'package:heutagogy/assessment_tests/test4.dart';
import 'package:heutagogy/assessment_tests/test6.dart';
import 'package:heutagogy/assessment_tests/test7.dart';
import 'package:heutagogy/assessment_tests/test9.dart';

import 'dart:math';

import 'package:heutagogy/my_stepper.dart';
import 'package:heutagogy/well_done_page.dart';

class TransitionPage extends StatefulWidget{
  final String subject;
  TransitionPage({this.subject});
  @override
  _TransitionPageState createState()=>_TransitionPageState();
}
class _TransitionPageState extends State<TransitionPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.subject.toUpperCase(),style: TextStyle(fontSize:36 ),),
        ],
      ),
    );
  }
}