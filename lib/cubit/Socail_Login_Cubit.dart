import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/CacheHelper.dart';
import 'package:socail_app/cubit/Social_Login_State.dart';

class socialLoginCubit extends Cubit<socialLoginState>{
  socialLoginCubit(): super(socialLoginInitialState());
  static socialLoginCubit getObject(context) => BlocProvider.of<socialLoginCubit>(context);

  //ShopLoginModelData ?loginModel;

  void userLogin({
    required String email,
    required String password,
  }){
    emit(socialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
      emit(socialLoginsuccessState());
      CacheHelper.saveDataInSharedPref(key: 'token', value: value.user?.uid);
    }).catchError((onError){
      print(onError.toString());
      emit(socialLoginErrorState(onError.toString()));
    });


  }

}