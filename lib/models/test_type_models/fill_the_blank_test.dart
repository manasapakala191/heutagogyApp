import 'package:heutagogy/models/test_type_models/option_class.dart';
import 'package:heutagogy/models/test_type_models/test_class.dart';

class FillInBlankTest extends Test {
  List<TextPairData> choices;
  FillInBlankTest(
      {String testName, String subject, String testDescription, this.choices})
      : super(
      testName: testName,
      subject: subject,
      testDescription: testDescription);

  factory FillInBlankTest.fromJSON(Map<String, dynamic> jsonData) {
    List<TextPairData> ques = [];
    for (var x in jsonData['questions']) {
      ques.add(TextPairData.fromJson(x));
    }
    return FillInBlankTest(
        testName: jsonData["name"],
        subject: jsonData['subject'],
        testDescription: jsonData["description"],
        choices: ques);
  }
}

