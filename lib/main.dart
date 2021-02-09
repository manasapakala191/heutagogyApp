import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/studentProgress.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/courses_screen.dart';
import 'package:heutagogy/screens/login-resources/login.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';
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
        )
      ),
      home: MyHomePage(),
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