import 'question_class.dart';
import 'test_class.dart';

class SingleCorrectTest extends Test{
  final List<QuestionData> questions;
  SingleCorrectTest({String testName,
    String subject,
    String testDescription,
    this.questions}) : super(
      testName: testName,
      subject: subject,
      testDescription: testDescription
  );

  factory SingleCorrectTest.fromJson(Map<String, dynamic> json){
    List questionMaps = json['questions'];
    return SingleCorrectTest(
        testName: json['testName'],
        testDescription: json['testDescription'],
        subject: json['subject'],
        questions: questionMaps.map((e) => QuestionData.fromJson(e))
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'testName' : testName,
      'testDescription' :testDescription,
      'subject' : subject,
      'questions' : questions.map((e) => e.toMap()).toList()
    };
  }
}

class ImageQuestionTest extends Test{
  final List<ImageQuestionData> questions;
  ImageQuestionTest({String testName, String testDescription, String subject, this.questions}) : super(
      testName : testName,
      testDescription : testDescription,
      subject: subject
  );

  factory ImageQuestionTest.fromJson(Map<String, dynamic> json){
    List imageQuestionMaps = json['questions'];
    return ImageQuestionTest(
        testName: json['testName'],
        testDescription: json['testDescription'],
        subject: json['subject'],
        questions: imageQuestionMaps.map((e) => ImageQuestionData.fromJson(e))
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'testName' : testName,
      'testDescription' : testDescription,
      'subject' : subject,
      'questions' : questions.map((e) => e.toMap()).toList()
    };
  }
}