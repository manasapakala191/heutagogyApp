import 'package:faker/faker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heutagogy/models/course_model.dart';
import 'package:heutagogy/models/lessonModel.dart';
import 'package:heutagogy/models/studentProgress.dart';

class DatabaseService{
 static final db=FirebaseFirestore.instance;
 // static final CollectionReference schoolCollection=db.collection('Schools');
 static final DocumentReference schoolDoc=db.doc('Schools/School 1');

  static getUserDoc(String cid) async {
    //TODO: Get user data, then populate user model and student performance model
  }

//     TODO: in register/login get courses, lesson ID, slide ID: and populate student performance model

  static Stream<List<CourseData>> populateCourse(Map progressJSON) async* {
   List<CourseData> courses=[];
   for(String cid in progressJSON.keys){
     print(cid);
    DocumentSnapshot courseDoc = await getCourseDoc(cid);
    print(courseDoc.data());
    courses.add(CourseData.fromJSON(courseDoc.data()));
    print(courses[0]);
    yield courses;
   }
 }
  static Future getCourseDoc(String cid) async {
    return await schoolDoc.collection('Courses').doc(cid).get();
  }


 static Future<List<LessonData>> getLessonsForCourse(String cid) async {
   QuerySnapshot lessonsSnapshot = await getLessons(cid);
   List<QueryDocumentSnapshot> lessonDocs = lessonsSnapshot.docs;
   List<LessonData> lessons=[];
   for(int i=0;i<lessonDocs.length;i++){
    lessons.add(LessonData.fromJSON(lessonDocs[i].data()));
   }
   return lessons;
 }

  static Future getLessons(String cid) async {
   return await schoolDoc.collection('Courses/'+cid+'/Lessons').get();
  }


  static Future<List<QueryDocumentSnapshot>> getSlidesForLessons(String cid,String lid) async{
    QuerySnapshot slidesSnapshot = await getSlides(cid,lid);
    List<QueryDocumentSnapshot> slideDocs = slidesSnapshot.docs;
    print(slideDocs.length);
    return slideDocs;
  }

  static Future getSlides(String cid, String lid) async {
    print(cid + " " + lid);
   return await schoolDoc.collection("Courses/"+ cid +"/Lessons/"+lid+"/Content").get();
   // slidesStream.docs
  // TODO: get docs, identify type, update provider
  }

  static addNewCourse(String cid, String uid) async {
    // update that students courseID array
    return await schoolDoc.collection('Students/').doc(uid).set({
    });
  }
  void writeProgress(Map<String, dynamic> data,String lessonID) async {
    print(data);
    DocumentReference progressReference = db.doc("Schools/School 1/Students/Student 1/Progress/C1");
    await progressReference.set({lessonID: data[lessonID]},SetOptions(merge:true)).then(
      (_){
        print(data["C1"][lessonID]);
        print("updated");
      }
    );
  }

}
