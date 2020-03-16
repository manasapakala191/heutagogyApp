import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:heutagogy/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'json_read_write.dart';
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
  String data, assessment;
  var loader;

  final JsonEncoder jsonEncoder = new JsonEncoder.withIndent('    ');

  @override
  void initState() {
    data = "";
    assessment = "";
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
          transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(
            child: child,
            scale: animation,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "HEUTAGOGY",
                style: TextStyle(fontSize: 60),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 60),
              ),
              loader,
              Padding(
                padding: EdgeInsets.only(bottom: 100),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "by",
                    style: TextStyle(fontSize: 18),
                  ),
                  Image.asset(
                    "assets/images/HappyAddaLogo.png",
                    width: 200,
                    height: 70,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fetchData() async {
    String offlineData = await readData();
    String offlineData2 = await readData2();
    if (data == "" || assessment == "") {
      try {
        final response = await http.get("https://heutagogy.pythonanywhere.com/api/lessons");
        if (response.statusCode == 200) {
          String body = response.body;
          writeData(body);
          setState(() {
            data = body;
            loader = Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80.0,
            );
          });
        } else {
          if (offlineData != "{}") {
            setState(() {
              data = offlineData;
              loader = Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 80.0,
              );
            });
          } else {
            setState(() {
              loader = Icon(
                Icons.signal_wifi_off,
                color: Colors.orange,
                size: 80.0,
              );
            });
          }
        }
        final response2 = await http.get("https://heutagogy.pythonanywhere.com/api/assessment");
        if (response.statusCode == 200) {
          String body = response2.body;
          writeData2(body);
          setState(() {
            assessment = body;
            loader = Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80.0,
            );
          });
        } else {
          if (offlineData2 != "{}") {
            setState(() {
              data = offlineData;
              loader = Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 80.0,
              );
            });
          } else {
            setState(() {
              loader = Icon(
                Icons.signal_wifi_off,
                color: Colors.orange,
                size: 80.0,
              );
            });
          }
        }
      } on SocketException catch (_) {
        //fetching data locally
        if (offlineData != "{}") {
          setState(() {
            data = offlineData;
            loader = Icon(
              Icons.check_circle,
              color: Colors.grey,
              size: 80.0,
            );
          });
        } else {
          setState(() {
            loader = Icon(
              Icons.signal_wifi_off,
              color: Colors.red,
              size: 80.0,
            );
          });
        }
      }
    } else {
      Timer(Duration(milliseconds: 1100), () {
        print(assessment);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage(data, assessment)));
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
