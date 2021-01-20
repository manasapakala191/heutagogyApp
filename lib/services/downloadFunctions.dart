
import 'package:heutagogy/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DownloadService{

  static downloadFromUrl(String url){
    /// downloads to a directory and returns path
  }

  static writeJSON(){
    /// write json from courses, lessons and slides of course to file
  }

  static downloadEntireCourse(String cid) async {
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
        lessonJson["slides"].add(slideData);
      }
      courseJson["lessons"].add(lessonJson);
    }
    print(courseJson);
  }
}