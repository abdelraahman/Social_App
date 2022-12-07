import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:socail_app/CacheHelper.dart';
import 'package:socail_app/constant.dart';
import 'package:socail_app/cubit/Social_Layout_Cubit.dart';
import 'package:socail_app/cubit/Social_Layout_State.dart';
import 'package:socail_app/models/User_Model.dart';
import 'package:socail_app/modules/search/SearchScreen.dart';
import 'package:socail_app/modules/settings/SettingScreen.dart';

import 'login_Screen.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel? userModel = SocialLayoutCubit.get(context).userModel;
        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: background,
            title: Text('${SocialLayoutCubit.get(context).Titles[SocialLayoutCubit.get(context).currentIndex]}',style: TextStyle(
            // color:HexColor('#F87217'),
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),),
            actions: [
              IconButton(
                color:HexColor('#F87217'),
              onPressed: (){
              }, icon: Icon(Icons.notifications),),
              IconButton(
                color:HexColor('#F87217'),
                onPressed: (){
                 SocialLayoutCubit.get(context).GetPosts();
              }, icon: Icon(Icons.search),),
              IconButton(
                color:HexColor('#F87217'),
                onPressed: (){
                CacheHelper.clearDataFromSharedPref(key: 'token');
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => loginScreen(),)
                    , (route) => false);
              }, icon: Icon(Icons.logout),)
            ],
          ),
          bottomNavigationBar:BottomNavigationBar(
            backgroundColor: background,
            selectedItemColor: orange,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                label: 'Feeds',
                icon: Icon(Icons.newspaper_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Chats',
                icon: Icon(Icons.chat),
              ),
              BottomNavigationBarItem(
                  label: 'Friends',
                  icon: Icon(Icons.people),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person),
              ),


            ],
            currentIndex: SocialLayoutCubit.get(context).currentIndex,
            onTap: (value) {
              SocialLayoutCubit.get(context).ChangeIndex(value);
            },
          ),
          body: ConditionalBuilder(
            condition:userModel != null,
            fallback:(context) =>  Center(child: CircularProgressIndicator()) ,
            builder: (context) {
              return SocialLayoutCubit.get(context).Screens[SocialLayoutCubit.get(context).currentIndex];
            },
          ),
        );
      },

    );
  }
}
