import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/course_model.dart';
import 'package:heutagogy/models/lessonModel.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/lesson_screen.dart';
import 'package:heutagogy/screens/progress/progress_quiz_screen.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';

class ProgressSubScreen extends StatelessWidget {
  ProgressSubScreen(this.courseData);
  final CourseData courseData;

  @override
  Widget build(BuildContext context) {
    
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Progress in "+courseData.courseName),
          ),
          body: Container(
            child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Card(
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                  child: Center(child: Text(courseData.description,style: TextStyle(fontSize: 20),))
                  ),
                ),
                FutureBuilder<List<LessonData>>(
                    future:
                        DatabaseService.getLessonsForCourseFromProgress(userModel.roll,courseData.courseID),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          child: Text("Error!"),
                        );
                      } else {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            print("It is here!!");
                            print(snapshot.data);
                            List<LessonData> lessons = snapshot.data;
                            return ListView.builder(
                                itemCount: lessons.length,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int idx) {
                                  return Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Card(
                                          clipBehavior: Clip.antiAlias,
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: (userModel.courses_enrolled[courseData.courseID]["lesson"]==lessons[idx].lID) ? HexColor("#ed2a26") : Colors.black,
                                                style: BorderStyle.solid,
                                                width: 1.0),
                                            borderRadius: BorderRadius.circular(16.0),
                                          ),
                                          child: InkWell(
                                              splashColor: Color.fromARGB(40, 0, 0, 200),
                                              onTap: () {
                                                // print(userModel.courses_enrolled[courseData.courseID]["lesson"]);
                                                // userModel.updateLesson(courseData.courseID, lessons[idx].lID);
                                                Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ProgressQuizScreen(
                                                                        courseData: courseData,
                                                                        lessonData: lessons[idx])));
                                              },
                                              child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 16),
                                                      child: Hero(
                                                        tag: lessons[idx].lID,
                                                        child: Material(
                                                          color: Colors.transparent,
                                                          child: Text(
                                                            lessons[idx].lname,
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
                                                            top: 10, left: 20, right: 20, bottom: 20),
                                                        child: Text(
                                                          lessons[idx].ldescription,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily: 'Nunito',
                                                          ),
                                                        ))
                                                  ]))));
                                });
                          }
                          else{
                            return Text("No lessons yet!");
                          }
                        }
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ],
            ),
          ),
        );
      }
    );
  }
}
