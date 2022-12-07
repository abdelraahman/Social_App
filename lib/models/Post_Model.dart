class PostModel{
  String? name;
  String? uId;
  String? userImage;
  String? text;
  String? date;
  PostModel(
      this.name,
      this.uId,
      this.userImage,
      this.text,
      this.date,
      );
  PostModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    uId = json['uId'];
    userImage = json['userImage'];
    text = json['text'];
    date = json['date'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'uId':uId,
      'userImage':userImage,
      'text':text,
      'date':date,
    };
  }

}