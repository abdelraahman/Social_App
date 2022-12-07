import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/constant.dart';
import 'package:socail_app/cubit/Social_Layout_Cubit.dart';
import 'package:socail_app/cubit/Social_Layout_State.dart';
import 'package:socail_app/models/User_Model.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        List<UserModel> users = SocialLayoutCubit.get(context).users;
        return ListView.builder(
            itemBuilder: (context, index) => FriendsItem(users,index),
            itemCount: users.length,
        );
      },
    );
  }
  Widget FriendsItem(List<UserModel> users,index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: 100.0,
        child: Card(
          elevation: 10.0,
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 34.0,
                      backgroundImage: NetworkImage(
                        '${users[index]?.image}',
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    Text('${users[index]?.name}',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,color: orange,),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
