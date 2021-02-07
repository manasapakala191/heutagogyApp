import 'option_class.dart';
import 'test_class.dart';

class DragDropOrderTest extends Test {
  List<OrderQuestion> questions;

  DragDropOrderTest({
    this.questions,
    String testName,
    String subject,
    String testDescription}):super(
    testName: testName,
    subject: subject,
    testDescription: testDescription,
  );

  factory DragDropOrderTest.fromJSON(Map<String, dynamic> jsonData) {
    List<OrderQuestion> orderQuestions=[];
    for(Map<String,dynamic> i in jsonData["questions"]){
      orderQuestions.add(OrderQuestion.fromJSON(i));
    }
    return DragDropOrderTest(
        testName: jsonData['name'],
        questions: orderQuestions,
        testDescription: jsonData['description'],
        subject: jsonData['subject']);
  }
}

class OrderQuestion{
  List<dynamic> elements;
  OrderQuestion(this.elements);

  factory OrderQuestion.fromJSON(Map<String,dynamic> json){
    return OrderQuestion(json["question"]);
  }
}
