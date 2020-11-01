import 'package:heutagogy/models/test_type_models/test_class.dart';

class MatchPicWithText extends Test {
  List<PictureData> choices;
  MatchPicWithText(
      {String testName, String subject, String testDescription, this.choices})
      : super(
            testName: testName,
            subject: subject,
            testDescription: testDescription);

  factory MatchPicWithText.fromJSON(Map<String, dynamic> jsonData) {
    List<PictureData> pictures = [];
    for (var x in jsonData["pictures"]) {
      pictures.add(PictureData.fromJSON(x));
    }
    return MatchPicWithText(
        testName: jsonData["name"],
        subject: jsonData['subject'],
        testDescription: jsonData["description"],
        choices: pictures);
  }
}

class PictureData {
  String picture;
  String correctText;

  PictureData({this.picture, this.correctText});

  factory PictureData.fromJSON(Map<String, dynamic> jsonData) {
    return PictureData(
        picture: jsonData['picture'], correctText: jsonData['correct_text']);
  }
}
