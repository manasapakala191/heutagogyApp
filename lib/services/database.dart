import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/userModel.dart';

class DatabaseService {
  static final db = FirebaseFirestore.instance;
  static final CollectionReference elementCollection = db.collection('Schools');

  static Stream getCourses() {
    return elementCollection.snapshots();
  }

  static getUserDoc(String cid) async {
    //TODO: Get user data, then populate user model and student performance model
  }

  Future<bool> signInStudent(UserModel userModel, String rollNumber, String passWord) async {
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
        fact = 1;
        doc_required = doc.data();
        break;
      }
    }

    if(fact == 0) return false;

    if(doc_required["Password"] == passWord){
      userModel.fillDataWhileSigningIn(doc_required["Name"], doc_required["Password"], doc_required["Roll_No"]);
      return true;
    }else{
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

    if (doc_required["Password"] == oldPassword) {
      var res = await db
          .collection("Schools")
          .doc("School 1")
          .collection('Students')
          .doc(rNo)
          .update(
        {
          "First_time": false,
          "Password": newPassword,
        },
      );

      //print(doc_required["First_time"]);
      userModel.fillDataWhileSigningUp(
          rNo, newPassword, !doc_required["First_time"], doc_required["Name"]);
      return true;
    } else {
      return false;
    }
  }
}
