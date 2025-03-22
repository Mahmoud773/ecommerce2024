

import 'dart:convert';

import '../../models/booking_date_time_converter.dart';

class CustomerModel{
  final String id;
  final String name;
  final String email;
  final String Category;
  final String experience;
  final String pictureUrl;
  bool isDoctor;
  bool isFavorite;
  String deviceToken;
  List<DayDetails>? appointsDays ;

  CustomerModel(  {required this.id,  this.name ="", required this.email,
    this.Category="" ,this.experience="",
    this.pictureUrl ="" ,  this.appointsDays , this.isFavorite=false ,this.isDoctor=false,
    this.deviceToken=""});


  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    Category:json["Category"],
    experience:json["experience"],
    pictureUrl: json["pictureUrl"],
    // appointsDays:List<DayDetails>.from(jsonDecode(json["appointsDays"].map((x)=> x))) as List<DayDetails>,
    appointsDays:List<DayDetails>.from(json["appointsDays"].map((x)=> DayDetails.fromJson(x as Map<String , dynamic>))) ,
    isFavorite:json["isFavorite"],
    isDoctor:json["isDoctor"],
    deviceToken:json["deviceToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "Category":Category,
    "experience":experience,
    "pictureUrl":pictureUrl,

    "appointsDays":List<dynamic>.from(appointsDays!.map((x) => x)),
    "isFavorite":isFavorite,
    "isDoctor":isDoctor,
    "deviceToken":deviceToken,
  };
  CustomerModel copyWith(
      {   String? id,
        String? name,
        String? email,
        String? Category,
        String? experience,
        String? pictureUrl,
        bool? isFavorite,
        bool? isDoctor,
        String? deviceToken,
        List<DayDetails>? appointsDays }
      )
  {
    return CustomerModel(
        id:id ?? this.id ,
        name:name ?? this.name ,
        email:email ?? this.email ,
        Category:Category ?? this.Category ,
        experience:experience ?? this.experience ,
        pictureUrl:pictureUrl ?? this.pictureUrl ,
        isFavorite:isFavorite ?? this.isFavorite ,
        isDoctor:isDoctor ?? this.isDoctor ,
        deviceToken:deviceToken ?? this.deviceToken ,

        appointsDays:appointsDays ?? this.appointsDays );

  }

}