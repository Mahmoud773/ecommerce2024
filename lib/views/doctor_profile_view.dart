
import 'package:amazon/consts/colors.dart';
import 'package:amazon/res/components/custom_button.dart';
import 'package:amazon/views/book_appointment_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/fonts.dart';
import '../consts/strings.dart';

class DoctorPrifileView extends StatelessWidget {
  const DoctorPrifileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(title: "Doctor Name" , size: AppSizes.size18 ,
            color: Colors.white),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius:40,
                      child: Image.asset("assets/images/doctor1.png"),),
                    SizedBox(height: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        AppStyles.bold(title: "Doctor Name" , size: AppSizes.size14 ,
                            color: AppColors.textColor),
                        AppStyles.bold(title: "Category" , size: AppSizes.size12 ,
                            color: AppColors.textColor.withOpacity(0.5)) ,
                        Spacer(),
                        // VxRating(onRatingUpdate: (value) {} ,
                        //   selectionColor: AppColors.yellowColor,
                        //   maxRating: 5,
                        // count: 5,
                        //   value: 4,
                        //   stepInt: true,
                        // )
                      ],
                      ),
                    ),
                    AppStyles.bold(title: "See all reviews" , size: AppSizes.size12 ,
                        color:AppColors.primaryColor),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: AppStyles.bold(title: "Phone Number" , color: AppColors.textColor),
                      subtitle: AppStyles.normal(title: "+1111111111" , color: AppColors.textColor.withOpacity(0.5),
                      size: AppSizes.size12),
                      trailing: Container(
                        width: 50,
                        padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.yellowColor
                          ),
                          child: Icon(Icons.phone , color: AppColors.whiteColor,)),

                    ),
                    SizedBox(height: 10,),
                    AppStyles.bold(title: "About" , color: AppColors.textColor , size: AppSizes.size16),
                    SizedBox(height: 5,),
                    AppStyles.normal(title: "This is about section of Doctor" , color: AppColors.textColor.withOpacity(0.5) ,
                        size: AppSizes.size12),
                    SizedBox(height: 10,),
                    AppStyles.bold(title: "Address" , color: AppColors.textColor , size: AppSizes.size16),
                    SizedBox(height: 5,),
                    AppStyles.normal(title: "Address of Doctor" , color: AppColors.textColor.withOpacity(0.5) ,
                        size: AppSizes.size12),
                    SizedBox(height: 10,),
                    AppStyles.bold(title: "Working Time" , color: AppColors.textColor , size: AppSizes.size16),
                    SizedBox(height: 5,),
                    AppStyles.normal(title: "9:00 AM To 12:00 pm" , color: AppColors.textColor.withOpacity(0.5) ,
                        size: AppSizes.size12),
                    SizedBox(height: 10,),
                    AppStyles.bold(title: "Services" , color: AppColors.textColor , size: AppSizes.size16),
                    SizedBox(height: 5,),
                    AppStyles.normal(title: "This is the service section of doctor" , color: AppColors.textColor.withOpacity(0.5) ,
                        size: AppSizes.size12),


                  ],
                ),
              )
            ],
          ),

        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(onTap: (){
          Get.to(()=> BookAppointmentView());
        }, buttonText: "Book an appointment"),
      ),
    );
  }
}
