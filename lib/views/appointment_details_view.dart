
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../consts/fonts.dart';
import '../res/components/custom_textfield.dart';

class AppointmentDetailsView extends StatelessWidget {
  const AppointmentDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(title: "Doctor Name" , size: AppSizes.size18 ,
            color: AppColors.whiteColor),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.bold(title: "Select Appointment day"),
            SizedBox(height: 5,),
            AppStyles.normal(title: "Selected Day"),
            SizedBox(height: 10,),
            AppStyles.bold(title: "Select Appointment time"),
            SizedBox(height: 5,),
            AppStyles.normal(title: "Selected time"),
            SizedBox(height: 20,),
            AppStyles.bold(title: "mobile number"),
            SizedBox(height: 5,),
            AppStyles.normal(title: "mobile number"),
            SizedBox(height: 10,),
            AppStyles.bold(title: "Full Name"),
            SizedBox(height: 5,),
            AppStyles.bold(title: "Full Name"),
            SizedBox(height: 10,),
            AppStyles.bold(title: "Message"),
            SizedBox(height: 5,),
            AppStyles.normal(title: "Message"),
          ],
        ),
      ),
    );
  }
}
