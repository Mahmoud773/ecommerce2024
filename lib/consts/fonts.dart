
import 'package:amazon/consts/colors.dart';
import 'package:flutter/material.dart';

class AppSizes {
  static const size12=12.0 , size14=14.0 ,size16=16.0 ,size18=18.0 ,size20=20.0 ,size22=22.0 ,size24=24.0 ,
      size34=34.0;
}

class AppStyles{
  static  normal({String? title , Color? color=Colors.black , double? size =14 ,
    TextAlign alignment= TextAlign.left  }){
    return Text('$title' , style: TextStyle(fontSize: size ,color: color));
  }

  static  bold({String? title , Color? color=Colors.black , double? size =14 ,
    TextAlign alignment= TextAlign.left }){
    return Text('$title' , style: TextStyle(
      fontSize: size ,color: color ,
        fontWeight: FontWeight.bold  , ),
    textAlign: alignment,);
  }


}