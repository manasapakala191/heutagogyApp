import 'option_class.dart';

class QuestionData{
  String text;
  String image;
  String youtubeVideo;
  List<Option> options;

  QuestionData({this.text, this.image, this.options, this.youtubeVideo});

  factory QuestionData.fromJson(Map<String, dynamic> json){
    List _optionMaps = json['options'];
    return QuestionData(
        text: json['text'],
        image: json['image'],
        youtubeVideo: json['youtubeVideo'],
        options: _optionMaps.map((e) => Option.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'text' : text,
      'image' : image,
      'youtubeVideo' : youtubeVideo,
      'options' : options.map((e) => e.toMap()).toList()
    };
  }
}

class ImageQuestionData{
  final String question;
  final List<ImageChoice> options;

  ImageQuestionData({this.options, this.question});

  factory ImageQuestionData.fromJson(Map<String, dynamic> json){
    List _optionMaps = json['options'];
    return ImageQuestionData(
        question: json['question'],
        options: _optionMaps.map((e) => ImageChoice.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'question' : question,
      'options' : options.map((e) => e.toMap()).toList()
    };
  }
}