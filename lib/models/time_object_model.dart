import 'package:flutter/cupertino.dart';
import 'package:heutagogy/models/studentProgress.dart';
import 'package:provider/provider.dart';

class TimeObject{

  final String screen;
  DateTime startTime;
  DateTime endTime;
  final String courseId;
  final String testId;

  StudentProgress studentPerfomance;
  
  TimeObject({
    this.screen,
    this.startTime, 
    this.endTime, 
    this.courseId="Default Course ID",
    this.testId="Default Test ID"
  });
  
  Map<String, dynamic> toMap(){

    return {
      'courseId' : this.courseId,
      'testId' : this.testId,
      'screen' : this.screen,
      'startTime' : this.startTime.hour.toString() + " : " + this.startTime.minute.toString() +  " : " + this.startTime.second.toString(),
      'endTime' : this.endTime.hour.toString() + " : " + this.endTime.minute.toString() + " : " + this.endTime.second.toString(),
      'date' : this.startTime.day.toString() + " " + this.startTime.month.toString() + " " + this.startTime.year.toString(),
      'totatTimeSpent' : (this.endTime.hour - this.startTime.hour).toString() + " hours " + (this.endTime.minute - this.startTime.minute).toString() + " minutes " + (this.endTime.second - this.startTime.second).toString() + " seconds " + (this.endTime.millisecond - this.startTime.millisecond).toString() + " milliseconds "
    };
  }

  void setStartTime(DateTime startTime){
    this.startTime = startTime;
  }

  void setEndTime(DateTime endTime){
    this.endTime = endTime;
  }

  void getStudent(BuildContext context){
    this.studentPerfomance = Provider.of<StudentProgress>(context, listen: false);
  }

  void addTimeObjectToStudentPerformance(){
    studentPerfomance.performanceTimes.add(this);
    print(this.toMap());
  }

}