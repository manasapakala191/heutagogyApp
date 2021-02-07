import 'package:heutagogy/models/test_type_models/test_class.dart';

import 'option_class.dart';

class DragDropMultipleTest extends Test {
  List<TextPair> questions;
  List categories;
  DragDropMultipleTest(
      {String testName,
      String subject,
      String testDescription,
      this.questions,
      this.categories})
      : super(
            testName: testName,
            subject: subject,
            testDescription: testDescription);

  factory DragDropMultipleTest.fromJSON(Map<String, dynamic> jsonData) {
    List<TextPair> ques = [];
    // print(jsonData);
    if (jsonData['questions'] != null) {
      for (var x in jsonData['questions']) {
        ques.add(TextPair.fromJson(x));
      }
      return DragDropMultipleTest(
        testName: jsonData['name'],
        testDescription: jsonData['description'],
        questions: ques,
        subject: jsonData['subject'],
        categories: jsonData['categories'],
      );
    } else {
      return DragDropMultipleTest(
          testName: "", questions: ques, subject: "", categories: []);
    }
  }
}
