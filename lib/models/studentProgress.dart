import 'package:flutter/cupertino.dart';
import 'package:heutagogy/models/time_object_model.dart';

class StudentProgress extends ChangeNotifier {
  Map<String, dynamic> coursePercentage =
      // dummy before integration
      {
    'C3': {
      'L1': {
        'S1': {'responses': {}, 'partsDone': 0, 'total': 4, 'percentage': 0.0},
        'S2': {'responses': {}, 'partsDone': 0, 'total': 4, 'percentage': 0.0},
        'S3': {'responses': {}, 'partsDone': 0, 'total': 4, 'percentage': 0.0},
        'S4': {'responses': {}, 'partsDone': 0, 'total': 4, 'percentage': 0.0},
      },
    },
    'C1': {
      'C1L1': {
        'C1L1S1': {'responses': {}, 'partsDone': 0, 'total': 4, 'percentage': 0.0},
        'C1L1S2': {'responses': {}, 'partsDone': 0, 'total': 4, 'percentage': 0.0},
        'C1L1S3': {'responses': {}, 'partsDone': 0, 'total': 4, 'percentage': 0.0},
      }
    }
  };

  // Map<String, dynamic> coursePercentage = {};

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

  void addResponses(String courseID, String lessonID, String type, List<String> responses) {
    int i = 0;
    for(var response in responses){
      coursePercentage[courseID][lessonID][type]["responses"].addAll({
        i.toString(): response,
      });
      i++;
    }
    print(coursePercentage);
    notifyListeners();
  }

  void setPerformance(String courseID, String lessonID, String type, int parts, int total) {
    print("setting");
    print(courseID+" "+lessonID+" "+type);
    print(coursePercentage);
    coursePercentage[courseID][lessonID][type]["partsDone"] = parts;
    print("partsdoone");
    coursePercentage[courseID][lessonID][type]["total"] = total;
    print("toootal");
    coursePercentage[courseID][lessonID][type]["percentage"] =
        ((parts / total).toDouble()) * 100;
        print("finall");
    notifyListeners();
  }

  Map<String, dynamic> getPerformance(String courseID, String lessonID, String type) {
    return coursePercentage[courseID][lessonID][type];
  }

  // void finishSlide(String lessonID){
  //   coursePercentage["C1"][lessonID]['partsDone']++;
  //   // coursePercentage["0"][lessonID]['percentage']=((coursePercentage["0"][lessonID]['partsDone']/coursePercentage["0"][lessonID]['total'])*100).toDouble();
  //   print("The percentage is ${coursePercentage["0"][lessonID]["percentage"]}");
  //   notifyListeners();
  // }

}
