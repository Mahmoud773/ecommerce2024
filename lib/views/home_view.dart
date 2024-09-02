
import 'package:amazon/consts/colors.dart';
import 'package:amazon/consts/fonts.dart';
import 'package:amazon/consts/lists.dart';
import 'package:amazon/consts/strings.dart';
import 'package:amazon/res/components/custom_textfield.dart';
import 'package:amazon/views/doctor_profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          children: [
            AppStyles.bold(title: "${AppStrings.welcome} User" ,color:Colors.white ,
            size: AppSizes.size18)
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(14),
            color: Colors.blue,
            child:Row(
              children: [
                Expanded(
                  child: CustomTextField(hint: AppStrings.search ,
                    borderColor: Colors.white,
                  textColor: Colors.white,),
                ),
                SizedBox(height: 10,),
                IconButton(onPressed: () {},
                    icon: Icon(Icons.search , color: Colors.white,))
              ],
            ) ,
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                      itemBuilder: (context , int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                               borderRadius: BorderRadius.circular(12),
                          ),
                          padding:  EdgeInsets.all(14),
                          margin: EdgeInsets.only(right: 8),
                          child: Column(
                            children: [
                              Image.asset(IconsList[index] , width: 30, color: Colors.white,),
                              SizedBox(height: 5,),
                              AppStyles.normal(title: IconsTitleList[index] , color: Colors.white)
                            ],
                          ),
                        ),
                      );
                      }),
                ),
                SizedBox(height: 20,),
                Align(alignment: Alignment.centerLeft,child:
                AppStyles.bold(title: "Popular Doctors" , color: Colors.blue,
                    size: AppSizes.size18),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context , int index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to( () => DoctorPrifileView());
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.bgDarkColor,
                            ),
                            margin: EdgeInsets.only(right: 8),
                            height:100 ,
                            width: 150,
                            child: Column(
                              children: [
                                Container(
                                  width: 150,
                                  alignment: Alignment.center,
                                  // color: Colors.blue,
                                  child: Image.asset("assets/images/doctor1.png" ,
                                    width: 100, fit: BoxFit.cover,),
                                ),
                                SizedBox(height: 5,),
                                AppStyles.normal(title: "Doctor Name"),
                                SizedBox(height: 5,),
                                AppStyles.normal(title: "Category" , color: Colors.black54),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(height: 5,),
                GestureDetector(
                  onTap: () {},
                  child: Align(alignment: Alignment.topCenter,
                  child: AppStyles.normal(title:  "View All" , color: Colors.blue),),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) =>
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12)),

                      child: Column(
                        children: [
                          Image.asset('assets/icons/body.png' , width: 25, color: Colors.white,),
                          SizedBox(height: 5,),
                          AppStyles.normal(title: "Lab Test" ,color: Colors.white, ),
                        ],
                      ),
                    )
                ),
                ),
              ],
            ),
          ) ,
        ],
      ),
    );
  }
}
