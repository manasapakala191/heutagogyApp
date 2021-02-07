import 'package:heutagogy/models/test_type_models/test_class.dart';

import 'option_class.dart';

class MathMatchTest extends Test {
  List<TextPair> questions;

  MathMatchTest(
      {String testName, String subject, String testDescription, this.questions})
      : super(
            testName: testName,
            subject: subject,
            testDescription: testDescription);

  factory MathMatchTest.fromJSON(Map<String, dynamic> jsonData) {
    List<TextPair> ques = [];
    // print(jsonData);
    if (jsonData['questions'] != null) {
      for (var x in jsonData['questions']) {
        ques.add(TextPair.fromJson(x));
      }
      return MathMatchTest(
          testName: jsonData['name'],
          testDescription: jsonData['description'],
          questions: ques,
          subject: jsonData['subject']);
    } else {
      return MathMatchTest(testName: "", questions: ques, subject: "");
    }
  }
}
