import 'package:flutter/cupertino.dart';

class CourseData{
  String courseID;
  String courseName;
  String description;
  int level;

  CourseData({@required this.courseID,@required this.courseName,this.description, this.level});

  factory CourseData.fromJSON(Map<String,dynamic> json){
    print(json);
    return CourseData(
        courseID: json['course_id'],
        courseName: json['course_name'],
        description: json['general_info'],
        level: json['level'],
    );
  }
}

