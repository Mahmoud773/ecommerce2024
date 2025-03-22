
 import 'package:amazon/consts/fonts.dart';
import 'package:amazon/consts/lists.dart';
import 'package:amazon/controllers/auth_controller.dart';
import 'package:amazon/doctors/firestore_Repository/firetore_repository.dart';
import 'package:amazon/views/login_view.dart';
import 'package:amazon/views/patient/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consts/colors.dart';
import '../consts/strings.dart';
import '../models/booking_date_time_converter.dart';
import 'home.dart';

class SettingsView extends StatefulWidget {
  SharedPreferences? sharedPreferences;
    SettingsView({Key? key , this.sharedPreferences}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isDoctor=false;

  // SharedPreferences? prefs;
  // void initPrefs() async {
  //   prefs = await SharedPreferences.getInstance();
  //   isDoctor=prefs?.getBool("isDoctor") ?? false;
  //   print("isDoctor $isDoctor");
  // }
  // late userModel user;
  // void getCurrentUser() async {
  //   final result =await  FirebaseFirestore.instance.collection("users").doc("${
  //       FirebaseAuth.instance!.currentUser
  //   }").get();
  //   user=userModel.fromJson(result.data()!);
  //   print(user.email);
  // }
  @override
  void initState() {
    // getCurrentUser();
    super.initState();
    // initPrefs();
  }
   // bool isDoctor = false;
   // getfromShared() {
   //   isDoctor=  widget.sharedPreferences!.getBool("isDoctor")!;
   //   print("isDoctor $isDoctor");
   // }

   @override
   Widget build(BuildContext context) {

     final currentUser =FirebaseAuth.instance.currentUser;
     return Scaffold(
         appBar: AppBar(
           leading: IconButton(onPressed: (){
             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
               return Home();
             }));
           }, icon: Icon(Icons.arrow_back_ios)),
           elevation: 0.0,
           title: AppStyles.bold(title: AppStrings.settings , size: AppSizes.size18 ,
               color: Colors.white),

         ),
       body: Column(
         children: [
           StreamBuilder(
             stream:  FirebaseFirestore.instance.collection("users").
             doc("${currentUser!.uid}").snapshots(),
             builder: (context , snapshot){
               if(snapshot.connectionState == ConnectionState.waiting){
                 return Center(child: CircularProgressIndicator(),);
               }
               if(snapshot.hasData  ) {
                 // final doctorsList =snapshot!.data!.docs as List<DoctorModel>;
                 return ListTile(
                   leading: CircleAvatar(

                     radius: 30,
                     backgroundImage:NetworkImage("${snapshot.data!.data()!["pictureUrl"]}"),
                     backgroundColor: Colors.transparent,
                   ),
                   title: AppStyles.bold(title: "${snapshot.data!.data()!["name"]}"),
                   subtitle: AppStyles.normal(title: "${snapshot.data!.data()!["email"]}"),
                 );
               }
               if(snapshot.hasError){
                 return Center(child: Text("something went wrong"),);
               }

               else
                 return Center(child: Text("No Data yet"),);
             },
             // child: ListTile(
             //   leading: CircleAvatar(
             //     child:Image.network("${currentUser!.photoURL}") ,),
             //   title: AppStyles.bold(title: "${currentUser!.displayName}"),
             //   subtitle: AppStyles.normal(title: "${currentUser!.email}"),
             // ),
           ),
           Divider(),
           SizedBox(height: 20,),
           ListView(
             shrinkWrap: true,
             children: List.generate(SettingsList.length, (index) =>
           ListTile(
             onTap: ()async{
               if(index== 2)
                 {
                   await FirebaseAuth.instance.signOut().then((value) {
                     Navigator.of(context).pushReplacement(
                       MaterialPageRoute(builder: (context) {
                         return PatientLoginScreen(sharedPreferences: null,);
                       })
                     );

                   });
                 }
             },
             leading: Icon(SettingsListIcons[index] ,
             color: AppColors.primaryColor,),
             title: AppStyles.bold(title:SettingsList[index] ),
           )
           ),)

         ],
       )
     );
   }
}
