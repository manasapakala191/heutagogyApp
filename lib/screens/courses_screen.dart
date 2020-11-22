import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/course_model.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/course_screen.dart';
import 'package:heutagogy/screens/login-resources/login.dart';
import 'package:heutagogy/screens/misc-screens/profile.dart';
import 'package:heutagogy/screens/progress/progress_screen.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';

// courses with (+) for adding a new course

class CoursesHomeScreen extends StatefulWidget {
  @override
  _CoursesHomeScreenState createState() => _CoursesHomeScreenState();
}

class _CoursesHomeScreenState extends State<CoursesHomeScreen> {
  final _formCourseKey = GlobalKey<FormState>();
  String courseCode = "";
  bool add;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Heutagogy',
          style: TextStyle(color: HexColor("#ed2a26")),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(child: Text("Hi")),
              decoration: BoxDecoration(
                color: HexColor("#ed2a26"),
              ),
            ),
            ListTile(
              title: Text("My Profile"),
              trailing: Icon(Icons.account_circle),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage();
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: Text("My Progress"),
              trailing: Icon(Icons.assignment_turned_in),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProgressScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Settings"),
              trailing: Icon(Icons.settings),
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.logout),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: HexColor("#ed2a26"),
        onPressed: () async {
          bool add = false;
          bool added = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AlertDialog(
                    actions: [
                      FlatButton(
                          onPressed: () {
                            print(courseCode);
                            if (_formCourseKey.currentState.validate()) {
                              _formCourseKey.currentState.save();
                              Navigator.pop(context, true);
                            }
                          },
                          child: Text("Add")),
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text("Cancel"))
                    ],
                    title: Text('Add New Course'),
                    content: Container(
                      width: _screenSize.width * 0.3,
                      child: Form(
                        key: _formCourseKey,
                        child: TextFormField(
                          onSaved: (val) {
                            setState(() {
                              courseCode = val;
                            });
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              print("empty");
                              return "Type a course code.";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ));
          if (added) {
            await showAdding(userModel.roll, userModel);
          }
        },
      ),
      body: Center(
        child: Container(
          // child: Text(courses.length.toString()),
          child: (userModel.courses_enrolled != null &&
                  userModel.courses_enrolled.isNotEmpty)
              ? StreamBuilder<List<CourseData>>(
                  stream: DatabaseService.populateCourse(
                      userModel.courses_enrolled),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        child: Center(
                            child: Text("Error!" + snapshot.error.toString())),
                      );
                    } else {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          List<CourseData> course = snapshot.data;
                          return ListView.builder(
                            itemCount: course.length,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (BuildContext context, int idx) {
                              return Padding(
                                padding: EdgeInsets.all(20),
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: HexColor("#ed2a26"),
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: InkWell(
                                    splashColor: Color.fromARGB(40, 0, 0, 200),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CourseScreen(course[idx])));
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 16),
                                          child: Hero(
                                            tag: course[idx].courseID,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Text(
                                                course[idx].courseName,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Nunito',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black87,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                left: 20,
                                                right: 20,
                                                bottom: 20),
                                            child: Text(
                                              course[idx].description,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Nunito',
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }
                      return CircularProgressIndicator();
                    }
                  },
                )
              : Container(
                  child: Text(
                    "No courses yet. \n"
                    "Tap + to add a course",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
      ),
    );
  }

  showAdding(String roll, UserModel userModel) {
    final _screenSize = MediaQuery.of(context).size;
    return _scaffoldkey.currentState
        .showSnackBar(SnackBar(
          content: Container(
            height: _screenSize.height * 0.03,
            child: FutureBuilder(
                future: DatabaseService.courseFilter(courseCode),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      if (snapshot.data == true) {
                        add = true;
                        DatabaseService.addNewCourse(courseCode, roll);
                        return Icon(Icons.check_circle);
                      } else {
                        add = false;
                        return Text("No such course code");
                      }
                    } else if (snapshot.hasError) {
                      return Text("Problem!");
                    }
                  }
                  return Container(
                      height: _screenSize.height * 0.03,
                      width: _screenSize.width * 0.3,
                      child: Center(child: CircularProgressIndicator()));
                }),
          ),
        ))
        .closed
        .then((value) {
      print(add);
      if (add) userModel.addCourse(courseCode);
    });
  }
}
