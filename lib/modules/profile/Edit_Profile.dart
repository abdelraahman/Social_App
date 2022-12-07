import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constant.dart';
import '../../cubit/Social_Layout_Cubit.dart';
import '../../cubit/Social_Layout_State.dart';
import '../../models/User_Model.dart';

class EditProfile extends StatelessWidget {
  //const EditProfile({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Edit Profile',style: TextStyle(color: Colors.white),),
        backgroundColor: background,
        foregroundColor: orange,
      ),
      body:  BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
        listener: (context, state) {},
        builder: (context, state){
          UserModel? userModel = SocialLayoutCubit.get(context).userModel;
          var profileImage = SocialLayoutCubit.get(context).imageProfile;
          var CoverImage = SocialLayoutCubit.get(context).imageCover;

          return buildProfileItem(userModel,profileImage,CoverImage,context);
        },
      ),
    ) ;
  }
  Widget buildProfileItem(UserModel? userModel,File? profileImage,File? coverImage,context)=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 190.0,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Align(
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 170.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:coverImage == null? NetworkImage('${userModel?.cover}'):FileImage(File(coverImage!.path)) as ImageProvider

                          ),
                        ),
                      ),
                      IconButton(onPressed: (){
                        SocialLayoutCubit.get(context).pickImageCover();
                      },
                          icon: Icon(Icons.add_a_photo_rounded),color: orange,),
                    ],
                  ),
                  alignment: AlignmentDirectional.topCenter,
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: background,
                      child: CircleAvatar(
                        radius: 55.0,
                        backgroundImage:profileImage == null? NetworkImage('${userModel?.image}'):FileImage(File(profileImage!.path)) as ImageProvider
                      ),
                    ),
                    IconButton(onPressed: (){
                      SocialLayoutCubit.get(context).pickImageProfile();
                    },
                      icon: Icon(Icons.add_a_photo_rounded),color: orange,),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0,),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: nameController ,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if(value != null && value.isEmpty)
                      return "User Name Canot be Empty";
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    border: OutlineInputBorder(),
                    label: Text('${userModel?.name}',style: TextStyle(color: Colors.white),),
                    prefixIcon:Icon(Icons.person,color: orange,),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              IconButton(onPressed: (){
                if (nameController.text.isEmpty)
                nameController.text  = (userModel?.name)!;
                print(nameController.text);
                SocialLayoutCubit.get(context).ChangeName(nameController.text);
              },
                  icon: Icon(Icons.edit),color: orange,),
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: bioController ,
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if(value != null && value.isEmpty)
                      return "Bio  Canot be Empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('${userModel?.bio}',style: TextStyle(color: Colors.white),),
                    prefixIcon:Icon(Icons.info,color: orange,),
                  ),
                ),
              ),
              IconButton(onPressed: (){
                if (bioController.text.isEmpty)
                  bioController.text  = (userModel?.bio)!;
                print(bioController.text);
                SocialLayoutCubit.get(context).ChangeBio(bioController.text);
              },
                icon: Icon(Icons.edit),color: orange,),
            ],
          ),
          SizedBox(height: 25.0,),


        ],
      ),
    ),
  );
}
