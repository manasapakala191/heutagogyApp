import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
 static final db=FirebaseFirestore.instance;
 static final CollectionReference elementCollection=db.collection('elements');

 static Stream getCourses() {
    return elementCollection.snapshots();
 }

  static getUserDoc(String cid) async {
    // Firebase.initializeApp().then((val) async {
    //   DocumentSnapshot doc= await 
    //   FirebaseFirestore.instance.collection('Schools').doc('School 1').get().then((value) => print(value['name']));
    //TODO: Get user data, then populate user model and student performance model
    // });
  }
}
