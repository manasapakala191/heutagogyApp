import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
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

  String getID(){
    return this.roll;
  }


  void fillDataWhileSigningUp(String rNo, String passWord, bool isFirstTime, String name,String photoURL,Map courses_enrolled){
    this.roll = rNo;
    this.currentPassword = passWord;
    this.isFirstTime = isFirstTime;
    this.name = name;
    this.courses_enrolled=courses_enrolled;
    this.photoURL=photoURL;
    notifyListeners();
  }

  void fillDataWhileSigningIn(String name, String passWord, String rNo,String photoURL,Map courses_enrolled){
    this.roll = rNo;
    this.currentPassword = passWord;
    this.name = name;
    this.courses_enrolled=courses_enrolled;
    this.photoURL=photoURL;
    notifyListeners();
  }

  updateImage(String imageURL){
    this.photoURL=imageURL;
    notifyListeners();
  }

  updateName(String name){
    this.name=name;
    notifyListeners();
  }

  updatePassword(String password){
    this.currentPassword=password;
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