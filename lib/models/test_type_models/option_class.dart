class Option{
  final String text;
  final bool choice;

  Option({this.text, this.choice});

  factory Option.fromJson(Map<String, dynamic> json){
    return Option(
        text: json['text'],
        choice: json['choice']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'text' : text,
      'choice' : choice
    };
  }
}

class PicturePair{
  final String picture; // url of the picture.
  final String description; // description of the picture

  PicturePair({this.picture, this.description});

  factory PicturePair.fromJson(Map<String, dynamic> json){
    return PicturePair(
        picture: json['picture'],
        description: json['description']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'picture' : picture,
      'description' : description
    };
  }
}

class ImageChoice{
  final String text;
  final String picture;
  final bool correct;
  ImageChoice({this.picture, this.text, this.correct});
  factory ImageChoice.fromJson(Map<String, dynamic> json){
    return ImageChoice(
        text: json['text'],
        picture: json['picture'],
        correct: json['correct'],
    );
  }
  Map<String, dynamic> toMap(){
    return {
      'text' : text,
      'picture' : picture,
      'correct' : correct
    };
  }
}

class PictureTextInput{
  final String picture;
  final String correctText;
  PictureTextInput({this.picture, this.correctText});
  factory PictureTextInput.fromJson(Map<String, dynamic> json){
    return PictureTextInput(
        picture: json['picture'],
        correctText: json['correctText']
    );
  }
  Map<String, dynamic> toMap(){
    return {
      'picture': picture,
      'correctText' : correctText
    };
  }
}

class TextPair{
  final String first;
  final String second;
  TextPair({this.first, this.second});
  factory TextPair.fromJson(Map<String, dynamic> json){
    return TextPair(
        first: json['first'],
        second: json['second']
    );
  }
  Map<String, dynamic> toMap(){
    return {
      'first' : first,
      'second' : second
    };
  }
}

class NumberList{
  final List<int> numbers = [];
}

class AudioPair{
  final String audio;
  final String description;
  AudioPair({this.audio, this.description});

  factory AudioPair.fromJson(Map<String, dynamic> json){
    return AudioPair(
        audio: json['audio'],
        description: json['description']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'audio' : audio,
      'description' : description
    };
  }
}