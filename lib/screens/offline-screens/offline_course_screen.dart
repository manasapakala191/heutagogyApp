import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/course_model.dart';
import 'package:heutagogy/models/lessonModel.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/lesson_screen.dart';
import 'package:heutagogy/screens/offline-screens/offliine_lesson_screen.dart';
import 'package:heutagogy/services/localFileService.dart';
import 'package:provider/provider.dart';

class OfflineCourseScreen extends StatefulWidget {
  OfflineCourseScreen(this.courseData);
  final CourseData courseData;

  @override
  _OfflineCourseScreenState createState() => _OfflineCourseScreenState();
}

class _OfflineCourseScreenState extends State<OfflineCourseScreen> {
  var connectivity;
    bool isConnected;
    StreamSubscription<ConnectivityResult> subscription;
    _updateConnectivityInformation() async {
      connectivity = new Connectivity();
      isConnected = ((await connectivity.checkConnectivity()) != ConnectivityResult.none);
      setState((){});
      subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result){
        print("Subscription result below");
        print(result);
        setState((){
          isConnected = (result != ConnectivityResult.none);
        });
      });
      subscription.cancel();
  }
    @override
    void initState(){
      super.initState();
      _updateConnectivityInformation();
    }
  @override
  Widget build(BuildContext context) {
    // UserModel userModel=Provider.of<UserModel>(context);
    final _screenSize = MediaQuery.of(context).size;
    // subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result){
    //     print(result);
    //     isConnected = (result != ConnectivityResult.none);
    //   });
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.courseData.courseName),
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
                  child: Center(child: Text(widget.courseData.description,style: TextStyle(fontSize: 20),))
                  ),
                ),
                FutureBuilder<List<LessonData>>(
                    future:
                        LocalFileService.fetchLessonsOfCourse(widget.courseData.courseID),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          child: Text("Error!"),
                        );
                      } else {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
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
                                                color: (userModel.courses_enrolled[widget.courseData.courseID]["lesson"]==lessons[idx].lID) ? HexColor("#ed2a26") : Color(0xffed2a26).withAlpha(5),
                                                style: BorderStyle.solid,
                                                width: 1.0),
                                            borderRadius: BorderRadius.circular(16.0),
                                          ),
                                          child: InkWell(
                                              splashColor: Color.fromARGB(40, 0, 0, 200),
                                              onTap: () {
                                                print(userModel.courses_enrolled[widget.courseData.courseID]["lesson"]);
                                                userModel.updateLesson(widget.courseData.courseID, lessons[idx].lID);
                                                Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => OfflineLessonScreen(
                                                                        courseData: widget.courseData,
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
