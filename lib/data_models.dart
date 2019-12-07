class LessonData {
  String title = "";
  String introText = "";
  String studyText = "";
  List<Test1Data> test1 = [];
  List<Test2Data> test2 = [];
  List<Test3Data> test3 = [];
  List<Test4Data> test4 = [];
  List<Test6Data> test6 = [];
  List<Test9Data> test9 = [];

  LessonData(
      {this.title,
      this.introText,
      this.studyText,
      this.test1,
      this.test2,
      this.test3,
      this.test4,
      this.test6,
      this.test9});

  factory LessonData.fromJSON(Map<String, dynamic> jsonData) {
    List<Test1Data> test1DataList = [];
    for (var x in jsonData['test1']) {
      test1DataList.add(Test1Data.fromJSON(x));
    }
    List<Test2Data> test2DataList = [];
    for (var x in jsonData['test2']) {
      test2DataList.add(Test2Data.fromJSON(x));
    }
    List<Test3Data> test3DataList = [];
    for (var x in jsonData['test3']) {
      test3DataList.add(Test3Data.fromJSON(x));
    }
    List<Test4Data> test4DataList = [];
    for (var x in jsonData['test4']) {
      test4DataList.add(Test4Data.fromJSON(x));
    }
    List<Test9Data> test9DataList = [];
    for (var x in jsonData['test9']) {
      test9DataList.add(Test9Data.fromJSON(x));
    }
    List<Test6Data> test6DataList = [];
    for (var x in jsonData['test6']) {
      test6DataList.add(Test6Data.fromJSON(x));
    }
    return LessonData(
      title: jsonData['title'],
      introText: jsonData['intro_text'],
      studyText: jsonData['study_text'],
      test1: test1DataList,
      test2: test2DataList,
      test3: test3DataList,
      test4: test4DataList,
      test6: test6DataList,
      test9: test9DataList,
    );
  }
}

class ChoiceData {
  String text;
  bool correct;

  ChoiceData({this.text, this.correct});

  factory ChoiceData.fromJson(Map<String, dynamic> jsonData) {
    return ChoiceData(text: jsonData['text'], correct: jsonData['correct']);
  }
}

class QuestionData {
  String text;
  String image;
  String youtubeVideo;
  List<ChoiceData> options;

  QuestionData({this.text, this.options, this.image, this.youtubeVideo});

  factory QuestionData.fromJSON(Map<String, dynamic> jsonData) {
    List<ChoiceData> opts = [];
    for (var x in jsonData['options']) {
      opts.add(ChoiceData.fromJson(x));
    }
    return QuestionData(
        text: jsonData['text'],
        options: opts,
        image: (jsonData["image"] != null) ? jsonData["image"] : "",
        youtubeVideo: jsonData["youtube_video"]);
  }
}

class Test1Data {
  String name;
  String heading;
  String subject;
  List<QuestionData> questions;

  Test1Data({this.name, this.questions, this.heading, this.subject});

  factory Test1Data.fromJSON(Map<String, dynamic> jsonData) {
    List<QuestionData> ques = [];
    for (var q in jsonData['questions']) {
      ques.add(QuestionData.fromJSON(q));
    }
    return Test1Data(name: jsonData['name'], questions: ques, heading: jsonData['heading'], subject: jsonData['subject']);
  }
}

class PicturePairData {
  String picture;
  String description;

  PicturePairData({this.picture, this.description});

  factory PicturePairData.fromJSON(Map<String, dynamic> jsonData) {
    return PicturePairData(picture: jsonData['picture'], description: jsonData['description']);
  }
}

class Test2Data {
  String name;
  String heading;
  String subject;
  List<PicturePairData> pictures;

  Test2Data({this.name, this.pictures, this.heading, this.subject});

  factory Test2Data.fromJSON(Map<String, dynamic> jsonData) {
    List<PicturePairData> pics = [];
    for (var x in jsonData['pictures']) {
      pics.add(PicturePairData.fromJSON(x));
    }
    return Test2Data(name: jsonData['name'], pictures: pics, heading: jsonData['heading'], subject: jsonData['subject']);
  }
}

class NumberList {
  List<int> numbers;

  NumberList({this.numbers});

