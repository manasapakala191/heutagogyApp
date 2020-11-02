import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class UserModel extends ChangeNotifier{
  String name;
  String roll;
  String photoURL;
  bool isFirstTime;
  String currentPassword;
  var screentime;
  List<String> courses_enrolled;
  
  // Map<String,CourseModel> courses;
//  progress variable

  UserModel({this.isFirstTime,this.currentPassword,this.screentime,this.name,this.roll,this.photoURL,this.courses_enrolled});
  factory UserModel.fromJSON(){
    return UserModel();
  }


  void fillDataWhileSigningUp(String rNo, String passWord, bool isFirstTime, String name){
    this.roll = rNo;
    this.currentPassword = passWord;
    this.isFirstTime = isFirstTime;
    this.name = name;
    notifyListeners();
  }

  void fillDataWhileSigningIn(String name, String passWord, String rNo){
    this.roll = rNo;
    this.currentPassword = passWord;
    this.name = name;
    notifyListeners();
  }

}