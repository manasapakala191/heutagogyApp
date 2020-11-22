class Progress{
  String name;
  String description;
  int partsDone;
  int total;
  double percentage;
  List<String> responses;
  Progress(this.name,this.description,this.partsDone,this.total,this.responses){
      this.percentage = (this.partsDone/this.total)*100;
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