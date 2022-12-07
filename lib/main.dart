import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/cubit/Social_Layout_Cubit.dart';
import 'package:socail_app/modules/social_layout.dart';
import 'CacheHelper.dart';
import 'modules/login_Screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
 // DioHelper.init();
//  bool? isDark = cacheHelper.getData(key: 'isDark');
 // bool? onBoard = cacheHelper.getData(key: 'onBoard');
  String? token = CacheHelper.getData(key: 'token');

  Widget? startWidget;
  if (token != null){
    startWidget = SocialLayout();
  }else{
    startWidget = loginScreen();
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialLayoutCubit()..getUserData()..GetPosts()..GetComments()..GetUsers(),
        ),
      ],
      child: MyApp(startWidget),
    ),
  );
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  final Widget startWidget;

  MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: startWidget,
    );
  }
}

