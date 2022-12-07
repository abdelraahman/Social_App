import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:socail_app/constant.dart';
import 'package:socail_app/cubit/Socail_Login_Cubit.dart';
import 'package:socail_app/cubit/Social_Layout_Cubit.dart';
import 'package:socail_app/cubit/Social_Login_State.dart';
import 'package:socail_app/modules/social_Reg_Screen.dart';
import 'package:socail_app/modules/social_layout.dart';

class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final  keyForm = GlobalKey<FormState>();
  bool iconVisibility = true;
  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => socialLoginCubit(),
      child: BlocConsumer<socialLoginCubit,socialLoginState>(
        listener: (context, state) {
          if(state is socialLoginErrorState){
            final snackBar =  SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,

            );
             ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if(state is socialLoginsuccessState){
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => SocialLayout(),),
                    (route) => false);
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: HexColor("#36454F"),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start ,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        "Login now to communicate with friends",
                        style: TextStyle(
                          color:  HexColor("#F87217"),
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                         // focusColor: Colors.white,
                          labelText: "Email Address",
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.email,color:  HexColor("#F87217"),),

                          border: OutlineInputBorder(),
                        ),
                        validator: (String? email){
                          if(email != null && email.isEmpty){
                            return " Email can't be empty";
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 10.0,),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        obscureText: iconVisibility?!showPass:showPass,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          label: Text("Password"),
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.lock,color: HexColor("#F87217"),),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                iconVisibility = !iconVisibility;
                              });
                            },
                            icon:iconVisibility? Icon(Icons.visibility_off):Icon(Icons.visibility),
                          color: HexColor("#F87217"),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? pass){
                          if(pass != null && pass.isEmpty){
                            return "password is short";
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 20.0,),
                      ConditionalBuilder(
                        condition: state is! socialLoginLoadingState ,
                        fallback:(context) => Center(child: CircularProgressIndicator(color: orange,)),
                        builder: (context) => Container(
                          width: double.infinity,
                          color: HexColor("#E56717"),
                          child: MaterialButton(
                              onPressed: (){
                                if(keyForm.currentState!.validate()){
                                  print('login success');
                                  socialLoginCubit.getObject(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }else{
                                  print("can\'t login now");
                                }
                              },
                              child:Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ) ),
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Do\'t have an account?',style: TextStyle(color: Colors.white),),
                          TextButton(onPressed: (){
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context)=> SocialRegisterScreen()),
                                    (route) => false);
                          }, child: Text("Register Now",style: TextStyle(color:HexColor("#F87217"),),)),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
