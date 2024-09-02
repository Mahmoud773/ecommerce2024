

import 'package:amazon/consts/fonts.dart';
import 'package:amazon/consts/strings.dart';
import 'package:amazon/controllers/auth_controller.dart';
import 'package:amazon/res/components/custom_button.dart';
import 'package:amazon/res/components/custom_textfield.dart';
import 'package:amazon/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Container(

        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset('assets/images/login_photo.jpg' , width: 200,),
                SizedBox(height: 10,),
                AppStyles.bold(title :AppStrings.signupNow , size: AppSizes.size18 , alignment: TextAlign.center),
              ],
            ),
            SizedBox(height: 30,),
            Expanded(
              child: Form(child:
              SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      hint: AppStrings.fullName,
                      textController: controller.fullnameControler,
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      hint: AppStrings.email,
                      textController: controller.emailControler,

                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      hint: AppStrings.password,
                      textController: controller.passwordControler,

                    ),
                    SizedBox(height: 5,),
                    Align(
                        alignment: Alignment.centerRight,
                        child: AppStyles.normal(title :AppStrings.forgetPassword)),
                    SizedBox(height: 20,),
                    CustomButton(
                      buttonText: AppStrings.signup , onTap: () async{
                        await controller.signupUser();
                        if(controller.userCredential != null){
                          Get.offAll(() => Home());
                        }
                    },
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(title: AppStrings.AlreadyHaveAccount),
                        SizedBox(width: 8,),
                        GestureDetector(
                          onTap: () {
                            Get.back;
                          },
                          child: AppStyles.bold(title: AppStrings.login),
                        )

                      ],
                    )
                  ],
                ),
              )
              ),


            )
          ],
        ),
      ),
    );
  }
}
