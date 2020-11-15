class Progress{
  int partsDone;
  int total;
  double percentage;
  List<String> responses;
  Progress(this.partsDone,this.total,this.responses){
      this.percentage = (this.partsDone/this.total)*100;
  }
  
  Map<String,dynamic> toMap(){
    return {
      "partsDone": this.partsDone,
      "total": this.total,
      "percentage": this.percentage,
      "responses": this.responses
    };
  }
}