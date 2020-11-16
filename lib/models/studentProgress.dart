import 'package:flutter/cupertino.dart';
import 'package:heutagogy/models/time_object_model.dart';

class StudentProgress extends ChangeNotifier {
  Map<String, dynamic> coursePercentage = {};

  List<TimeObject> get performanceTimes => [];

  // StudentProgress({this.coursePercentage});

  // void addCourse(String courseID){
  //   // dummy add for now
  //   coursePercentage.addAll(
  //     {
  //       courseID: {
  //         'percent':0,
  //         'slidenumber': 0,
  //         'totalSlides': 4,
  //       },
  //     }
  //   );
  // }

  void populate(Map json) {
    coursePercentage = json;
    notifyListeners();
  }

  // void finishSlide(String lessonID){
  //   coursePercentage["C1"][lessonID]['partsDone']++;
  //   // coursePercentage["0"][lessonID]['percentage']=((coursePercentage["0"][lessonID]['partsDone']/coursePercentage["0"][lessonID]['total'])*100).toDouble();
  //   print("The percentage is ${coursePercentage["0"][lessonID]["percentage"]}");
  //   notifyListeners();
  // }

}
