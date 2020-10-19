
class Lesson{
  final String subject;

  final String lessonName;
  final String description;
  final String videoUrl;
  final String lessonContent;
  Lesson({this.description, this.lessonContent, this.lessonName, this.videoUrl, this.subject});

  factory Lesson.fromJson(Map<String, dynamic> json){
    return Lesson(
      subject: json['subject'],
      lessonName: json['lessonName'],
      lessonContent: json['description'],
      videoUrl: json['videoUrl'],
      description: json['description']
    );
  }

  Map<String, dynamic>  toJson(){
    return {
      'lessonName' : this.lessonName,
      'description' : this.description,
      'videoUrl' : this.videoUrl,
      'lessonContent' : this.lessonContent,
      'subject' : this.subject
    };
  }
}