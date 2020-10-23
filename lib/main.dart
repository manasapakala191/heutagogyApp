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
      MultiProvider(
        providers: [
          //add after signup
          ChangeNotifierProvider(create: (_) => UserModel()),
          // add after signup
          ChangeNotifierProvider(create: (_) => StudentPerfomance())
        ],
          child: MyApp()),
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
      body: Container(),
    );
  }

  void fetchData() async {
    await Firebase.initializeApp();
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
      ),
      home: CourseScreen(),
    );
  }
}

