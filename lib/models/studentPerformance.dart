import 'package:flutter/cupertino.dart';

class StudentPerformance extends ChangeNotifier{
  Map<String, dynamic> coursePercentage=
  // dummy before integration
  {
    'C1': {
      '0': {
        'responses': {},
        'partsDone': 0,
        'total': 4,
        'percentage': 0.0
      },
      '1': {
        'responses': {},
        'partsDone': 0,
        'total': 4,
        'percentage': 0.0
      },
      '2': {
        'responses': {},
        'partsDone': 0,
        'total': 4,
        'percentage': 0.0
      },
      '3': {
        'responses': {},
        'partsDone': 0,
        'total': 4,
        'percentage': 0.0
      },
      '4': {
        'responses': {},
        'partsDone': 0,
        'total': 4,
        'percentage': 0.0
      },
      '5': {
        'responses': {},
        'partsDone': 0,
        'total': 4,
        'percentage': 0.0
      },
      '6': {
        'responses': {},
        'partsDone': 0,
        'total': 4,
        'percentage': 0.0
      }
    }
  };

  
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

    void addResponses(String lessonID, List<String> responses){
      int i=0;
      for(var val in responses){
        coursePercentage["C1"][lessonID]["responses"].addAll(
          {
            i.toString(): val,
          }
        );
        i++;
      }
      print(coursePercentage);
    }

    void setPerformance(String lessonID,int parts,int total){
      coursePercentage["C1"][lessonID]["partsDone"] = parts;
      coursePercentage["C1"][lessonID]["total"] = total;
      coursePercentage["C1"][lessonID]["percentage"] = ((parts/total).toDouble())*100;
      notifyListeners();
    }

    Map<String, dynamic> getPerformance(){
      return coursePercentage["C1"];
    }



    // void finishSlide(String lessonID){
    //   coursePercentage["C1"][lessonID]['partsDone']++;
    //   // coursePercentage["0"][lessonID]['percentage']=((coursePercentage["0"][lessonID]['partsDone']/coursePercentage["0"][lessonID]['total'])*100).toDouble();
    //   print("The percentage is ${coursePercentage["0"][lessonID]["percentage"]}");
    //   notifyListeners();
    // }

}