import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:heutagogy/home_page.dart';
import 'package:heutagogy/lessons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'json_read_write.dart';
import 'my_testing_page.dart';
import 'package:heutagogy/json_read_write.dart';

void main() {
  runApp(MyApp());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data;
  var loader;

  final JsonEncoder jsonEncoder = new JsonEncoder.withIndent('    ');
  @override
  void initState() {
    data = "";
    loader = CircularProgressIndicator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              ScaleTransition(
            child: child,
            scale: animation,
          ),
          child: loader,
        ),
      ),
    );
  }

  void fetchData() async {
    String offlineData = await readData();
    if (data == "") {
      try {
        final response =
            await http.get("https://1ashutosh.pythonanywhere.com/api/lessons5");
        if (response.statusCode == 200) {
          String body = response.body;
          writeData(body);
          setState(() {
            data = body;
            loader = Icon(
              Icons.check,
              color: Colors.green,
              size: 40.0,
            );
          });
        } else {
          if (offlineData != "{}") {
            setState(() {
              data = offlineData;
              loader = Icon(
                Icons.check,
                color: Colors.blue,
                size: 40.0,
              );
            });
          } else {
            setState(() {
              loader = Icon(
                Icons.signal_wifi_off,
                color: Colors.orange,
                size: 40.0,
              );
            });
          }
          // throw Exception("Unable to load!");s
        }
      } on SocketException catch (_) {
        //fetching data locally
        if (offlineData != "{}") {
          setState(() {
            data = offlineData;
            loader = Icon(
              Icons.check,
              color: Colors.grey,
              size: 40.0,
            );
          });
        } else {
          setState(() {
            loader = Icon(
              Icons.signal_wifi_off,
              color: Colors.red,
              size: 40.0,
            );
          });
        }
      }
    } else {
      Timer(Duration(milliseconds: 1100), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage(data)));
      });
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heutagogy',
      theme: ThemeData(fontFamily: 'Quicksand'),
      home: MyHomePage(),
    );
  }
}
