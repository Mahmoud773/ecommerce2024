
import 'dart:async';

import 'package:amazon/consts/colors.dart';
import 'package:amazon/consts/fonts.dart';
import 'package:amazon/views/login_view.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginView();
      }));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    return Container(
      width:width ,
      height: height,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
          AppColors.primaryColor.withOpacity(0.8),

          AppColors.primaryColor,

        ],
          begin: Alignment.topCenter,
          end:Alignment.bottomCenter,
        )
      ),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(20) ,
            child: Image.asset("assets/images/doctors.png"),
          ) ,
          SizedBox(height: 50,),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 35 ,
              fontWeight: FontWeight.w500,
              color: Colors.white,

            ),
            child: Text('Healthy Care'),
          ),
          // Text('Healthy Care' , style: TextStyle(
          //   fontSize: 35 ,
          //   fontWeight: FontWeight.bold,
          //   color: Colors.white,
          //   letterSpacing: 1,
          //   wordSpacing: 2
          // ),),
          SizedBox(height: 10,),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 18 ,
              fontWeight: FontWeight.w500,
              color: Colors.white,

            ),
            child: Text('Appoint your Doctor'),
          ),
          // Text('Appoint your Doctor' ,
          //   style: TextStyle(
          //     fontSize: 18 ,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.white,
          //
          // ),
          //    ),
          SizedBox(height: 60,),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child:InkWell(
              onTap: () {},
              child:Text('Lets Go' ,
                style: TextStyle(
                  fontSize: 22 ,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,

                ),
              ),
            ) ,
          ),
          SizedBox(height: 60,),
          Image.asset("assets/images/lined heart.png" ,
          scale: 2 ,
           color: Colors.white,)






        ],
      ),
    );
  }
}
