import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

// class CourseModel{
//   String name;
//   String description;
//   Map<String,LessonPair> lessons;
// }

class UserModel extends ChangeNotifier{
  String uid;
  String name;
  String roll;
  String photoURL;
  var screentime;
  List<String> courses_enrolled;
  
  // Map<String,CourseModel> courses;
//  progress variable

  UserModel({this.uid,this.name,this.roll,this.photoURL,this.courses_enrolled});
  factory UserModel.fromJSON(){
    return UserModel();
  }
}