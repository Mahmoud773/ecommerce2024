
import 'package:amazon/views/patient/sigb_up.dart';
import 'package:amazon/views/settings_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/fonts.dart';
import '../../consts/strings.dart';

import 'package:amazon/services/auth.dart';
import '../../res/components/Custom_text_field_new.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../home.dart';

class PatientLoginScreen extends StatefulWidget {
  SharedPreferences? sharedPreferences;
   PatientLoginScreen({Key? key , required this.sharedPreferences}) : super(key: key);

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth=Auth();
  bool _saving = false;
  String name='';
  String email='';
  String password='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/login_photo.jpg' , width: 300,),
                  SizedBox(height: 10,),
                  AppStyles.bold(title :AppStrings.welcomeBack , size: AppSizes.size18),
                  SizedBox(height: 5,),
                  AppStyles.bold(title :AppStrings.weAreExcited),
                  SizedBox(height: 20,),
                  MyCustomTextField(onSave: (String? value){
                    email=value!;
                  }, icon: Icons.email, hint: "enter your email" ,
                    validator: (String? value){
                      if(value == null ||value.isEmpty){
                        return "please enter valid email";
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                  MyCustomTextField(
                    obsecureText: true,
                    hint: "Enter your password",
                    onSave: (String? value){
                     password =value!;
                    },
                    validator: (String? value){
                      if(value == null ||value.isEmpty || value.length <6){
                        return "password must be not less than 6 characters or numbers ";
                      }
                    },
                    icon: Icons.email,

                  ),
                  SizedBox(height: 10,),

                  Builder(
                    builder: (context){
                      return MaterialButton(
                        onPressed: () async{

                          if(_formKey!.currentState!.validate()){
                            _saving=true;
                            setState(() {

                            });
                            _formKey.currentState!.save();
                            try{
                              final authResult= await  _auth.signIn(email.trim(), password.trim());
                             final prefs=await SharedPreferences.getInstance();
                             final isDoctor= prefs.getBool("isDoctor");
                             if(isDoctor !=null){
                               isDoctor? Navigator.pushReplacement(context,
                                   MaterialPageRoute(builder: (context){
                                     return SettingsView( sharedPreferences: null,) ;
                                   })):
                               Navigator.pushReplacement(context,
                                   MaterialPageRoute(builder: (context){
                                     return Home(sharedPreferences: widget.sharedPreferences,) ;
                                   }));
                             }else Navigator.pushReplacement(context,
                                 MaterialPageRoute(builder: (context){
                                   return Home(sharedPreferences: widget.sharedPreferences,) ;
                                 }));

                            }on FirebaseAuthException catch(error){
                              _saving=false;
                              setState(() {

                              });
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                // behavior: SnackBarBehavior.floating,
                                // shape: RoundedRectangleBorder(
                                //   side: BorderSide(color: Colors.amberAccent, width: 2),
                                //   borderRadius: BorderRadius.circular(24),
                                // ),
                                // backgroundColor: Colors.amberAccent,
                                duration: Duration(milliseconds: 3000),
                                // dismissDirection: DismissDirection.up,
                                content: Text("${error.message.toString()}"
                                  , style: TextStyle(color: Colors.white),) ,
                              ));
                            }
                            catch(e){
                              _saving=false;
                              setState(() {

                              });
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                // behavior: SnackBarBehavior.floating,
                                // shape: RoundedRectangleBorder(
                                //   side: BorderSide(color: Colors.amberAccent, width: 2),
                                //   borderRadius: BorderRadius.circular(24),
                                // ),
                                // backgroundColor: Colors.amberAccent,
                                duration: Duration(milliseconds: 3000),
                                // dismissDirection: DismissDirection.up,
                                content: Text("${e.toString()}"
                                  , style: TextStyle(color: Colors.white),) ,
                              ));
                            }
                          }
                        } ,
                        child: Text("Login" , style: TextStyle(
                            color: Colors.white
                        ),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.black,
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account ? ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_){
                            return PatientSignUpScreen(sharedPreferences: widget.sharedPreferences,);
                          }));
                        },
                        child: Text(
                          'Signup',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
