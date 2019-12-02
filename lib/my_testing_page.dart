import 'package:flutter/material.dart';
import 'package:heutagogy/data_models.dart';
import 'package:heutagogy/tests/test2.dart';
import 'dart:convert';

import 'package:heutagogy/tests/test4.dart';
import 'package:heutagogy/tests/test7.dart';
import 'package:heutagogy/tests/test8.dart';
import 'package:heutagogy/tests/test9.dart';

class Page1 extends StatelessWidget {
  Page1({Key key}) : super(key: key);
  final Test9Data test2data = Test9Data.fromJSON(json.decode(
      '{\"heading\":\"Hello\", \"questions\":[\r\n{\"first\":\"data1\",\"second\":\"power1\"},\r\n{\"first\":\"data2\",\"second\":\"power2\"},\r\n{\"first\":\"data3\",\"second\":\"power3\"}\r\n]}'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(),
        body: Test9Page(test2data),
      ),
    );
  }
}
