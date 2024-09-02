
import 'package:amazon/consts/colors.dart';
import 'package:amazon/consts/fonts.dart';
import 'package:amazon/consts/lists.dart';
import 'package:amazon/consts/strings.dart';
import 'package:amazon/views/category_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(title: AppStrings.category , size: AppSizes.size18 ,
            color: Colors.white),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            mainAxisExtent: 170,
          ),
          itemCount: IconsList.length,
          itemBuilder: (context , int index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => CategoryDetailsView());
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                        child: Image.asset(IconsList[index] ,
                          // color:  Vx.randomPrimaryColor,
                          width: 60,)) ,

                    Divider(
                      color:Colors.white ,
                    ),
                    SizedBox(height: 30,),
                    AppStyles.bold(title: IconsTitleList[index] , color: AppColors.textColor ,
                        size: AppSizes.size16),
                    SizedBox(height: 10,),
                    AppStyles.normal(title: "13 Specialists", color: AppColors.textColor.withOpacity(0.5) ,
                        size: AppSizes.size12),

                  ],
                ),
              ),
            );
          },


        ),
      ),
    );
  }
}
