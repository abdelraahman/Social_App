import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socail_app/CacheHelper.dart';
import 'package:socail_app/cubit/Social_Layout_State.dart';
import 'package:socail_app/models/Chat_Model.dart';
import 'package:socail_app/models/Post_Model.dart';
import 'package:socail_app/modules/chats/Chat_Screen.dart';
import 'package:socail_app/modules/feeds/Feeds_Screen.dart';
import 'package:socail_app/modules/settings/SettingScreen.dart';
import 'package:socail_app/modules/users/Users_Screen.dart';
import '../models/User_Model.dart';

class SocialLayoutCubit extends Cubit<SocialLayoutStates>{
  SocialLayoutCubit():super(SocialLayoutInitialState());
  static SocialLayoutCubit get(context)=> BlocProvider.of(context);
  UserModel? userModel;
  String uId = CacheHelper.getData(key: 'token');
  void getUserData(){
    emit(SocialLayoutLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      if (value.data() == null) return print('Empty Data From DataBase');
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialLayoutSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(SocialLayoutErrorState());
    });
  }

  int currentIndex=0;
  List<Widget> Screens =[
    FeedsScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingScreen(),
  ];
  List<String> Titles=[
    'News Feed',
    'Chats',
    'Friends',
    'Profile',
  ];
  void ChangeIndex(int index){
    currentIndex = index;
    emit(SocialChangeIndexState());
  }

  File? imageProfile;
  Future pickImageProfile() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      this.imageProfile =imageTemp;
      emit(SocialChangeProfileSuccessState());

    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
      emit(SocialChangeProfileErrorState());
    }
  }

  File? imageCover;
  Future pickImageCover() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      this.imageCover =imageTemp;
      emit(SocialChangeCoverSuccessState());
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
      emit(SocialChangeCoverErrorState());
    }
  }

  void ChangeName(String userName){
    emit(SocialChangeNameLoadingState());
    UserModel user = UserModel(
        userName,
        userModel?.email,
        userModel?.password,
        uId,
        userModel?.image,
        userModel?.bio,
        userModel?.cover);
    FirebaseFirestore.instance.collection('users').doc(uId).update(user.toMap()).then((value) {
      emit(SocialChangeNameSuccessState());
      getUserData();
    }).catchError((onError){
      print(onError);
      emit(SocialLayoutErrorState());
    });
  }

  void ChangeBio(String Bio){
    emit(SocialChangeBioLoadingState());
    UserModel user = UserModel(
        userModel?.name,
        userModel?.email,
        userModel?.password,
        uId,
        userModel?.image,
        Bio,
        userModel?.cover);
    FirebaseFirestore.instance.collection('users').doc(uId).update(user.toMap()).then((value) {
      emit(SocialChangeBioSuccessState());
      getUserData();
    }).catchError((onError){
      print(onError);
      emit(SocialChangeBioErrorState());
    });
  }


  PostModel? postModel;

  void CreatePost(
  {
    required String name,
    required String uId,
    required String userImage,
    required String text,
    required String date,
  }
      ){
    postModel = PostModel(name, uId, userImage, text, date);
    emit(postLoadingState());
    FirebaseFirestore.instance.collection('posts').add(postModel!.toMap()).then((value){
      emit(postSuccessState());
    }).catchError((onError){
      print(onError);
      emit(postErrorState());
    });

  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> Likes=[];
  List<int> comments=[];
  void GetComments(){
    emit(getPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value){
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((valuee){
          comments.add(valuee.docs.length);
          print(comments);
        }).catchError((onError){

        });
      });

      emit(getPostSuccessState());
    }).catchError((onError){
      print(onError);
      emit(getPostErrorState());
    });
  }
  Map<String?,bool> FavPost ={};
  void GetPosts(){
    emit(getPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value){
      value.docs.forEach((element) {
        FavPost.addAll({'${element.id}':false});
        element.reference.collection('likes')
            .get().then((valuee) {
              Likes.add(valuee.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((onError){
        });
      });
      //print(posts[0].text);
      emit(getPostSuccessState());
    }).catchError((onError){
      print(onError);
      emit(getPostErrorState());
    });
  }
  void LikePost(String postId){
    emit(likeLoadingState());
    FirebaseFirestore.instance.collection('posts')
    .doc(postId).collection('likes').doc(userModel?.uId)
    .set({
      'like':true,
    }).then((value) {
      FavPost[postId] =!(FavPost[postId])!;
      emit(likeSuccessState());
      print(FavPost);
    }).catchError((onError){
      emit(likeErrorState());
    });
  }
  void CommentPost(String postId,String comment){
    emit(CommentLoadingState());
    FirebaseFirestore.instance.collection('posts')
    .doc(postId).collection('comments').doc(userModel?.uId)
    .set({'comment':comment}).then((value){
      emit(CommentSuccessState());
    }).catchError((onError){
      print(onError);
      emit(CommentErrorState());

    });
  }

  List<UserModel> users = [];
  void GetUsers(){
    emit(ShowFriendsLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((element) {
        if(element.data()['uId'] != userModel?.uId)
        users.add(UserModel.fromJson(element.data()));
        emit(ShowFriendsSuccessState());
      });
    }).catchError((onError){
      print(onError);
      emit(ShowFriendsErrorState());
    });
  }

  void SendMessage({
    required String reciverId,
    required String message,
    required String date
})
  {
    ChatModel model = ChatModel(
        userModel?.uId,
        reciverId,
        message,
        date
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(model.toMap()).then((value){
          emit(MessageSuccessState());
    }).catchError((onError){
      emit(MessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(model.toMap()).then((value){
      emit(MessageSuccessState());
    }).catchError((onError){
      emit(MessageErrorState());
    });


  }

  List<ChatModel> chats=[] ;
  void getChats(
  {
  required String reciverId,
}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
          chats = [];
          event.docs.forEach((element) {
            chats.add(ChatModel.fromJson(element.data()));
          });
          emit(GetMessSuccessState());

    });

  }




}