import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/studentProgress.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_multiple_test.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_order_test.dart';
import 'package:heutagogy/models/test_type_models/fill_the_blank_test.dart';
import 'package:heutagogy/models/test_type_models/missing_numbers_test.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/courses_screen.dart';
import 'package:heutagogy/screens/login-resources/login.dart';
import 'package:heutagogy/screens/test_screens/drag_drop_order_screen.dart';
import 'package:heutagogy/screens/test_screens/fill_in_the_blanks_type.dart';
import 'package:heutagogy/screens/test_screens/missing_numbers_type.dart';
import 'package:provider/provider.dart';
import 'package:heutagogy/screens/test_screens/drag_drop_multiple.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      //add after signup
      ChangeNotifierProvider(create: (_) => UserModel()),
      // add after signup
      ChangeNotifierProvider(create: (_) => StudentProgress()),
    ], child: MyApp()),
  );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isAlreadyLoggedIn;

  _checkIfAlreadyLoggedIn() async{
    final credentialsStorage = await SharedPreferences.getInstance();
    String password = credentialsStorage.getString('password');
    if(password == null){
      _isAlreadyLoggedIn = false;
    }
    else{
      _isAlreadyLoggedIn = true;
      String rollNumber = credentialsStorage.getString('rollNumber');
      String name = credentialsStorage.getString('name');
      String photoURL = credentialsStorage.getString('photoURL');
      List<String> courses = credentialsStorage.getStringList('courses');
      if(courses != null && courses.isNotEmpty){
        Map<String,dynamic> coursesMap = {};
        // Map<String, dynamic> temp = {};
        for(var course in courses){
          // temp[course] = {};
          coursesMap[course] = {};
        }
        print(coursesMap);
        final userModel = Provider.of<UserModel>(context,listen: false);
        print("-=");
        userModel.fillDataWhileSigningIn(name, password, rollNumber, photoURL, coursesMap);
        print("+=");
      }
    }
    setState((){});
    print("Login");
    print(_isAlreadyLoggedIn);
  }

  @override
  void initState(){
    super.initState();
    _checkIfAlreadyLoggedIn();
  }

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
                    print("Status is ");
                    print(_isAlreadyLoggedIn);
                    Timer(
                        Duration(milliseconds: 500),
                        () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    (_isAlreadyLoggedIn == true)?CoursesHomeScreen():LoginPage())));
                    return IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (_isAlreadyLoggedIn == true)?CoursesHomeScreen():LoginPage()));
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
  Map<String,dynamic> json= {
      "name": "TestName",
      "description": "Place in ascending order.",
    "sid": "S23",
    "subject": "math",
    "type": "q9",
    "questions": [{
        "question": ["2","5","8","11","14"],
    },
      {
        "question": ["6","7","8","13","17"],
      }
    ]
  };
  Map<String,dynamic> jsonD = {
    "name": "Game",
    "description": "Put the words/pictures into appropriate boxes",
    "sid": "S100",
    "subject": "English",
    "type": "q8",
    "questions": [
      {
        "second": "Hari",
        "first": "Person"
      },
      {
        "second": "cow",
        "first": "Animal"
      },
      {
        "second": "stone",
        "first": "Thing"
      },
      {
        "second": "box",
        "first": "Thing"
      },
      {
        "second": "Vijayawada",
        "first": "Place"
      },
      {
        "second": "Gita",
        "first": "Person"
      },
      {
        "second": "fox",
        "first": "Animal"
      },
    ],
    "categories": ["Person","Place","Animal","Thing"]
  };
  Map<String,dynamic> jsonData={
    "name": "TestName",
    "description": "Place in ascending order",
    "sid": "S23",
    "subject": "math",
    "type": "q6",
    "questions": [
      {
        "question": "This is a random question",
        "correctText": "random",
      },
      {
        "question": "This is a randomer question",
        "correctText": "randomer",
      },
      {
        "question": "This is the randomest question",
        "correctText": "randomest",
      }
    ]
  };
  Map<String,dynamic> jsonData0={
    "name": "TestName",
    "description": "Fill in the missing number",
    "sid": "S23",
    "subject": "math",
    "type": "q7",
    "start": 1,
    "end": 100,
    "missingList": [33,36,48,50,78,100],
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heutagogy',
      theme: ThemeData(
        // Gambol Themes:  https://coolors.co/fdcc0d-ab4e68-ed2a26-e5e0e5-fba346-ffecec
        backgroundColor: Colors.white,
        primaryColor: HexColor('#ed2a26'),
        fontFamily: 'Monsterrat',
        appBarTheme: AppBarTheme(
          color: HexColor('#ed2a26'),
          // color: Colors.white,

          // textTheme: TextTheme(
          //   caption: TextStyle(color: HexColor('#ed2a26'))
          // )
        )
      ),
      home:
        // MissingNumbersTestType(MissingNumbersTest.fromJSON(jsonData0),"S1","C2","L!"),
      // FillInTheBlankType(FillInBlankTest.fromJSON(jsonData),"S2","L2","C3")
      // DragDropMultipleScreen(DragDropMultipleTest.fromJSON(jsonD),"q9","L1","C1")
      // DragDropOrderScreen(DragDropOrderTest.fromJSON(json),"q11","L1","C1"),
      MyHomePage(),
    );
  }
}



// to update Firestore when the app is closed, it's not working now though
// class LifecycleWatcher extends StatefulWidget {
//   @override
//   _LifecycleWatcherState createState() => _LifecycleWatcherState();
// }
//
// class _LifecycleWatcherState extends State<LifecycleWatcher> with WidgetsBindingObserver {
//   AppLifecycleState _notification;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     setState(() {
//       _notification = state;
//     });
//
//     if(_notification==AppLifecycleState.inactive){
//       print("out");
//       DatabaseService.updateCoursesAndSlides(context);
//     //  db. update courses and slide numbers
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_notification == null || _notification==AppLifecycleState.resumed)
//       return MyHomePage();
//     return Container();
//   }
// }