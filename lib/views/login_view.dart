

import 'package:amazon/consts/fonts.dart';
import 'package:amazon/consts/strings.dart';
import 'package:amazon/controllers/auth_controller.dart';
import 'package:amazon/res/components/custom_button.dart';
import 'package:amazon/res/components/custom_textfield.dart';
import 'package:amazon/views/home_view.dart';
import 'package:amazon/views/new_home_screen.dart';
import 'package:amazon/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/components/Custom_text_field_new.dart';
import 'home.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
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
            //    MyCustomTextField(
            //   hint: "Enter your email",
            //   onSave: (value){
            //
            //   },
            //      onValidate: (String value){
            //       if(value == null ||value.isEmpty){
            //         return "please enter valid email";
            //       }
            //      },
            //      icon: Icons.email,
            //
            // ),
            SizedBox(height: 10,),
            //   MyCustomTextField(
            //     obsecureText: true,
            //   hint: "Enter your password",
            //   onSave: (value){
            //
            //   },
            //     onValidate: (String value){
            //       if(value == null ||value.isEmpty || value.length <6){
            //         return "password must be not less than 6 characters or numbers ";
            //       }
            //     },
            //     icon: Icons.email,
            //
            // ),
            SizedBox(height: 20,),
            Align(
                alignment: Alignment.centerRight,
                child: AppStyles.normal(title :AppStrings.forgetPassword)),
            SizedBox(height: 20,),
            CustomButton(
              buttonText: AppStrings.login , onTap: () async {
              await controller.login();
              if(controller.userCredential !=null)
                Get.to(() => Home());
              // NewHomeScreen());
            },
            ),
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
