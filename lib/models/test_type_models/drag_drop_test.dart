import 'option_class.dart';
import 'test_class.dart';

class DragDropImageTest extends Test {
  List<PicturePair> pictures;

  DragDropImageTest({
    this.pictures,
    String testName,
    String subject,
    String testDescription}):super(
    testName: testName,
    subject: subject,
    testDescription: testDescription,
  );

  factory DragDropImageTest.fromJSON(Map<String, dynamic> jsonData) {
    List<PicturePair> pics = [];
    for (var x in jsonData['pictures']) {
      pics.add(PicturePair.fromJson(x));
    }
    return DragDropImageTest(
        testName: jsonData['name'],
        pictures: pics,
        testDescription: jsonData['description'],
        subject: jsonData['subject']);
  }
}

