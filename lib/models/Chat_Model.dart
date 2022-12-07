class ChatModel{
  String? senderId;
  String? reciverId;
  String? message;
  String? date;


  ChatModel(
      this.senderId,
      this.reciverId,
      this.message,
      this.date,
      );
  ChatModel.fromJson(Map<String,dynamic>json){
    senderId = json['senderId'];
    reciverId = json['reciverId'];
    message = json['message'];
    date = json['date'];
  }

  Map<String,dynamic> toMap(){
    return {
      'senderId':senderId,
      'reciverId':reciverId,
      'message':message,
      'date':date,
    };
  }

}