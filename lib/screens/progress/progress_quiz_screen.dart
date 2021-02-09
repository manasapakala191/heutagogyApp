import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/models/course_model.dart';
import 'package:heutagogy/models/lessonModel.dart';
import 'package:heutagogy/models/lessons_models.dart';
import 'package:heutagogy/models/progress.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_multiple_test.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_test.dart';
import 'package:heutagogy/models/test_type_models/fill_the_blank_test.dart';
import 'package:heutagogy/models/test_type_models/match_text_test.dart';
import 'package:heutagogy/models/test_type_models/math_match.dart';
import 'package:heutagogy/models/test_type_models/missing_numbers_test.dart';
import 'package:heutagogy/models/test_type_models/multiple_choice_question_test.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:heutagogy/screens/widgets/customAppBar.dart';
import 'package:heutagogy/screens/score_screens/drag_drop_image_score.dart';
import 'package:heutagogy/screens/score_screens/drag_drop_multiple_score.dart';
import 'package:heutagogy/screens/score_screens/drag_drop_score.dart';
import 'package:heutagogy/screens/score_screens/drag_drop_text_score.dart';
import 'package:heutagogy/screens/score_screens/fill_in_the_blanks_result_viewer.dart';
import 'package:heutagogy/screens/score_screens/missing_numbers_result_screen.dart';
import 'package:heutagogy/screens/score_screens/result_screen.dart';
import 'package:heutagogy/screens/score_screens/single_correct_image_response_viewer.dart';
import 'package:heutagogy/screens/score_screens/single_correct_test_result_viewer.dart';
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

class ProgressQuizScreen extends StatelessWidget {
  final LessonData lessonData;
  final CourseData courseData;
  ProgressQuizScreen({this.courseData, this.lessonData});

  @override
  Widget build(BuildContext context) {
    UserModel userModel=Provider.of<UserModel>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: lessonData.lname,
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: DatabaseService.getSlidesForLessonsFromProgress(userModel.roll,courseData.courseID, lessonData.lID),
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
                    snapshot.data, courseData.courseID,lessonData.lID);
              }
            }
            return Center(child: CircularProgressIndicator());
          }
        }
        ));
  }

  /// Replace with the widgets for progress screen for each quiz here instead of quiz screens
  _returnSlideScreen(String type, var data,var slideResponse, String sid, String cid, String lid) {
    print("type" + type);
    print("response"+slideResponse.toString());
    Progress progress=Progress.fromJSON(slideResponse);
    print("progress: "+progress.toString());
    switch (type) {
      case 'l0':
        {
          //done
          return LessonViewer(lesson: Lesson.fromJson(data),type: sid, courseID: cid,lessonID: lid);
        }
        break;
      case 'q0':
        {
          //done
          return ResultScreen(
            matchPicWithText: MatchPicWithText.fromJSON(data),
            progress: progress,
          );
        }
        break;
      case 'q1':
        {
          //done
          return SingleCorrectImageResponseViewer(
            progress: progress,
            imageQuestionTest: ImageQuestionTest.fromJson(data),
          );
        }
        break;
      case 'q2':
        {
          return SingleCorrectResultViewer(
            progress: progress,
            singleCorrectTest: SingleCorrectTest.fromJson(data),
          );
        }
        break;
      case 'q3':
        {
          //done
          return DragDropImageScore(
            dragDropImageTest: DragDropImageTest.fromJSON(data),
            progress: progress,
          );
        }
        break;
      case 'q4':
        {
          //done
          return DragDropScoreWidget(
            questionTest: DragDropAudioTest.fromJSON(data),
            progress: progress,
          );
        }
        break;
      case 'q5':
        {
          //done
          return DragDropTextScore(
            mathMatchTest: MathMatchTest.fromJSON(data),
            progress: progress,
          );
        }
        break;
      case 'q6':
        {
          return FillInTheBlanksResultViewer(
            fillInBlankTest: FillInBlankTest.fromJSON(data),
            progress: progress,
          );
        }
        break;
      case 'q7':
        {
          return MissingNumbersResultScreen(
            missingNumbersTest: MissingNumbersTest.fromJSON(data),
            progress: progress,
          );
        }
        break;
      case 'q8':
        {
          return DragDropMultipleScore(
            dragDropMultipleTest: DragDropMultipleTest.fromJSON(data),
            progress: progress,
          );
        }
        break;
      case 'q9':
        {
          return DragDropMultipleScore(
            dragDropMultipleTest: DragDropMultipleTest.fromJSON(data),
            progress: progress,
          );
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

  _buildSlides(List<QueryDocumentSnapshot> data,String cid,String lid) {
    List types = ['l0', 'q0', 'q1', 'q2', 'q3', 'q4', 'q5'];
    print(data);
    return Consumer<UserModel>(
        builder: (context, userModel, child) {
          return ListView.builder(
            itemCount: data.length,
            physics: ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int idx) {
              Map slideData=data[idx].data();
              print("slideData:"+slideData.toString());
              print(data[idx].id);
              return FutureBuilder<Object>(
                future: DatabaseService.getSlide(cid,lid,data[idx].id),
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.done){
                    if(snapshot.hasError){
                      return Container(child: Text("There's an error"),);
                    }
                    if(snapshot.hasData && snapshot.data!=null){
                      DocumentSnapshot slideDoc=snapshot.data;
                      Map slideContent=slideDoc.data();
                      print(slideContent);
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
                                    print(userModel.courses_enrolled[cid]["slide"]);
                                    String sid = userModel.courses_enrolled[cid]["slide"];
                                    String lid = userModel.courses_enrolled[cid]["lesson"];
                                    print(":)   -----");
                                    print(sid);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                _returnSlideScreen(slideContent["type"], slideContent,slideData,sid,cid,lid)));
                                  },
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 16),
                                          child: Hero(
                                            tag: data[idx].id,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Text(
                                                slideContent["name"] == null ? "No name":slideContent["name"],
                                                // "Test",
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
                                              // slideData["description"] ? "No name": slideData["description"],
                                              "Progress here is "+slideData["percentage"].toString()+"%",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Nunito',
                                              ),
                                            ))
                                      ]))));
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              );
            });
        }
      );
  }
}
