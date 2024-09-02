import 'package:amazon/views/patient/firebasere_pository/patient_firebase_repository.dart';
import 'package:amazon/views/patient_appintment_view.dart';
import 'package:amazon/views/category_view.dart';
import 'package:amazon/views/home_view.dart';
import 'package:amazon/views/new_home_screen.dart';
import 'package:amazon/views/settings_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/Fcm_notifications_api.dart';

class Home extends StatefulWidget {
  SharedPreferences? sharedPreferences;
   Home({Key? key , this.sharedPreferences}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void getTokenandUploadtoUser() async{
    final currentuser= FirebaseAuth.instance.currentUser;
    final _firebaseMessaging=FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission();
    _firebaseMessaging.subscribeToTopic("doctors");
    final fcmToken=await _firebaseMessaging.getToken();
    await FirebaseFirestore.instance.
    collection("patientsDevicesToken").doc("${currentuser}").set({"deviceToken":fcmToken});
  }

  @override
  void initState() {
    super.initState();
    getTokenandUploadtoUser();
  }
  int selectedIndex=0;
  List screenList=[
    NewHomeScreen(),
    AppointmentView(doctorId: ""),
    CategoryView(),
    Container(color: Colors.red,),
    SettingsView(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(
          color: Colors.white 
        ),
        selectedIconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap:(value) {
            setState(() {
              selectedIndex=value;
            });
          },
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.home) , label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.book) , label: "Appointments"),
            BottomNavigationBarItem(icon: Icon(Icons.category ), label: "Category"),
        BottomNavigationBarItem(icon: Icon(Icons.person) , label: "Doctor"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ]),
    );
  }
}
