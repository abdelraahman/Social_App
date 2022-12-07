import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/constant.dart';
import 'package:socail_app/cubit/Social_Layout_Cubit.dart';
import 'package:socail_app/cubit/Social_Layout_State.dart';
import 'package:socail_app/models/Chat_Model.dart';
import 'package:socail_app/models/User_Model.dart';

class ChaatDetails extends StatefulWidget {
  UserModel userModel;
  UserModel friendModel;

  ChaatDetails({required this.userModel, required this.friendModel});

  @override
  State<ChaatDetails> createState() => _ChaatDetailsState(friendModel: friendModel);

}

class _ChaatDetailsState extends State<ChaatDetails> {
  var messController = TextEditingController();
  UserModel friendModel;
  _ChaatDetailsState({required this.friendModel});
  initState() {
   SocialLayoutCubit.get(context).getChats(reciverId:(friendModel.uId)!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {

            int len = SocialLayoutCubit.get(context).chats.length;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: background,
                foregroundColor: orange,
                titleSpacing: 0.0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('${widget.friendModel.image}'),
                    ),
                    SizedBox(width: 15.0,),
                    Text('${widget.friendModel.name}',style: TextStyle(color: Colors.white),),

                  ],
                ),
              ),
              body: Container(
                width: double.infinity,
                color: background,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 5.0,
                          right: 5.0,
                        ),
                        child: ListView.separated(
                          itemCount: len,
                          separatorBuilder: (context, index) => SizedBox(height: 10.0,),
                          itemBuilder: (context, index) {
                            if (widget.userModel.uId == SocialLayoutCubit.get(context).chats[index].senderId)
                              return buildMyMess(SocialLayoutCubit.get(context).chats[index]);
                            return buildSendMess(SocialLayoutCubit.get(context).chats[index]);
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 50.0,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: messController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Your Message..",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            width: 4.0,
                            color: background,
                          ),
                          TextButton(
                              onPressed: (){
                                setState((
                                    ){
                                  SocialLayoutCubit.get(context).SendMessage(
                                    reciverId: (widget.friendModel.uId)!,
                                    message: messController.text,
                                    date: DateTime.now().toString(),
                                  );
                                  messController.clear();
                                }
                                );
                              },
                              child: Text('Sent',style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: orange),)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );


  }

  Widget buildMyMess(ChatModel mess)=>  Row(
    children: [
      CircleAvatar(
        radius: 20.0,
        backgroundImage: NetworkImage('${widget.userModel.image}'),
      ),
      SizedBox(width: 10.0,),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: orange,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0) ,
              topEnd: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.all(10.0),
          child: Text('${mess.message}',style: TextStyle(color: Colors.white),),
        ),
      ),
    ],
  );

  Widget buildSendMess(ChatModel mess)=>Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: orange,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0) ,
              topEnd: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.all(10.0),
          child: Text('${mess.message}',style: TextStyle(color: Colors.white),),
        ),
      ),
      SizedBox(width: 10.0,),
      CircleAvatar(
        radius: 20.0,
        backgroundImage: NetworkImage('${widget.friendModel.image}'),
      ),

    ],
  );
}
