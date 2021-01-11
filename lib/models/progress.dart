import 'dart:convert';

class Progress{
  String name;
  String description;
  int partsDone;
  int total;
  double percentage;
  List responses;
  Progress({this.name,this.description,this.partsDone,this.total,this.responses}){
      this.percentage = (this.partsDone/this.total)*100;
  }

  factory Progress.fromJSON(Map json){
    return Progress(
        name: json["name"],
        description:json["description"],
        partsDone: json["partsDone"],
        total: json["partsDone"],
        responses: json["responses"] is List<Object> ?json["responses"]:List.from(Map.from(json["responses"]).values)
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "name": this.name,
      "description": this.description,
      "partsDone": this.partsDone,
      "total": this.total,
      "percentage": this.percentage,
      "responses": this.responses
    };
  }
}