
import 'package:amazon/res/components/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/colors.dart';
import '../consts/fonts.dart';
import '../res/components/custom_button.dart';

class BookAppointmentView extends StatelessWidget {
  const BookAppointmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(title: "Doctor Name" , size: AppSizes.size18 ,
            color: AppColors.whiteColor),

      ),
      body: Padding(
        padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.bold(title: "Select Appointment day"),
            SizedBox(height: 5,),
            CustomTextField(hint: "select Day"),
            SizedBox(height: 10,),
            AppStyles.bold(title: "Select Appointment time"),
            SizedBox(height: 5,),
            CustomTextField(hint: "select time"),
            SizedBox(height: 20,),
            AppStyles.bold(title: "mobile number"),
            SizedBox(height: 5,),
            CustomTextField(hint: "enter your mobile"),
            SizedBox(height: 10,),
            AppStyles.bold(title: "Full Name"),
            SizedBox(height: 5,),
            CustomTextField(hint: "enter your name"),
            SizedBox(height: 10,),
            AppStyles.bold(title: "Message"),
            SizedBox(height: 5,),
            CustomTextField(hint: "Enter your Message"),

          ],
        ),
      ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(onTap: (){
        }, buttonText: "Book an appointment"),

      ),
    );
  }
}
