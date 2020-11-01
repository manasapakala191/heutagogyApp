import 'option_class.dart';
import 'test_class.dart';

class DragDropAudioTest extends Test {
  List<AudioPair> audios;

  DragDropAudioTest({
    this.audios,
    String testName,
    String subject,
    String testDescription}):super(
    testName: testName,
    subject: subject,
    testDescription: testDescription,
  );

  factory DragDropAudioTest.fromJSON(Map<String, dynamic> jsonData) {
    List<AudioPair> sounds = [];
    for (var x in jsonData['audios']) {
      sounds.add(AudioPair.fromJson(x));
    }
    return DragDropAudioTest(
        testName: jsonData['name'],
        audios: sounds,
        testDescription: jsonData['description'],
        subject: jsonData['subject']);
  }
}

