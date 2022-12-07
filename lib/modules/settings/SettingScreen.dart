import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/constant.dart';
import 'package:socail_app/models/User_Model.dart';

import '../../cubit/Social_Layout_Cubit.dart';
import '../../cubit/Social_Layout_State.dart';
import '../profile/Edit_Profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body:  BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
        listener: (context, state) {},
        builder: (context, state){
          UserModel? userModel = SocialLayoutCubit.get(context).userModel;
          return buildProfileItem(userModel,context);
        },
      ),
    ) ;
  }
  Widget buildProfileItem(UserModel? userModel, context)=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 190.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Align(
                child: Container(
                  width: double.infinity,
                  height: 170.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:  NetworkImage('${userModel?.cover}'),
                    ),
                  ),
                ),
                alignment: AlignmentDirectional.topCenter,
              ),
              CircleAvatar(
                radius: 60.0,
                backgroundColor: background,
                child: CircleAvatar(
                  radius: 55.0,
                  backgroundImage: NetworkImage('${userModel?.image}',
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          '${userModel?.name}',
          maxLines: 1,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),
        ),
        SizedBox(height: 8.0,),
        Text(
          '${userModel?.bio}',
          style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 15.0
          ),
        ),
        SizedBox(height: 25.0,),
        Row(
          children: [
            Expanded(
              child: InkWell(
                child: Column(
                  children: [
                    Text(
                      '100',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Text(
                      'Posts',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),
                    ),
                  ],
                ),
                onTap: (){},
              ),
            ),
            Expanded(
              child: InkWell(
                child: Column(
                  children: [
                    Text(
                      '60',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Text(
                      'Photos',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),
                    ),
                  ],
                ),
                onTap: (){},
              ),
            ),
            Expanded(
              child: InkWell(
                child: Column(
                  children: [
                    Text(
                      '42',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Text(
                      'Followers',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),
                    ),
                  ],
                ),
                onTap: (){},
              ),
            ),
            Expanded(
              child: InkWell(
                child: Column(
                  children: [
                    Text(
                      '18',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Text(
                      'Groups',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),
                    ),
                  ],
                ),
                onTap: (){},
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            child: MaterialButton(
              color: orange,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(),));
              },
              child: Text(
                'EDIT PROFILE',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

      ],
    ),
  );

}
