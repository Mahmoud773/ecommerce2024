

import 'package:amazon/Facility_Manager/Home_with_bottomBar_Screenr.dart';
import 'package:amazon/Facility_Manager/customer_repository/customer_auth.dart';
import 'package:amazon/Facility_Manager/facility_home_screen.dart';
import 'package:amazon/doctors/service/doctor_Auth.dart';
import 'package:amazon/services/auth.dart';
import 'package:amazon/views/Doctor_new_Details.dart';
import 'package:amazon/views/settings_view.dart';
import 'package:amazon/widgets/user_image_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/fonts.dart';
import 'dart:io';
import '../../consts/strings.dart';
import '../../res/components/Custom_text_field_new.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../operators/operators_home_screen.dart';
import '../operators/operators_home_screen2.dart';
import '../operators/operators_home_screen_3.dart';

class CustomerSignUpScreen extends StatefulWidget {
  SharedPreferences? sharedPreferences;
  CustomerSignUpScreen({Key? key ,required this.sharedPreferences}) : super(key: key);

  @override
  State<CustomerSignUpScreen> createState() => _CustomerSignUpScreenState();
}

class _CustomerSignUpScreenState extends State<CustomerSignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth=CustomerAuth();
  final _doctorAuth=CustomerAuth();
  bool _saving = false;
  File? _selectedImage;
  String name='';
  String email='';
  String password='';
  String Category = '';
  String experience='';
  bool isDoctor=false;

  SharedPreferences? prefs;
  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  String deviceToken="";
  void setupFcmNotifications() async{
    final fcm= FirebaseMessaging.instance;
    await fcm.requestPermission();
    deviceToken=(await fcm.getToken())!;
    fcm.subscribeToTopic("fm");

  }


  @override
  void initState() {
    super.initState();
    initPrefs();
    setupFcmNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return  Scaffold(
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
                  SizedBox(height: 10,),
                  Container(
                    width:double.infinity*90/100,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/FMimages/catalyst.jpg'),
                            fit: BoxFit.cover
                        )
                    ),
                    //child: Image.asset('assets/images/fm2.jpg'),
                  ),
                  SizedBox(height: 10,),
                  AppStyles.bold(title :AppStrings.welcomeBack , size: AppSizes.size18),
                  SizedBox(height: 5,),
                  AppStyles.bold(title :AppStrings.weAreExcited),
                  SizedBox(height: 20,),
                  UserImagePicker(onPickImage: (pickedImage){
                    _selectedImage=pickedImage;
                  }),
                  SizedBox(height: 10,),
                  MyCustomTextField(onSave: (String? value){
                    name=value!;
                  },
                    icon: Icons.person, hint: "enter your name",
                   // iconColor: Colors.white,
                    validator: (String? value){
                      if(value == null ||value.isEmpty){
                        return "please enter valid name";
                      }
                    },),
                  SizedBox(height: 10,),
                  MyCustomTextField(onSave: (String? value){
                    email=value!;
                  }, icon: Icons.email, hint: "enter your email",
                    validator: (String? value){
                      if(value == null ||value.isEmpty){
                        return "please enter valid email";
                      }
                    },),
                  SizedBox(height: 10,),
                  MyCustomTextField(
                    obsecureText: true,
                    hint: "Enter your password",
                    onSave: (String? value){
                      password=value!;
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
                          if(isDoctor){
                            if(_formKey!.currentState!.validate()){
                              _saving=true;
                              setState(() {

                              });
                              _formKey.currentState!.save();
                              try{
                                final authResult= await  _doctorAuth.signUp(email: email.trim(),
                                    password:  password.trim(),fullName: name.trim() ,
                                    Category: Category.trim(),
                                    experience: "" ,imageFile: _selectedImage!
                                    ,isDoctor:  isDoctor ,deviceToken: deviceToken);
                                final prefs=await SharedPreferences.getInstance();
                                prefs.setBool("isDoctor", true);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context){
                                      return FMHomeBarscreen() ;
                                    }));
                              }catch(e){
                                _saving=false;
                                setState(() {

                                });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  // behavior: SnackBarBehavior.floating,
                                  // shape: RoundedRectangleBorder(
                                  //   side: BorderSide(color: Colors.amberAccent, width: 2),
                                  //   borderRadius: BorderRadius.circular(24),
                                  // ),
                                  // backgroundColor: Colors.amberAccent,
                                  duration: Duration(milliseconds: 2000),
                                  // dismissDirection: DismissDirection.up,
                                  content: Text("${e.toString()}"
                                    , style: TextStyle(color: Colors.white),) ,
                                ));
                              }
                            }
                          }if(isDoctor==false){
                            if(_formKey!.currentState!.validate()){
                              _saving=true;
                              setState(() {

                              });
                              _formKey.currentState!.save();
                              try{
                                final authResult= await  _auth.signUp(email: email.trim(),
                                    password:  password.trim(),fullName: name.trim() ,
                                    Category: Category.trim(),
                                    experience: experience.trim() ,imageFile: _selectedImage!
                                    ,isDoctor:  isDoctor ,deviceToken: deviceToken);
                                final prefs=await SharedPreferences.getInstance();
                                prefs.setBool("isDoctor", false);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context){
                                      return OperatorsHomeWithTabBar3();
                                        //OperatorsHomeScreen22() ;
                                    }));
                              }on FirebaseAuthException catch(error){
                                _saving=false;
                                setState(() {

                                });
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(

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

                          }
                        } ,
                        child: Text("Sign Up" , style: TextStyle(
                            color: Colors.white
                        ),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.black,
                      );
                    },
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Are You a Unit Owner'),
                      Checkbox(value: isDoctor,
                          activeColor: Colors.amber,

                          onChanged: (value){
                            setState(() {
                              isDoctor=value!;
                            });
                          }),
                    ],
                  ),
                  SizedBox(height: 10,),
                  isDoctor
                      ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyCustomTextField(
                        onSave: (String? value){
                          Category=value!;
                        },
                        icon: Icons.category, hint: "unit Number",
                        validator:
                            (String? value){
                          if(value == null ||value.isEmpty){
                            return "please enter valid value";
                          }
                        },),
                      SizedBox(height: 10,),
                      // MyCustomTextField(onSave:
                      //     (String? value){
                      //   experience=value!;
                      // }, icon: Icons.numbers,
                      //   hint: "enter your experience",
                      //   validator: (String? value){
                      //     if(value == null ||value.isEmpty){
                      //       return "please enter valid value";
                      //     }
                      //   },),
                    ],)
                      :
                  Container(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Do have an account ? ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: Text("Login" , style: TextStyle(
                            color: Colors.white
                        ),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.black,
                      )
                    ],
                  ) ,
                  SizedBox(height: 10,)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
