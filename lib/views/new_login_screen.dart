
import 'dart:async';

import 'package:amazon/consts/colors.dart';
import 'package:amazon/consts/fonts.dart';
import 'package:amazon/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/strings.dart';
import '../res/components/Custom_text_field_new.dart';
import '../res/components/custom_button.dart';
import '../res/components/custom_textfield.dart';
import 'new_home_screen.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({Key? key}) : super(key: key);

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/login_photo.jpg' , width: 300,),
              SizedBox(height: 10,),
              AppStyles.bold(title :AppStrings.welcomeBack , size: AppSizes.size18),
              AppStyles.bold(title :AppStrings.weAreExcited),
              SizedBox(height: 20,),
              // MyCustomTextField(
              //   hint: "Enter your email",
              //   onSave: (value){
              //
              //   }, icon: Icons.email,
              //
              // ),
              SizedBox(height: 10,),
              // MyCustomTextField(
              //   hint: "Enter your password",
              //   onSave: (value){
              //
              //   }, icon: Icons.email,
              //
              // ),
              SizedBox(height: 20,),
              Align(
                  alignment: Alignment.centerRight,
                  child: AppStyles.normal(title :AppStrings.forgetPassword)),
              SizedBox(height: 20,),
              // MyCustomTextField(
              //   hint: "Enter your password",
              //   onSave: (value){
              //
              //   }, icon: Icons.email,
              //
              // ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppStyles.normal(title: AppStrings.dontHaveAccount),
                  SizedBox(width: 8,),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SignupView());
                    },
                    child: AppStyles.bold(title: AppStrings.signup),
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
