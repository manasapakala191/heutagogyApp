import 'package:flutter/cupertino.dart';

class StudentProgress extends ChangeNotifier{
  Map coursePercentage=
  // dummy before integration
  {
    'courseID': {
      'name': 'courseName',
      'percent': 0,
      'lessonNumber': 0,
      'slidenumber': 0,
      'totalSlides': 0,
    },
  };

  StudentProgress({ this.coursePercentage});

  // factory StudentProgress.fromJSON(Map<String, dynamic> json){
  //   return StudentProgress(
  //     coursePercentage: {
  //       json
  //     }
  //   );
  // }

  void populate(Map json){
    coursePercentage=json;
    notifyListeners();
  }
  void addCourse(String courseID){
    // dummy add for now
    coursePercentage.addAll(
      {
        courseID: {
          'percent':0,
          'slidenumber': 0,
          'totalSlides': 4,
        },
      }
    );
  }

  void finishSlide(String courseID){
    coursePercentage[courseID]['slidenumber']++;
    coursePercentage[courseID]['percent']=(coursePercentage[courseID]['slidenumber']/coursePercentage[courseID]['totalslides'])*100;
    notifyListeners();
  }
}