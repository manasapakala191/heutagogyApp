import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/studentPerformance.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/course_screen.dart';
import 'package:heutagogy/screens/lessons_screen.dart';
import 'package:heutagogy/screens/login-resources/login.dart';
import 'package:heutagogy/screens/login-resources/register.dart';
import 'package:heutagogy/screens/test_screens/match_text_screen.dart';
import 'package:heutagogy/screens/test_screens/multiple_choice_image_question_screen.dart';
import 'package:heutagogy/screens/test_screens/multiple_choice_question_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      //add after signup
      ChangeNotifierProvider(create: (_) => UserModel()),
      // add after signup
      ChangeNotifierProvider(create: (_) => StudentPerfomance())
    ], child: MyApp()),
  );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // fetchData();
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              ScaleTransition(
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
              // loader,
              FutureBuilder(
                future: Firebase.initializeApp(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Icon(
                      Icons.signal_wifi_off,
                      color: Colors.orange,
                      size: 80.0,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Timer(
                        Duration(milliseconds: 500),
                        () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginPage())));
                    return IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 80.0,
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heutagogy',
      theme: ThemeData(
        // Gambol Themes:  https://coolors.co/fdcc0d-ab4e68-ed2a26-e5e0e5-fba346-ffecec
        backgroundColor: Colors.white,
        primaryColor: Color(0xFFED2A26),
        fontFamily: 'Monsterrat',
      ),
      home: MyHomePage(),
    );
  }
}
