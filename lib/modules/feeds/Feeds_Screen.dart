import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail_app/cubit/Social_Layout_Cubit.dart';
import 'package:socail_app/cubit/Social_Layout_State.dart';
import 'package:socail_app/models/User_Model.dart';

import '../../constant.dart';
import '../../models/Post_Model.dart';

class FeedsScreen extends StatelessWidget {
  //const FeedsScreen({Key? key}) : super(key: key);
  var postController = TextEditingController();
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        SocialLayoutCubit()..getUserData();
        UserModel? userModel = SocialLayoutCubit.get(context).userModel;
        print(userModel?.name);
        List<String> postsId = SocialLayoutCubit.get(context).postsId;
        int len = SocialLayoutCubit.get(context).posts.length;
        List<int> likes = SocialLayoutCubit.get(context).Likes;
        List<int> comments = SocialLayoutCubit.get(context).comments;
        Map<String?,bool>? FavPost = SocialLayoutCubit.get(context).FavPost;
        print(FavPost);

        return  ConditionalBuilder(
          condition: userModel != null ,
          builder: (context) =>  SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 160.0,
                  child: Card(
                    elevation: 10.0,
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(
                                  '${userModel?.image}',
                                ),
                              ),
                              SizedBox(width: 20.0,),
                              Text('${userModel?.name}',style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),),
                              Spacer(),
                              TextButton(
                                onPressed: (){
                                  SocialLayoutCubit.get(context).CreatePost(
                                    name: (userModel?.name)!,
                                    uId: (userModel?.uId)!,
                                    userImage: (userModel?.image)!,
                                    text: postController.text,
                                    date: DateTime.now().toString(),
                                  );
                                  postController.clear();
                                  SocialLayoutCubit.get(context).posts.clear();
                                  SocialLayoutCubit.get(context).GetPosts();
                                },
                                child: Text('POST',
                                  style: TextStyle(
                                    color: orange,
                                  ),),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: postController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "What Is On Your Mind.....!",
                                border:InputBorder.none,
                              ),
                              validator: (value) {
                                if(value != null && value.isEmpty)
                                  return "Post Cant Be Empty";
                                else return null;
                              },
                            ),
                          ),
                          if(state is postLoadingState)
                            LinearProgressIndicator(color: orange,),

                        ],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(SocialLayoutCubit.get(context).posts,index,context,userModel,postsId,likes,comments,FavPost),
                  itemCount: len,
                ),
              ],
            ),
          ),
          fallback:(context) => Center(child: CircularProgressIndicator(color: orange,)) ,
        );
      },
    );
  }

  Widget buildPostItem(List<PostModel> posts,index,context,UserModel? userModel,List<String>postsId,List<int>likes,List<int>comments,Map<String?,bool>? favPost)=> Column(
    children: [
      Card(
        elevation: 10.0,
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      '${posts[index].userImage}',
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${posts[index].name}'),
                          SizedBox(width: 8.0,),
                          Icon(Icons.check_circle,color: Colors.blue,size: 15.0,),
                        ],
                      ),
                      Text('${posts[index].date}',style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                      ),),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: (){},
                      icon:Icon(Icons.more_horiz_outlined)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${posts[index].text}',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Container(
                      height: 25.0,
                      child: MaterialButton(
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed:(){},
                        child: Text(
                          '#software',
                          style: TextStyle(
                            color: Colors.blue,
                          ),

                        ),

                      ),
                    ),
                    Container(
                      height: 25.0,
                      child: MaterialButton(
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed:(){},
                        child: Text(
                          '#software',
                          style: TextStyle(
                            color: Colors.blue,
                          ),

                        ),

                      ),
                    ),
                    Container(
                      height: 25.0,
                      child: MaterialButton(
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed:(){},
                        child: Text(
                          '#software',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),

                      ),
                    ),
                    Container(
                      height: 25.0,
                      child: MaterialButton(
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed:(){},
                        child: Text(
                          '#software',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),

                      ),
                    ),
                    Container(
                      height: 25.0,
                      child: MaterialButton(
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed:(){},
                        child: Text(
                          '#software_development_Egypt',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.0,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          SizedBox(width: 7.0,),
                          Text(
                            '${likes[index]}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.chat_outlined,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 7.0,),
                          Text(
                            '${comments[index]}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
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
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                          '${userModel?.image}',
                        ),
                      ),
                      SizedBox(width: 20.0,),
                     Container(
                       width: 200.0,
                       child: TextFormField(
                         controller: commentController,
                         keyboardType: TextInputType.name,
                         decoration: InputDecoration(
                           hintText: 'Write A Comment....',
                           border: InputBorder.none,
                         ),
                         validator: (value) {
                           if(value!=null&&value.isEmpty)
                             return 'Comment Cant Be Empty';
                           return null;
                         },
                         onFieldSubmitted: (newValue) {
                           SocialLayoutCubit.get(context).CommentPost(postsId[index], newValue!);
                           commentController.clear();
                         },
                       ),

                     ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    child: Row(
                      children: [
                        if(favPost != null && (favPost[postsId[index]])!)
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        if(favPost != null && !(favPost[postsId[index]])!)
                          Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                        SizedBox(width: 7.0,),
                        Text(
                          'Like',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onTap: (){
                      SocialLayoutCubit.get(context).LikePost(postsId[index]);

                    },
                  ),

                ],
              ),
            ],
          ),
        ),
      ),

    ],
  );

}
