import 'package:amazon/Facility_Manager/customer_repository/customer_firestore_repository.dart';
import 'package:amazon/Facility_Manager/models/Customer_model.dart';
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
import 'Fm_settings_screen.dart';
import 'My_Problems_screen.dart';
import 'facility_home_screen.dart';
import 'my_problems222222.dart';

class FMHomeBarscreen extends StatefulWidget {
  SharedPreferences? sharedPreferences;
  FMHomeBarscreen({Key? key , this.sharedPreferences}) : super(key: key);

  @override
  State<FMHomeBarscreen> createState() => _FMHomeBarscreenState();
}

class _FMHomeBarscreenState extends State<FMHomeBarscreen> {

  CustomerModel customerModel=CustomerModel(id: "", email: "");
  final currentuser= FirebaseAuth.instance.currentUser;
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


  @override
  Widget build(BuildContext context) {
    List screenList=[
      FacilityHomeScreen(),
      MyProblemsScreen2222222222222(doctorId: ""),
      // CategoryView(),
      // Container(color: Colors.red,),
      FMSettingsView(),
    ];
    String uid =currentuser!.uid ;
    print(uid);
    return StreamBuilder(
      stream: CustomersFirestoreRpository.getCertaincustomerAsStream(uid, true),
      builder: (context, snapshot) {

        // if(snapshot.hasData ){
        //   customerModel =CustomerModel.fromJson(snapshot.data!.data()!);
        // }
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
              backgroundColor: Colors.grey[800],
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              onTap:(value) {
                setState(() {
                  selectedIndex=value;
                });
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home) , label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.book) , label: "My orders"),
                // BottomNavigationBarItem(icon: Icon(Icons.category ), label: "Category"),
                // BottomNavigationBarItem(icon: Icon(Icons.person) , label: "Doctor"),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
              ]),
        );
      }
    );
  }
}
