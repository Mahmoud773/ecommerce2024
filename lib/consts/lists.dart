import 'package:amazon/consts/colors.dart';
import 'package:amazon/consts/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppAssets{
  static const ear="assets/icons/body.png" ,
  liver ="assets/icons/liver.png",
  heart="assets/icons/heart.jpg",
  eye="assets/icons/eye.png",
  body ="assets/icons/body.png";
}
var IconsList=[
  AppAssets.ear ,
  AppAssets.liver,
  AppAssets.heart ,
  AppAssets.eye ,
  AppAssets.body ,


];
var IconsTitleList=[
  "ear" ,
  "liver",
  "eye" ,
  "heart" ,
  "eye" ,
  "body" ,

];
var SettingsList=[
  AppStrings.changePassword,
  AppStrings.termsConditionns,
  AppStrings.signout,

];
var SettingsListIcons=[
  Icons.lock,
Icons.note,
Icons.logout,

];

List DoctorsImages=[
  "assets/images/doctor11.jpg",
  "assets/images/doctor22.jpg",
  "assets/images/doctor33.jpg",
  "assets/images/doctor44.jpg",
];

List CategoriesNamesList=[
  "Dental" ,
  "Heart",
  "Eye",
  "Brain",
  "Ear",
];
List<Icon> CategoriesIconsList=[
Icon(MdiIcons.toothOutline, color: AppColors.primaryColor , size: 30,),
  Icon(MdiIcons.heart, color: AppColors.primaryColor , size: 30,),
  Icon(MdiIcons.eye, color: AppColors.primaryColor , size: 30,),
  Icon(MdiIcons.brain, color: AppColors.primaryColor , size: 30,),
  Icon(MdiIcons.earHearing, color: AppColors.primaryColor , size: 30,),

];

