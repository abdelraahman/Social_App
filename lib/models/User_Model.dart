class UserModel{
  String? name;
  String? email;
  String? password;
  String? uId;
  String? image;
  String? bio;
  String? cover;
  UserModel(
      this.name,
      this.email,
      this.password,
      this.uId,
      this.image,
      this.bio,
      this.cover
      );
  UserModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    email = json['email'];
    password = json['password'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'password':password,
      'uId':uId,
      'image':image,
      'bio':bio,
      'cover':cover,
    };
  }

}