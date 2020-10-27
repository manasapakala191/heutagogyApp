import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
 static final db=FirebaseFirestore.instance;
 static final CollectionReference elementCollection=db.collection('Schools');

 static Stream getCourses() {
    return elementCollection.snapshots();
 }

  static getUserDoc(String cid) async {
    //TODO: Get user data, then populate user model and student performance model
  }
}
