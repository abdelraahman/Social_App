import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:socail_app/constant.dart';
import 'package:socail_app/cubit/Social_Reg_Cubit.dart';
import 'package:socail_app/cubit/Social_Reg_states.dart';
import 'package:socail_app/modules/social_layout.dart';

import 'login_Screen.dart';

class SocialRegisterScreen extends StatefulWidget {
  @override
  State<SocialRegisterScreen> createState() => _SocialRegisterScreenState();
}

class _SocialRegisterScreenState extends State<SocialRegisterScreen> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  final  keyForm = GlobalKey<FormState>();

  bool iconVisibility = true;

  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: BlocProvider(
          create: (context) => socialRegCubit(),
          child: BlocConsumer<socialRegCubit,socialRegStates>(
            listener: (context, state) {
              if(state is CreateUserSuccessState){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) =>  SocialLayout(),),
                            (route) => false);
                  }
                if(state is CreateUserErrorState){
                  Fluttertoast.showToast(
                      msg: "ERROR",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
              },
            builder: (context, state) => buildRegScreen(state),
          ),
        ),

    );
  }

  Widget buildRegScreen(state)=> Center(
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
                "REGISTER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                "Register now to communicate with friends",
                style: TextStyle(
                  color: orange,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),

              ),
              SizedBox(height: 30.0,),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                decoration: InputDecoration(
                  label: Text("User Name",style: TextStyle(color: Colors.white),),
                  prefixIcon: Icon(Icons.person,color: orange,),
                  border: OutlineInputBorder(),
                ),
                validator: (String? name){
                  if(name != null && name.isEmpty){
                    return "Name Canot Be Empty";
                  }
                  return null;
                },

              ),
              SizedBox(height: 10.0,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  label: Text('Email Address',style: TextStyle(color: Colors.white),),
                  prefixIcon: Icon(Icons.email,color:orange,),
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
                decoration: InputDecoration(
                  label: Text("Password",style: TextStyle(color: Colors.white),),
                  prefixIcon: Icon(Icons.lock,color:orange,),
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        iconVisibility = !iconVisibility;
                      });
                    },
                    icon:iconVisibility? Icon(Icons.visibility_off):Icon(Icons.visibility),
                    color: orange,
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
              SizedBox(height: 10.0,),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: InputDecoration(
                  label: Text('Phone',style: TextStyle(color: Colors.white),),
                  prefixIcon: Icon(Icons.phone,color:orange,),
                  border: OutlineInputBorder(),
                ),
                validator: (String? phone){
                  if(phone != null && phone.isEmpty){
                    return " phone can't be empty";
                  }
                  return null;
                },

              ),
              SizedBox(height: 15.0,),
              ConditionalBuilder(
                condition: state is! socialRegLoadingState ,
                fallback:(context) => Center(child: CircularProgressIndicator()),
                builder: (context) => Container(
                  width: double.infinity,
                  color: orange,
                  child: MaterialButton(
                      onPressed: (){
                        if(keyForm.currentState!.validate()){
                          socialRegCubit.getObject(context).userReg(
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                            userName: nameController.text,
                          );
                          print('Register success');
                        }else{
                          print("can\'t Register now");
                        }
                      },
                      child:Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 18.0,
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
                  Text(' Have an account?',style: TextStyle(color: Colors.white,
                  fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  TextButton(onPressed: (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context)=>loginScreen()),
                            (route) => false);
                  }, child: Text("Login",style: TextStyle(
                    color: orange,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,

                  ),)),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
