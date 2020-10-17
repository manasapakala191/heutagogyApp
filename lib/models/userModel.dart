import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserModel extends ChangeNotifier{
  String uid;
  String name;
  String roll;
  String photoURL;
  List<String> courses_enrolled;
//  progress variable

  UserModel({this.uid,this.name,this.roll,this.photoURL,this.courses_enrolled});
  factory UserModel.fromJSON(){
    return UserModel();
  }
}