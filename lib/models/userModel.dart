import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class UserModel extends ChangeNotifier{
  String name;
  String roll;
  String photoURL;
  bool isFirstTime;
  String currentPassword;
  var screentime;
  Map<String,dynamic> courses_enrolled;
  
  // Map<String,CourseModel> courses;
//  progress variable

  UserModel({this.isFirstTime,this.currentPassword,this.screentime,this.name,this.roll,this.photoURL,this.courses_enrolled});
  factory UserModel.fromJSON(){
    return UserModel();
  }


  void fillDataWhileSigningUp(String rNo, String passWord, bool isFirstTime, String name,Map courses_enrolled){
    this.roll = rNo;
    this.currentPassword = passWord;
    this.isFirstTime = isFirstTime;
    this.name = name;
    this.courses_enrolled=courses_enrolled;
    notifyListeners();
  }

  void fillDataWhileSigningIn(String name, String passWord, String rNo,Map courses_enrolled){
    this.roll = rNo;
    this.currentPassword = passWord;
    this.name = name;
    this.courses_enrolled=courses_enrolled;
    notifyListeners();
  }

  updateLesson(String cid, String lid){
    print("updating lesson"+lid);
    courses_enrolled[cid]["lesson"]=lid;
    notifyListeners();
  }

  updateSlide(String cid, String sid){
    print("updating slide"+sid);
    courses_enrolled[cid]["slide"]=sid;
    notifyListeners();
  }

  addCourse(String cid){
    courses_enrolled.addAll({
      cid: {
        "lesson": "",
        "slide": "",
      }
    },);
    notifyListeners();
  }
}