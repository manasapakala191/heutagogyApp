import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:heutagogy/models/course_model.dart';
import 'package:heutagogy/models/lessonModel.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  static final db = FirebaseFirestore.instance;
  // static final CollectionReference schoolCollection=db.collection('Schools');
  static final DocumentReference schoolDoc = db.doc('Schools/School 1');

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
    yield courses;
   }
 }

  static Future getCourseDoc(String cid) async {
    return await schoolDoc.collection('Courses').doc(cid).get();
  }

  static Future<List<LessonData>> getLessonsForCourse(String cid) async {
    QuerySnapshot lessonsSnapshot = await getLessons(cid);
    List<QueryDocumentSnapshot> lessonDocs = lessonsSnapshot.docs;
    List<LessonData> lessons = [];
    for (int i = 0; i < lessonDocs.length; i++) {
      lessons.add(LessonData.fromJSON(lessonDocs[i].data()));
    }
    return lessons;
  }

  static Future getLessons(String cid) async {
    return await schoolDoc.collection('Courses/' + cid + '/Lessons').get();
  }

  static Future<List<QueryDocumentSnapshot>> getSlidesForLessons(
      String cid, String lid) async {
    QuerySnapshot slidesSnapshot = await getSlides(cid, lid);
    List<QueryDocumentSnapshot> slideDocs = slidesSnapshot.docs;
    print(slideDocs.length);
    return slideDocs;
  }

  static Future getSlides(String cid, String lid) async {
    print(cid + " " + lid);
   return await schoolDoc.collection("Courses/"+ cid +"/Lessons/"+lid+"/Content").get();
  }

  static addNewCourse(String cid, String roll) async {
    // update that students courseID array
    return await schoolDoc.collection('Students/').doc(roll).set({
      'Courses': {
        cid: {},
      }
    },SetOptions(merge: true));
  }

  void writeProgress(Map<String, dynamic> data, String lessonID) async {
    print(data);
    DocumentReference progressReference =
        db.doc("Schools/School 1/Students/Student 1/Progress/C1");
    await progressReference
        .set({lessonID: data[lessonID]}, SetOptions(merge: true)).then((_) {
      print(data["C1"][lessonID]);
      print("updated");
    });
  }

  Future<bool> signInStudent(
      UserModel userModel, String rollNumber, String passWord) async {
    var doc_list = await db
        .collection("Schools")
        .doc("School 1")
        .collection('Students')
        .get();

    int fact = 0;
    var doc_required;
    for (var doc in doc_list.docs) {
      print(doc.id);
      if (doc.id == rollNumber) {
        print("Found doc");
        fact = 1;
        doc_required = doc.data();
        break;
      }
    }

    if (fact == 0) return false;

    if(!doc_required["First_time"] && doc_required["Password"] == passWord){
      print("updating doc");
      userModel.fillDataWhileSigningIn(
          doc_required["Name"],
          doc_required["Password"],
          doc_required["Roll_No"],
          doc_required["Courses"],
      );
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUpStudent(UserModel userModel, String rNo,
      String oldPassword, String newPassword) async {
    //await Firebase.initializeApp();
    var x = await db
        .collection("Schools")
        .doc("School 1")
        .collection('Students')
        .get();
    int fact = 0;
    var doc_required;
    for (var doc in x.docs) {
      print(doc.id);
      if (doc.id == rNo) {
        fact = 1;
        doc_required = doc.data();
        break;
      }
    }

    if (fact == 0) return false;

    if (doc_required["First_time"] && doc_required["Password"] == oldPassword ) {
      var res = await db
          .collection("Schools")
          .doc("School 1")
          .collection('Students')
          .doc(rNo)
          .update(
        {
          "First_time": false,
          "Password": newPassword,
          "Courses": [],
        },
      );

      //print(doc_required["First_time"]);
      userModel.fillDataWhileSigningUp(
          rNo, newPassword, !doc_required["First_time"], doc_required["Name"],doc_required["Courses"]);
      return true;
    } else {
      return false;
    }
  }


  static updateCoursesAndSlides(BuildContext context) async {
    UserModel userModel=Provider.of<UserModel>(context,listen:false);
    return await schoolDoc.collection('Students/').doc(userModel.roll).set({
      'Courses': userModel.courses_enrolled,
    },SetOptions(merge: true));
  }
}
