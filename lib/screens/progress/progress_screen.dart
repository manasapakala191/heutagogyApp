import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/course_model.dart';
import 'package:heutagogy/models/lessonModel.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/course_screen.dart';
import 'package:heutagogy/screens/handyWidgets/customAppBar.dart';
import 'package:heutagogy/screens/lesson_screen.dart';
import 'package:heutagogy/screens/progress/progress_sub_screen.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';

class ProgressScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Progress",
          ),
          backgroundColor: Colors.white,
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
                                        color: HexColor("#607196"),
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
                                                  ProgressSubScreen(course[idx])));
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
                    "No courses yet. \n",
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
    );
  }
}
