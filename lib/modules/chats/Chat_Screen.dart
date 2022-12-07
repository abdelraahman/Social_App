import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constant.dart';
import '../../cubit/Social_Layout_Cubit.dart';
import '../../cubit/Social_Layout_State.dart';
import '../../models/User_Model.dart';
import 'ChatDetails.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        List<UserModel> users = SocialLayoutCubit.get(context).users;
        UserModel myModel =  (SocialLayoutCubit.get(context).userModel)!;
        return ListView.builder(
          itemBuilder: (context, index) => FriendsItem(users,index,context,myModel),
          itemCount: users.length,
        );
      },
    ) ;
  }
  Widget FriendsItem(List<UserModel> users,index,context,myModel){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChaatDetails(userModel:myModel, friendModel: users[index]) ,));
      },
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
                    Icon(Icons.chat_outlined,color: orange,),

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
