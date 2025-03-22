
import 'dart:async';

import 'package:flutter/material.dart';

import 'login_and_signup_screens/Facility_customer_login_screen.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);


  @override
  State<SplachScreen> createState() => _SplachScreenState();


}
class _SplachScreenState extends State<SplachScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return CustomerLoginScreen(sharedPreferences: null,);
      }));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(child:
        Image.asset('assets/FMimages/catalyst.jpg' ,width: 350 , height: 350,),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}