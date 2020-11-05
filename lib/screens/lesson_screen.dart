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
import 'package:heutagogy/screens/tutorial_screen.dart';
import 'package:heutagogy/screens/test_screens/drag_drop_image_question_screen.dart';
import 'package:heutagogy/screens/test_screens/match_audio.dart';
import 'package:heutagogy/models/test_type_models/match_audio.dart';
import 'package:heutagogy/screens/test_screens/match_text_screen.dart';
import 'package:heutagogy/screens/test_screens/math_match_screen.dart';
import 'package:heutagogy/screens/test_screens/multiple_choice_image_question_screen.dart';
import 'package:heutagogy/screens/test_screens/multiple_choice_question_screen.dart';
import 'package:heutagogy/services/database.dart';

class LessonScreen extends StatelessWidget {
  final LessonData lessonData;
  final CourseData courseData;
  LessonScreen({this.courseData, this.lessonData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            lessonData.lname,
          ),
        ),
        body: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: DatabaseService.getSlidesForLessons(
              courseData.courseID, lessonData.lID),
          builder: (context, snapshot) {
            print(snapshot.data);
            // return Container(
            //     child: Text(snapshot.hasData.toString()));
            if (snapshot.hasError) {
              return Container(
                child: Text("Error!"),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return _buildSlides(snapshot.data);
                }
              }
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  _returnSlideScreen(String type, var data) {
    print("type" + type);
    var course_details = Map();
    course_details['l0'] = {
      "course_id": 'C3',
      "lesson_id": 'L1',
      "type": 'S2'
    };
    course_details['q0'] = {
      "course_id": 'C3',
      "lesson_id": 'L1',
      "type": 'S1'
    };
    course_details['q5'] = {
      "course_id": 'C3',
      "lesson_id": 'L1',
      "type": 'S4'
    };
    course_details['q3'] = {
      "course_id": 'C3',
      "lesson_id": 'L1',
      "type": 'S3'
    };
    course_details['q1'] = {
      "course_id": 'C1',
      "lesson_id": 'C1L1',
      "type": 'C1L1S3'
    };
    course_details['q2'] = {
      "course_id": 'C1',
      "lesson_id": 'C1L1',
      "type": 'C1L1S2'
    };
    course_details['q4'] = {
      "course_id": 'C1',
      "lesson_id": 'C1L1',
      "type": 'C1L1S1'
    };
    
    switch (type) {
      case 'l0':
        {
          //done
          return LessonViewer(lesson: Lesson.fromJson(data),type: course_details[type]["type"], courseID: course_details[type]["course_id"],lessonID: course_details[type]["lesson_id"]);
        }
        break;
      case 'q0':
        {
          //done
          return MatchText(matchPicWithText: MatchPicWithText.fromJSON(data),type: course_details[type]["type"], courseID: course_details[type]["course_id"],lessonID: course_details[type]["lesson_id"]);
        }
        break;
      case 'q1':
        {
          //done
          return MultipleChoiceImageQuestionScreen(
              imageQuestionTest: ImageQuestionTest.fromJson(data),type: course_details[type]["type"], courseID: course_details[type]["course_id"],lessonID: course_details[type]["lesson_id"]);
        }
        break;
      case 'q2':
        {
          //done
          return MultipleChoiceQuestionScreen(
              singleCorrectTest: SingleCorrectTest.fromJson(data),type: course_details[type]["type"], courseID: course_details[type]["course_id"],lessonID: course_details[type]["lesson_id"]);
        }
        break;
      case 'q3':
        {
          //done
          return DragDropImageScreen(DragDropImageTest.fromJSON(data), course_details[type]["type"], course_details[type]["course_id"], course_details[type]["lesson_id"]);
        }
        break;
      case 'q4':
        {
          //done
          return DragDropAudioScreen(DragDropAudioTest.fromJSON(data), course_details[type]["type"], course_details[type]["course_id"], course_details[type]["lesson_id"]);
        }
        break;
      case 'q5':
        {
          //done
          return MathMatchScreen(MathMatchTest.fromJSON(data), course_details[type]["type"], course_details[type]["course_id"], course_details[type]["lesson_id"]);
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

  _buildSlides(List<QueryDocumentSnapshot> data) {
    List types = ['l0','q0','q1','q2','q3','q4','q5'];

    print(data);
    return ListView.builder(
      itemCount: data.length,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int idx) {
        Map slideData = data[idx].data();
        print(slideData);
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
                    builder: (context) => _returnSlideScreen(
                      slideData["type"],
                      slideData,
                    ),
                  ),
                );
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
