import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/course_model.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/course_screen.dart';
import 'package:heutagogy/screens/login-resources/login.dart';
import 'package:heutagogy/screens/widgets/custom_app_bar.dart';
import 'package:heutagogy/screens/widgets/custom_floating_action_button.dart';
import 'package:heutagogy/screens/widgets/drawer_widget.dart';
import 'package:heutagogy/screens/misc-screens/profile.dart';
import 'package:heutagogy/screens/offline-screens/offline_course_screen.dart';
import 'package:heutagogy/screens/progress/progress_screen.dart';
import 'package:heutagogy/services/database.dart';
import 'package:heutagogy/services/localFileService.dart';
import 'package:provider/provider.dart';

class OfflineMainScreen extends StatefulWidget {

  @override
  _OfflineMainScreenState createState() => _OfflineMainScreenState();
}

class _OfflineMainScreenState extends State<OfflineMainScreen> {
    var connectivity;
    bool isConnected;
    StreamSubscription<ConnectivityResult> subscription;
    final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

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
   final userModel = Provider.of<UserModel>(context);
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      floatingActionButton: CustomFloatingActionButton(scaffoldkey: _scaffoldkey),
      body: Center(
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
}
