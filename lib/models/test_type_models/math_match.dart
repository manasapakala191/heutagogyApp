import 'option_class.dart';

class MathMatchTest {
  String heading;
  List<TextPair> questions;
  String subject;
  MathMatchTest({this.heading, this.questions, this.subject});

  factory MathMatchTest.fromJSON(Map<String, dynamic> jsonData) {
    List<TextPair> ques = [];
    // print(jsonData);
    if(jsonData['questions']!=null){
      for (var x in jsonData['questions']) {
        ques.add(TextPair.fromJson(x));
      }
      return MathMatchTest(heading: jsonData['heading'], questions: ques, subject: jsonData['subject']);
    }
    else{
      return MathMatchTest(heading:"",questions:ques,subject:"");
    }
  }
}