import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/cubit/Social_Reg_states.dart';

import '../CacheHelper.dart';
import '../models/User_Model.dart';

class socialRegCubit extends Cubit<socialRegStates>{
  socialRegCubit(): super(socialRegInitialState());
  static socialRegCubit getObject(context) => BlocProvider.of<socialRegCubit>(context);

 // ShopLoginModelData ?loginModel;

  void userReg({
    required String email,
    required String userName,
    required String password,
    required String phone,
  }){
    emit(socialRegLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      UserCreate(email: email, userName: userName, phone: phone, uId: value.user?.uid);
    }).catchError((onError){
      print(onError.toString());
      emit(socialRegErrorState());
    });

  }

  void UserCreate({
    required String email,
    required String userName,
    required String phone,
    required String? uId,
  }){
    String image;
    String bio;
    String cover;
    UserModel userModel = UserModel(
      userName = userName,
      email = email,
      phone = phone,
      uId = uId,
      image = 'https://www.freepik.com/free-photo/calm-happy-smiling-caucasian-man-s-portrait-gradient-studio-background-neon-light-beautiful-male-model-with-hipster-style-earphones-concept-human-emotions-facial-expression-ad_14312081.htm#from_view=detail_alsolike',
      bio = 'Write your bio',
      cover='https://img.freepik.com/free-photo/calm-happy-caucasian-man-s-portrait-gradient-studio-background-neon-light-beautiful-male-model-with-hipster-style-earphones-concept-human-emotions-facial-expression-sales-ad_155003-30709.jpg?w=996&t=st=1670190219~exp=1670190819~hmac=fed24191495c5bb1f8f2f458472f71079635e491bef3d6be76aa37d7803211dc'
    );
    emit(CreateUserLoadingState());
    print(userModel.toMap());
    FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value){
      emit(CreateUserSuccessState());
      CacheHelper.saveDataInSharedPref(key: 'token', value: uId);
      print('New user Created');
    }).catchError((onError){
      print(onError.toString());
      print("New User Canot Created");
      emit(CreateUserErrorState());
    });
  }




}