  factory NumberList.fromJSON(Map<String, dynamic> jsonData) {
    List<int> nums = [];
    for (var x in jsonData['numbers']) {
      nums.add(x);
    }
    return NumberList(numbers: nums);
  }
}

class Test3Data {
  String name;
  String heading;
  String subject;
  List<NumberList> numberLists;

  Test3Data({this.name, this.numberLists, this.heading, this.subject});

  factory Test3Data.fromJSON(Map<String, dynamic> jsonData) {
    List<NumberList> numbersList = [];
    for (var x in jsonData['number_lists']) {
      numbersList.add(NumberList.fromJSON(x));
    }
    return Test3Data(
        name: jsonData['name'], numberLists: numbersList, heading: jsonData['heading'], subject: jsonData['subject']);
  }
}

class AudioPairData {
  String audio;
  String description;

  AudioPairData({this.audio, this.description});

  factory AudioPairData.fromJSON(Map<String, dynamic> jsonData) {
    return AudioPairData(audio: jsonData['audio'], description: jsonData['description']);
  }
}

class Test4Data {
  String name;
  String heading;
  String subject;
  List<AudioPairData> audios;

  Test4Data({this.name, this.audios, this.heading, this.subject});

  factory Test4Data.fromJSON(Map<String, dynamic> jsonData) {
    List<AudioPairData> pics = [];
    for (var x in jsonData['audios']) {
      pics.add(AudioPairData.fromJSON(x));
    }
    return Test4Data(name: jsonData['name'], audios: pics, heading: jsonData['heading'], subject: jsonData['subject']);
  }
}

class ImageChoiceData {
  String text;
  String picture;
  bool correct;

  ImageChoiceData({this.text, this.picture, this.correct});

  factory ImageChoiceData.fromJson(Map<String, dynamic> jsonData) {
    return ImageChoiceData(
        text: jsonData['text'], picture: jsonData['image'], correct: jsonData['correct']);
  }
}

class ImageQuestionData {
  String text;
  List<ImageChoiceData> options;

  ImageQuestionData({this.text, this.options});

  factory ImageQuestionData.fromJSON(Map<String, dynamic> jsonData) {
    List<ImageChoiceData> opts = [];
    for (var x in jsonData['options']) {
      opts.add(ImageChoiceData.fromJson(x));
    }
    return ImageQuestionData(text: jsonData['text'], options: opts);
  }
}

class Test5Data {
  String name;
  List<ImageQuestionData> questions;
  String subject;

  Test5Data({this.name, this.questions,this.subject});

  factory Test5Data.fromJSON(Map<String, dynamic> jsonData) {
    List<ImageQuestionData> ques = [];
    for (var q in jsonData['questions']) {
      ques.add(ImageQuestionData.fromJSON(q));
    }
    return Test5Data(name: jsonData['name'], questions: ques, subject: jsonData['subject']);
  }
}

class PictureTextInput {
  String picture;
  String correctText;

  PictureTextInput({this.picture, this.correctText});

  factory PictureTextInput.fromJSON(Map<String, dynamic> jsonData) {
    return PictureTextInput(picture: jsonData['picture'], correctText: jsonData['correct_text']);
  }
}

class Test6Data {
  String name;
  String heading;
  List<PictureTextInput> choices;
  String subject;
  Test6Data({this.name, this.choices, this.heading, this.subject});

  factory Test6Data.fromJSON(Map<String, dynamic> jsonData) {
    List<PictureTextInput> pics = [];
    for (var x in jsonData['pictures']) {
      pics.add(PictureTextInput.fromJSON(x));
    }
    return Test6Data(name: jsonData['name'], heading: jsonData['heading'], choices: pics, subject: jsonData['subject']);
  }
}

class TextPair {
  String first, second;

  TextPair({this.first, this.second});

  factory TextPair.fromJSON(Map<String, dynamic> jsonData) {
    return TextPair(first: jsonData['first'], second: jsonData['second']);
  }
}

class Test9Data {
  String heading;
  List<TextPair> questions;
  String subject;
  Test9Data({this.heading, this.questions, this.subject});

  factory Test9Data.fromJSON(Map<String, dynamic> jsonData) {
    List<TextPair> ques = [];
    for (var x in jsonData['questions']) {
      ques.add(TextPair.fromJSON(x));
    }
    return Test9Data(heading: jsonData['heading'], questions: ques, subject: jsonData['subject']);
  }
}
