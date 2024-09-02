

import 'package:amazon/Facility_Manager/customer_repository/customer_firestore_repository.dart';
import 'package:amazon/Facility_Manager/login_and_signup_screens/signUp.dart';
import 'package:amazon/Facility_Manager/operators/operators_home_screen_3.dart';
import 'package:amazon/models/booking_date_time_converter.dart';
import 'package:amazon/views/patient/sigb_up.dart';
import 'package:amazon/views/settings_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../consts/fonts.dart';
import '../../../consts/strings.dart';

import 'package:amazon/services/auth.dart';
import '../../../res/components/Custom_text_field_new.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Home_with_bottomBar_Screenr.dart';
import '../customer_repository/customer_auth.dart';
import '../facility_home_screen.dart';
import '../models/Customer_model.dart';
import '../models/booking_date_time_converter.dart';
import '../operators/operators_home_screen.dart';
import '../operators/operators_home_screen2.dart';
import '../widgets/admins/admin_follow.dart';


class CustomerLoginScreen extends StatefulWidget {
  SharedPreferences? sharedPreferences;
  CustomerLoginScreen({Key? key , required this.sharedPreferences}) : super(key: key);

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {


  UserModel userModel=UserModel(id: '', name: '', isDoctor: false, pictureUrl: '', email: '');

  final  user = FirebaseAuth.instance.currentUser;
 // final String userId = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth=CustomerAuth();
  bool _saving = false;
  String name='';
  String email='';
  String password='';

  bool isAdmin = false;



  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
   String uid = "";

    return Scaffold(

      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                height: height,
                 decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.grey.withOpacity(.6),
                          Colors.grey.withOpacity(.2),
                        ]
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(flex: 5,
                      child: Container(
                        width:double.infinity*90/100,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage('assets/FMimages/catalyst.jpg'),
                                fit: BoxFit.cover
                            )
                        ),
                         //child: Image.asset('assets/images/fm2.jpg'),
                      ),
                    ),
                   // Image.asset('assets/images/login_photo.jpg' , width: 300,),
                    SizedBox(height: 30,),
                    Flexible(flex:1 ,child: AppStyles.bold(title :AppStrings.welcomeBack , size: AppSizes.size18)),
                    SizedBox(height: 5,),
                    Flexible(flex:1,child: AppStyles.bold(title :AppStrings.weAreExcited)),
                    SizedBox(height: 20,),
                    Flexible(flex: 1,
                      child: MyCustomTextField(onSave: (String? value){
                        email=value!;
                      }, icon: Icons.email, hint: "enter your email" ,
                        validator: (String? value){

                          if(value == null ||value.isEmpty){
                            if(isAdmin==true){
                              if(value!.trim() !="admin@test.com"){
                                return "wrong admin email";
                              }
                            }if(isAdmin==false)
                            {
                              if(value == null ||value.isEmpty || value.length <6){
                                return "password must be not less than 6 characters or numbers ";
                              }
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Flexible(flex: 1,
                      child: MyCustomTextField(

                        obsecureText: true,
                        hint: "Enter your password",
                        onSave: (String? value){
                          password =value!;
                        },
                        validator: (String? value){
                          if(isAdmin==true){
                            if(value!.trim() !="123456"){
                              return "wrong admin password";
                            }
                          }if(isAdmin==false)
                         {
                           if(value == null ||value.isEmpty || value.length <6){
                             return "password must be not less than 6 characters or numbers ";
                           }
                         }
                        },
                        icon: Icons.email,

                      ),
                    ),
                    SizedBox(height: 10,),

                    Flexible(flex: 1,
                      child: MaterialButton(
                        onPressed: () async{

                          if(_formKey!.currentState!.validate()){
                            _saving=true;
                            setState(() {

                            });
                            _formKey.currentState!.save();
                            try{
                              if(isAdmin){

                                final authResult= await  _auth.signIn(email.trim(), password.trim()).
                                then((value) async{
                                  if (value!=null){
                                    uid=value.user!.uid;
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context){
                                          return AdminFollowScreen();
                                          //OperatorsHomeScreen22() ;
                                        }));
                                  }
                                });
                              }
                            if(isAdmin==false){
                              final authResult= await  _auth.signIn(email.trim(), password.trim()).
                              then((value) async{
                                if (value!=null){
                                  uid=value.user!.uid;
                                  final result =await FirebaseFirestore.instance.collection("users").doc(uid).get() ;
                                  userModel=UserModel.fromJson(result.data()!);
                                }
                              });

                              // final prefs=await SharedPreferences.getInstance();
                              // final isDoctor= prefs.getBool("isDoctor");
                              // if(isDoctor !=null){
                              //   isDoctor? Navigator.pushReplacement(context,
                              //       MaterialPageRoute(builder: (context){
                              //         return SettingsView( sharedPreferences: null,) ;
                              //       })):
                              //   Navigator.pushReplacement(context,
                              //       MaterialPageRoute(builder: (context){
                              //         return Home(sharedPreferences: widget.sharedPreferences,) ;
                              //       }));
                              // }else Navigator.pushReplacement(context,
                              //     MaterialPageRoute(builder: (context){
                              //       return Home(sharedPreferences: widget.sharedPreferences,) ;
                              //     }));
                              if(userModel.isDoctor==false){
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context){
                                      return OperatorsHomeWithTabBar3();
                                      //OperatorsHomeScreen22() ;
                                    }));
                              }
                              if(userModel.isDoctor==true){
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context){
                                      return FMHomeBarscreen() ;
                                    }));
                              }
                            }

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
                                content: Text(e.toString()
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
                      ),
                    ),
                    Flexible(flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Are You admin"),
                        Checkbox(value: isAdmin, onChanged: (val){
                          setState(() {
                            isAdmin=val!;
                          });
                        }),
                      ],),
                    ),
                    SizedBox(height: 10,),
                    Flexible(flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Don\'t have an account ? ',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                return CustomerSignUpScreen(sharedPreferences: widget.sharedPreferences,);
                              }));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.black,
                            child: Text(
                              'Signup',
                              style: TextStyle(fontSize: 16 , color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
