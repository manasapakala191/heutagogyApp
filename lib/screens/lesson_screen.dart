import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/course_model.dart';
import 'package:heutagogy/models/lessonModel.dart';
import 'package:heutagogy/models/lessons_models.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_test.dart';
import 'package:heutagogy/models/test_type_models/match_text_test.dart';
import 'package:heutagogy/models/test_type_models/math_match.dart';
import 'package:heutagogy/models/test_type_models/multiple_choice_question_test.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/tutorial_screen.dart';
import 'package:heutagogy/screens/test_screens/drag_drop_image_question_screen.dart';
import 'package:heutagogy/screens/test_screens/match_audio.dart';
import 'package:heutagogy/models/test_type_models/match_audio.dart';
import 'package:heutagogy/screens/test_screens/match_text_screen.dart';
import 'package:heutagogy/screens/test_screens/math_match_screen.dart';
import 'package:heutagogy/screens/test_screens/multiple_choice_image_question_screen.dart';
import 'package:heutagogy/screens/test_screens/multiple_choice_question_screen.dart';
import 'package:heutagogy/services/database.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatelessWidget {
  final LessonData lessonData;
  final CourseData courseData;
  LessonScreen({this.courseData, this.lessonData});

  @override
  Widget build(BuildContext context) {
    UserModel userModel=Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lessonData.lname,),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: DatabaseService.getSlidesForLessons(courseData.courseID, lessonData.lID),
        builder: (context,snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text("Error!"),
            );
          }
          else {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return _buildSlides(
                    snapshot.data, courseData.courseID);
              }
            }
            return Center(child: CircularProgressIndicator());
          }
        }
        ));
  }

  _returnSlideScreen(String type, var data, String sid, String cid, String lid) {
    print("type" + type);
    switch (type) {
      case 'l0':
        {
          //done
          return LessonViewer(lesson: Lesson.fromJson(data),type: sid, courseID: cid,lessonID: lid, isOffline: false);
        }
        break;
      case 'q0':
        {
          //done
          return MatchText(matchPicWithText: MatchPicWithText.fromJSON(data),type: sid, courseID: cid,lessonID: lid,typeOfData: "online");
        }
        break;
      case 'q1':
        {
          //done
          return MultipleChoiceImageQuestionScreen(
              imageQuestionTest: ImageQuestionTest.fromJson(data),type: sid, courseID: cid,lessonID: lid, typeOfData: "online",);
        }
        break;
      case 'q2':
        {
          return MultipleChoiceQuestionScreen(
              singleCorrectTest: SingleCorrectTest.fromJson(data),type: sid, courseID: cid,lessonID: lid, typeOfData: "online",);
        }
        break;
      case 'q3':
        {
          //done
          return DragDropImageScreen(DragDropImageTest.fromJSON(data),sid,cid,lid,"online");
        }
        break;
      case 'q4':
        {
          //done
          return DragDropAudioScreen(DragDropAudioTest.fromJSON(data),sid,cid,lid,"online");
        }
        break;
      case 'q5':
        {
          //done
          return MathMatchScreen(MathMatchTest.fromJSON(data),sid,cid,lid,"online");
        }
        break;
      default:
        {
          return Container(
            child: Text("No Such Type"),
          );
        }
        break;
    }
  }

  _buildSlides(List<QueryDocumentSnapshot> data,String cid) {
    List types = ['l0', 'q0', 'q1', 'q2', 'q3', 'q4', 'q5'];
    print(data);
    return Consumer<UserModel>(
        builder: (context, userModel, child) {
          return ListView.builder(
            itemCount: data.length,
            physics: ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int idx) {
              Map slideData=data[idx].data();
              print(slideData);
              return Padding(
                  padding: EdgeInsets.all(20),
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color:
                            (userModel.courses_enrolled[cid]["slide"]==slideData["sid"])? HexColor("#ed2a26"):  Color(0xffed2a26).withAlpha(5),
                            style: BorderStyle.solid,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: InkWell(
                          splashColor: Color.fromARGB(40, 0, 0, 200),
                          onTap: () {
                            print(userModel.courses_enrolled[cid]["slide"]);
                            userModel.updateSlide(cid, slideData["sid"]);
                            String sid = userModel.courses_enrolled[cid]["slide"];
                            String lid = userModel.courses_enrolled[cid]["lesson"];
                            print(":)   -----");
                            print(sid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        _returnSlideScreen(slideData["type"], slideData,sid,cid,lid)));
                          },
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Hero(
                                    tag: types[idx],
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        slideData["name"],
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
                                      slideData["description"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                      ),
                                    ))
                              ]))));
            });
        }
      );
  }
}
