import 'package:heutagogy/models/test_type_models/test_class.dart';


class MissingNumbersTest extends Test {
  int start;
  int end;
  List<dynamic> missingList;
  MissingNumbersTest(
      {String testName, String subject, String testDescription, this.start,this.end,this.missingList})
      : super(
      testName: testName,
      subject: subject,
      testDescription: testDescription);

  factory MissingNumbersTest.fromJSON(Map<String, dynamic> jsonData) {
    print(jsonData["missingList"]);
    return MissingNumbersTest(
        testName: jsonData["name"],
        subject: jsonData['subject'],
        testDescription: jsonData["description"],
        start: jsonData["start"],
        end: jsonData["end"],
      missingList: jsonData["missingList"],
    );
  }
}