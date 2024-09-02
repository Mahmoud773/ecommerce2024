
import 'package:amazon/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/fonts.dart';

class CategoryDetailsView extends StatelessWidget {
  const CategoryDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(title: "Category Name" , size: AppSizes.size18 ,
            color: AppColors.whiteColor),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2  ,
        crossAxisSpacing: 8 ,
        mainAxisExtent: 170 ,
        mainAxisSpacing: 8),
            itemCount: 10,
            itemBuilder: (context , int index) {
          return Container(
            color: AppColors.bgDarkColor,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.only(right: 8),
            height:100 ,
            width: 150,
            child: Column(
              children: [
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: Image.asset("assets/images/doctor1.png" ,
                    width: 100,fit: BoxFit.cover,),
                ),
                SizedBox(height: 5,),
                AppStyles.normal(title: "Doctor Name"),
                SizedBox(height: 5,),
                // VxRating(onRatingUpdate: (value) {} ,
                //   selectionColor: AppColors.yellowColor,
                //   maxRating: 5,
                //   count: 5,
                //   value: 4,
                //   stepInt: true,
                // ),
              ],
            ),
          ) ;
            }),
      ),
    );
  }
}
