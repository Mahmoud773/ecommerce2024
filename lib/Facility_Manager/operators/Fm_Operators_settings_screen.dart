

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/colors.dart';
import '../../consts/fonts.dart';
import '../../consts/lists.dart';
import '../../consts/strings.dart';
import '../login_and_signup_screens/Facility_customer_login_screen.dart';
import 'operators_home_screen_3.dart';

class FMOperatorsSettingsView extends StatefulWidget {
  SharedPreferences? sharedPreferences;
  FMOperatorsSettingsView({Key? key , this.sharedPreferences}) : super(key: key);

  @override
  State<FMOperatorsSettingsView> createState() => _FMOperatorsSettingsViewState();
}

class _FMOperatorsSettingsViewState extends State<FMOperatorsSettingsView> {
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
              return OperatorsHomeWithTabBar3();
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
                                return CustomerLoginScreen(sharedPreferences: null,);
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
