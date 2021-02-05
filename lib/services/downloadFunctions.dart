import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:heutagogy/models/lessons_models.dart';
import 'package:heutagogy/models/test_type_models/drag_drop_test.dart';
import 'package:heutagogy/models/test_type_models/match_audio.dart';
import 'package:heutagogy/models/test_type_models/match_text_test.dart';
import 'package:heutagogy/models/test_type_models/multiple_choice_question_test.dart';
import 'package:heutagogy/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService{

  static Future<String> downloadFromUrl(String url,String fileName, String type) async {
    /// downloads to a directory and returns path
    Dio dio = Dio();
    if(url!=null && url.isNotEmpty) {
      try {
        var dir = await getApplicationDocumentsDirectory();
        print("path ${dir.path}/${fileName}.$type");
        print("url $url");
        await dio.download(url, "${dir.path}/$fileName.$type",
            onReceiveProgress: (rec, total) {
              // print("Rec: $rec , Total: $total");
            });
        print("Download completed");
        return dir.path + "/$fileName.$type";
      } catch (e) {
        print(e);
      }
    }
    return "";
  }


  static Future<Map> findMedia(String cid, String lid,Map<String,dynamic> slideData) async {
    String type=slideData["type"];
    print("type" + type);
    String path="$cid/$lid/${slideData["sid"]}/";
    switch (type) {
      case 'l0':
        {
          //done
          Lesson nL= Lesson.fromJson(slideData);
          if(nL.videoUrl!="")
            {
              String videoPath= await downloadFromUrl(nL.videoUrl,path+nL.lessonName,"mp4");
            slideData["videoURL"]=videoPath;
            return slideData;
            }
        }
        break;
      case 'q0':
        {
          //done
          MatchPicWithText matchPicWithText = MatchPicWithText.fromJSON(slideData);
          for (int i=0;i<matchPicWithText.choices.length;i++){
            String imagePath = await downloadFromUrl(matchPicWithText.choices[i].picture,"$path$i", 'png');
            slideData["pictures"][i]["picture"]=imagePath;
          }
          return slideData;
        }
        break;
      case 'q1':
        {
          //done
          ImageQuestionTest imageQuestionTest = ImageQuestionTest.fromJson(slideData);
          for (int i=0;i<imageQuestionTest.questions.length;i++){
            for (int j=0;j<imageQuestionTest.questions[i].options.length;j++){
              String imagePath=await downloadFromUrl(imageQuestionTest.questions[i].options[j].picture, path+"$i/$j", "png");
              print(imagePath);
              slideData["questions"][i]["options"][j]["picture"]=imagePath;
              print("hey"+slideData["questions"][i]["options"][j]["picture"]);
            }
          }
          print("return");
          return slideData;
        }
        break;
      case 'q2':
        {
          return slideData;
        }
        break;
      case 'q3':
        {
          //done
          DragDropImageTest dragDropImageTest = DragDropImageTest.fromJSON(slideData);
          for(int i=0;i<dragDropImageTest.pictures.length;i++){
            String imagePath=await downloadFromUrl(dragDropImageTest.pictures[i].picture, path+"$i", "png");
            slideData["pictures"][i]["picture"]=imagePath;
          }
          return slideData;
        }
        break;
      case 'q4':
        {
          //done
          DragDropAudioTest dragDropAudioTest = DragDropAudioTest.fromJSON(slideData);
          for(int i=0;i<dragDropAudioTest.audios.length;i++){
            String audioPath=await downloadFromUrl(dragDropAudioTest.audios[i].audio,path+"$i","mp3");
            slideData["audios"][i]["audio"]=audioPath;
          }
          return slideData;
        }
        break;
      case 'q5':
        {
          //done
          return slideData;
        }
        break;
      default:
        {
          return slideData;
        }
        break;
    }
  }
  static writeJSON(String cid,Map courseJson) async {
    /// write json from courses, lessons and slides of course to file
    var dir = await getApplicationDocumentsDirectory();
    File courseFile = File("${dir.path}/$cid.json");
    print("${dir.path}/$cid.json");
    String jsonString=jsonEncode(courseJson);
    courseFile.writeAsString(jsonString);
  }

  static Future<Map> readJson(String cid) async {
    var dir = await getApplicationDocumentsDirectory();
    File courseFile = File("${dir.path}/$cid.json");
    print("${dir.path}/$cid.json");
    if(await courseFile.exists()){
      print("file exists");
      String courseString = await courseFile.readAsString();
      Map json = jsonDecode(courseString);
      print(json);
      return json;
    }
    return null;
  }
  
  static Future<void> downloadEntireCourse(String cid) async {
    DocumentSnapshot courseDoc = await DatabaseService.getCourseDoc(cid);
    Map<String, dynamic> courseJson= courseDoc.data();
    courseJson["lessons"]=[];
    QuerySnapshot lessonsSnapshot = await DatabaseService.getLessons(cid);
    List<QueryDocumentSnapshot> lessonDocs = lessonsSnapshot.docs;
    for (int i = 0; i < lessonDocs.length; i++) {
      Map<String, dynamic> lessonJson=lessonDocs[i].data();
      lessonJson["slides"]=[];
      QuerySnapshot slidesSnapshot= await DatabaseService.getSlides(cid, lessonJson["lesson_id"]);
      List<QueryDocumentSnapshot> slideDocs = slidesSnapshot.docs;
      for(int i=0;i<slideDocs.length;i++){
        Map<String,dynamic> slideData = slideDocs[i].data();
        var dSlideData = await findMedia(cid, lessonJson["lesson_id"], slideData);
        lessonJson["slides"].add(dSlideData);
      }
      courseJson["lessons"].add(lessonJson);
    }
    print(courseJson);
    await writeJSON(cid, courseJson);
  }
}