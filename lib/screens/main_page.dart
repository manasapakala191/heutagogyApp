import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/services/database.dart';

import 'lessons.dart';
import 'home_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // String data;

  List<Widget> fillLessons() {
    List<Widget> subjects = [];
    List<String> subjectTitles = [
      "Chemistry",
      "Physics",
      "Biology",
      "Mathematics",
      "Geography",
      "History",
      "Civics"
    ];
    List<Color> startcols = [
      Colors.black,
      Color(0xFF9921E8),
      Color(0xFF74D680),
      Color(0xFF990000),
      Colors.black,
      Color(0xFF9921E8),
      Color(0xFF74D680)
    ];
    List<Color> endcols = [
      Colors.grey,
      Color(0xFF5F72BE),
      Color(0xFF378B29),
      Color(0xFFFF0000),
      Colors.grey,
      Color(0xFF5F72BE),
      Color(0xFF378B29)
    ];
    for (int i = 0; i < subjectTitles.length; i++) {
      subjects.add(
        InkWell(
          onTap: () {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

              // alignment: Alignment.left,
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(colors: [
                    startcols[i],
                    endcols[i],
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    subjectTitles[i],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return subjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "HEUTAGOGY",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w400)),
          )),
      body: StreamBuilder(
          stream: DatabaseService.getCourses(),
          builder: (context, AsyncSnapshot snapshot) {
            QuerySnapshot query = snapshot.data;
            if (snapshot.hasData) {
              return ListView.separated(
                  separatorBuilder: (context,index){
                    return Padding(padding: EdgeInsets.all(20),);
                  },
                  shrinkWrap: true,
                  itemCount: query.docs.length,
                  itemBuilder: (context, index) {
                    Map element = query.docs[index].data();
                    return Padding(
                        padding: EdgeInsets.all(20),
                        child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.blueAccent,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: InkWell(
                                splashColor: Color.fromARGB(40, 0, 0, 200),
                                onTap: () {
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => HomePage(element)));
                                },
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Text(
                                          element["title"],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Nunito',
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
                                            element["text"],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Nunito',
                                            ),
                                          ))
                                    ]))));
                  });
            } else {
              return Container(
                child: Text("Exciting courses coming up soon!"),
              );
            }
          }),
    );
  }
}
