import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
 static final db=FirebaseFirestore.instance;
 static final CollectionReference elementCollection=db.collection('elements');

 static Stream getCourses() {
    return elementCollection.snapshots();
 }

  getDesPictureTestWithCourseID(String cid) async {
    // Firebase.initializeApp().then((val) async {
      DocumentSnapshot doc= await FirebaseFirestore.instance.collection('elements').doc("kZx]sxpgvj").get();
      print("bruh"+doc.data()["text"]);
    // });
  }

  getAudioTestWithCourseID(String cid){


  }

  getImgPictureTestWithCourseID(String cid){


  }

  getImgTestWithCourseID(String cid){

  }

  getMatchTxtTestWithCourseID(String cid){


  }

  getMCQWithCourseID(String cid){


  }

}
