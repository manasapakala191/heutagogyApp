import 'package:flutter/cupertino.dart';

class StudentPerfomance extends ChangeNotifier{
  Map<String, Map> coursePercentage=
  // dummy before integration
  {
    'courseID': {
      'percent': 0,
      'lessonNumber': 0,
      'slidenumber': 0,
      'totalSlides': 0,
    },
  };

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