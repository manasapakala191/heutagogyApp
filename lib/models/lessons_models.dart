
class Lesson{
  final String subject;

  final String lessonName;
  final String description;
  final String videoUrl;
  final String lessonContent;
  final String type;
  Lesson({this.description, this.lessonContent, this.lessonName, this.videoUrl, this.subject,this.type});

  factory Lesson.fromJson(Map<String, dynamic> json){
    return Lesson(
      subject: json['subject'],
      lessonName: json['name'],
      lessonContent: json['content'],
      videoUrl: json['videoUrl'],
      description: json['description'],
      type: json['type'],
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