import 'dart:convert';
import 'dart:io';
import 'package:heutagogy/models/course_model.dart';
import 'package:heutagogy/models/lessonModel.dart';
import 'package:path_provider/path_provider.dart';

class LocalFileService{
  static Future<String> _localPath() async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String cid) async{
    final path = await _localPath();
    return File('$path/$cid.json');
  }

  static Future<Map> readFile(String cid) async{
    try{
      final File file = await _localFile(cid);
      String contents = await file.readAsString();
      return jsonDecode(contents);
    }
    catch(e){
      print(e);
      return null;
    }
  }

  static Future<List> fetchSlidesOfLesson(String cid, String lid) async{
    Map json = await readFile(cid);
    List slides = [];
    for(var lesson in json["lessons"]){
      if(lesson["lesson_id"] == lid){
        slides = lesson["slides"];
        break;
      }
    }
    return slides;
  }

  static Future<List<LessonData>> fetchLessonsOfCourse(String cid) async{
    List<LessonData> lessons = [];
    Map json = await readFile(cid);
    for (var lesson in json["lessons"]) {
      lessons.add(LessonData.fromJSON(lesson));
    }
    return lessons;
  }

  static CourseData fetchCourse(Map<String, dynamic> json){
    CourseData courseData = CourseData.fromJSON(json);
    return courseData;
  }

  static Future<List<CourseData>> fetchCourses(Map<String, dynamic> courses_enrolled) async{
    List<CourseData> courses = [];
    for(String cid in courses_enrolled.keys){
      Map<String, dynamic> json = await readFile(cid);
      CourseData course = CourseData.fromJSON(json);
      courses.add(course);
    }
    print(json);
    return courses;
  }
}