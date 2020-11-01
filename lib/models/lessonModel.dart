import 'package:flutter/material.dart';

class LessonData{
  String lname;
  String ldescription;
  String bannerURL;
  String lID;

  LessonData({@required this.lID,@required this.lname,
  this.ldescription,this.bannerURL});

  factory LessonData.fromJSON(Map<String,dynamic> json){
    return LessonData(
    lID: json['lesson_id'],
    lname: json['lesson_name'],
    ldescription: json['description'],
    bannerURL: json['image_url']
    );
  }
}