import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/course_model.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/course_screen.dart';
import 'package:heutagogy/screens/offline-screens/offline_course_screen.dart';
import 'package:heutagogy/services/localFileService.dart';
import 'package:provider/provider.dart';

class OfflineMainScreen extends StatefulWidget {

  @override
  _OfflineMainScreenState createState() => _OfflineMainScreenState();
}

class _OfflineMainScreenState extends State<OfflineMainScreen> {
    var connectivity;
    bool isConnected = true;
    StreamSubscription<ConnectivityResult> subscription;
    @override
    void initState(){
      super.initState();
      connectivity = new Connectivity();
      subscription = connectivity.onConnectivityChanged.listen(
        (ConnectivityResult result){
          print(result);
          isConnected = (result != ConnectivityResult.none);
        }
      );
      setState((){});
    }
    @override
    void dispose(){
      subscription.cancel();
      super.dispose();
    }
  @override
  Widget build(BuildContext context) {
    print("Built!");
    final userModel = Provider.of<UserModel>(context);
    final _screenSize = MediaQuery.of(context).size;
    // List<Future<CourseData>> courses = LocalFileService.fetchCourses(userModel.courses_enrolled);
    // subscription = connectivity.onConnectivityChanged.listen(
    //     (ConnectivityResult result){
    //       print(result);
    //       isConnected = (result != ConnectivityResult.none);
    //     }
    //   );
    return Center(
        child: Container(
          // child: Text(courses.length.toString()),
          child: (userModel.courses_enrolled != null &&
                  userModel.courses_enrolled.isNotEmpty)
              ? 
              FutureBuilder<List<CourseData>>(
                  future: LocalFileService.fetchCourses(
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
                              return course[idx] == null? Container():Padding(
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
                                                  OfflineCourseScreen(course[idx])));
                                                  // (isConnected == true)?CourseScreen(course[idx]):
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: _screenSize.width*0.7,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(top: 16),
                                                child: Hero(
                                                  tag: course[idx].courseID,
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: Text(
                                                      course[idx].courseName,
                                                      style:
                                                          GoogleFonts.roboto(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.black87,
                                              ),
                                              Container(
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
                                                    overflow:
                                                        TextOverflow.clip,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        
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
                      // return OfflineMainScreen();
                    }
                  },
                )
              : Container(
                  child: Text(
                    "No courses yet. \n"
                    "Download when online",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        );
  }
}
