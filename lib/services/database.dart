import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:heutagogy/models/course_model.dart';
import 'package:heutagogy/models/lessonModel.dart';
import 'package:heutagogy/models/userModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  static final db = FirebaseFirestore.instance;
  // static final CollectionReference schoolCollection=db.collection('Schools');
  static final DocumentReference schoolDoc = db.doc('Schools/School 1');

  static getUserDoc(String cid) async {
    //TODO: Get user data, then populate user model and student performance model
  }

  static updateImage(UserModel userModel, String imageURL) async {
    final result =
        await schoolDoc.collection("Students").doc(userModel.roll).update({
      "PhotoURL": imageURL,
    });
    userModel.updateImage(imageURL);
  }

  static updateProfileName(String name, UserModel userModel) async {
    final result =
        await schoolDoc.collection("Students").doc(userModel.roll).update({
      "Name": name,
    });
    userModel.updateName(name);
  }

  static updatePassword(String password, UserModel userModel) async {
    final result =
        await schoolDoc.collection("Students").doc(userModel.roll).update({
      "Password": password,
    });
    userModel.updatePassword(password);
  }

  static resetPassword(
      String oldPassword, String newPassword, String roll) async {
    final result =
    await schoolDoc.collection("Students").doc(roll).update({
      "Password": newPassword,
    });
    return result;
  }

  static checkPassword(String password, String roll) async {
    final result = await schoolDoc.collection("Students").doc(roll).get();
    Map data = result.data();
    if (data["Password"] == password) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> courseFilter(String cid) async {
    print("courseFilter");
    var courseRef = schoolDoc.collection('Courses').doc(cid);
    DocumentSnapshot courseDoc = await courseRef.get();
    if (courseDoc.exists) {
      return true;
    } else {
      return false;
    }
  }

  static Stream<List<CourseData>> populateCourse(Map progressJSON) async* {
    List<CourseData> courses = [];
    for (String cid in progressJSON.keys) {
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

  static Future<List<LessonData>> getLessonsForCourseFromProgress(
      String sid, String cid) async {
    QuerySnapshot lessonsSnapshot = await getLessons(cid);
    List<QueryDocumentSnapshot> lessonDocs = lessonsSnapshot.docs;
    List<LessonData> lessons = [];
    for (int i = 0; i < lessonDocs.length; i++) {
      LessonData data = LessonData.fromJSON(lessonDocs[i].data());
      CollectionReference studentsCollection = schoolDoc.collection("Students");
      DocumentReference studentReference = studentsCollection.doc(sid);
      bool flag = false;
      print(sid);
      print(cid + " " + data.lID);
      await studentReference
          .collection("Progress")
          .doc(cid)
          .collection("Lessons")
          .doc(data.lID)
          .get()
          .then((value) {
        print(value.exists);
        if (value.exists) {
          print("Yes, progress exists");
          flag = true;
        } else {
          print("No, progress doesnot exists");
          flag = false;
        }
      });
      if (flag == true) {
        lessons.add(data);
      }
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

  static Future<List<QueryDocumentSnapshot>> getSlidesForLessonsFromProgress(
      String sid, String cid, String lid) async {
    QuerySnapshot slidesSnapshot = await schoolDoc
        .collection("Students")
        .doc(sid)
        .collection("Progress")
        .doc(cid)
        .collection("Lessons")
        .doc(lid)
        .collection("slides")
        .get();
    List<QueryDocumentSnapshot> slideDocs = slidesSnapshot.docs;
    print(slideDocs.length);
    return slideDocs;
  }

  static Future getSlide(String cid, String lid, String sid) async {
    print("Slide for: "+cid+lid+sid);
    return await schoolDoc.collection("Courses/"+cid+"/Lessons/"+lid+"/Content").doc(sid).get();
  }
  static Future getSlides(String cid, String lid) async {
    print(cid + " " + lid);
    return await schoolDoc
        .collection("Courses/" + cid + "/Lessons/" + lid + "/Content")
        .get();
  }

  static addNewCourse(String cid, String roll) async {
    // update that student's courseID array
    return await schoolDoc.collection('Students/').doc(roll).set({
      'Courses': {
        cid: {},
      }
    }, SetOptions(merge: true));
  }

  void writeProgress(Map<String, dynamic> data, String studentID,
      String courseID, String lessonID, String type) async {
    print("write: " + data.toString());
    CollectionReference studentsCollection = schoolDoc.collection("Students");
    DocumentReference studentReference = studentsCollection.doc(studentID);
    DocumentReference doc2 =
        studentReference.collection("Progress").doc(courseID);
    doc2.get().then((snapshot) {
      if (snapshot.exists) {
        DocumentReference doc1 = doc2.collection("Lessons").doc(lessonID);
        doc1.get().then((snapshot) {
          if (snapshot.exists) {
            DocumentReference doc = doc1.collection("slides").doc(type);
            doc.get().then((snapshot) {
              if (snapshot.exists) {
                if (snapshot.data()["percentage"] < data["percentage"]) {
                  writeProgressHelper(
                      data, studentID, courseID, lessonID, type);
                } else {
                  print("No need to update");
                }
              } else {
                doc.set({});
                writeProgressHelper(data, studentID, courseID, lessonID, type);
              }
            });
          } else {
            doc1.set({});
            DocumentReference doc = doc1.collection("slides").doc(type);
            doc.set({});
            writeProgressHelper(data, studentID, courseID, lessonID, type);
          }
        });
      } else {
        doc2.set({});
        DocumentReference doc1 = doc2.collection("Lessons").doc(lessonID);
        doc1.set({});
        DocumentReference doc = doc1.collection("slides").doc(type);
        doc.set({});
        writeProgressHelper(data, studentID, courseID, lessonID, type);
      }
    });
  }

  void writeProgressHelper(Map<String, dynamic> data, String studentID,
      String courseID, String lessonID, String type) async {
    print(data);
    CollectionReference studentsCollection = schoolDoc.collection("Students");
    DocumentReference studentReference = studentsCollection.doc(studentID);

    // Check if Progress exists, if not create one
    // Check if course doc with slides collection exists, if not create one
    // Update that particular slide progress

    await studentReference
        .collection("Progress")
        .doc(courseID)
        .collection("Lessons")
        .doc(lessonID)
        .collection("slides")
        .doc(type)
        .set(data, SetOptions(merge: true))
        .then((value) {
      print(data);
      print("Updated");
    });
  }

  Future<String> signInStudent(
      UserModel userModel, String rollNumber, String passWord) async {
    try {
      var doc_list = await db
          .collection("Schools")
          .doc("School 1")
          .collection('Students')
          .get();
      if (doc_list == null || doc_list.size == 0) return "Something went wrong";
      print(doc_list.size);
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

      if (fact == 0) return "User not found";

      if (!doc_required["First_time"] && doc_required["Password"] == passWord) {
        print("updating doc");
        userModel.fillDataWhileSigningIn(
          doc_required["Name"],
          doc_required["Password"],
          doc_required["Roll_No"],
          doc_required["PhotoURL"],
          doc_required["Courses"],
        );
        final credentialsStorage = await SharedPreferences.getInstance();
        credentialsStorage.setString('rollNumber', doc_required["Roll_No"]);
        credentialsStorage.setString('password',doc_required["Password"]);
        credentialsStorage.setString('name',doc_required["Name"]);
        credentialsStorage.setString('photoURL',doc_required["PhotoURL"]);
        List<String> courseList = List<String>();
        for(var course in doc_required["Courses"].keys){
          // print(course);
          courseList.add(course);
        }
        credentialsStorage.setStringList('courses',courseList);
        print("Success");
        return "Success";
      } else {
        print("Password is wrong");
        return "Wrong password";
      }
    } catch (e) {
      print(e);
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

    if (doc_required["First_time"] && doc_required["Password"] == oldPassword) {
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
          "PhotoURL": "",
        },
      );

      //print(doc_required["First_time"]);
      userModel.fillDataWhileSigningUp(
          rNo,
          newPassword,
          !doc_required["First_time"],
          doc_required["Name"],
          doc_required["PhotoURL"],
          doc_required["Courses"]);
        final credentialsStorage = await SharedPreferences.getInstance();
        credentialsStorage.setString('rollNumber', doc_required["Roll_No"]);
        credentialsStorage.setString('password',doc_required["Password"]);
        credentialsStorage.setString('name',doc_required["Name"]);
        credentialsStorage.setString('photoURL',doc_required["PhotoURL"]);
        List<String> courseList = List<String>();
        for(var course in doc_required["Courses"].keys){
          // print(course);
          courseList.add(course);
        }
        credentialsStorage.setStringList('courses',courseList);
        print("Success");
      return true;
    } else {
      return false;
    }
  }

  static updateCoursesAndSlides(BuildContext context) async {
    UserModel userModel = Provider.of<UserModel>(context, listen: false);
    return await schoolDoc.collection('Students/').doc(userModel.roll).set({
      'Courses': userModel.courses_enrolled,
    }, SetOptions(merge: true));
  }
}
