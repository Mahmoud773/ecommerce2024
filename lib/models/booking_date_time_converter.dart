import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//this basically is to convert date/day/time from calendar to string
class DateConverted {
  static String getDate(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  static String getDay(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Sunday';
    }
  }

  static String getTime(int time) {
    switch (time) {
      case 0:
        return '9:00 AM';
      case 1:
        return '10:00 AM';
      case 2:
        return '11:00 AM';
      case 3:
        return '12:00 PM';
      case 4:
        return '13:00 PM';
      case 5:
        return '14:00 PM';
      case 6:
        return '15:00 PM';
      case 7:
        return '16:00 PM';
      default:
        return '9:00 AM';
    }
  }
}

class IntervalDetails {
  int? intervalNumber;
  String? intervalStart;
  String? intervalEnd;
  int? intervalPeriod;
  IntervalDetails({
    this.intervalNumber  , this.intervalStart  , this.intervalEnd ,
    this.intervalPeriod ,
});
  factory IntervalDetails.fromJson(Map<String, dynamic> json) => IntervalDetails(
    intervalNumber: json["intervalNumber"],
    intervalStart: json["intervalStart"],
    intervalEnd:json["intervalEnd"],
    intervalPeriod:json["intervalPeriod"],

  );

  Map<String, dynamic> toJson() => {
    "intervalNumber": intervalNumber,
    "intervalStart": intervalStart,
    "intervalEnd": intervalEnd,
    "intervalPeriod": intervalPeriod,

  };


}
class DayDetails{
  List<IntervalDetails>? intervalList;
  DateTime? dayDate;
  String dayName;
  int? dayNumber ;

  DayDetails({this.intervalList , this.dayName ='satur' ,this.dayDate , required this.dayNumber });

  factory DayDetails.fromJson(Map<String, dynamic> json) => DayDetails(

    dayName: json["dayName"],
    dayDate: json["dayDate"].toDate(),
    dayNumber:json["dayNumber"],

    intervalList:List<IntervalDetails>.from(json["intervalList"].map((x)=> IntervalDetails.fromJson(x as Map<String , dynamic>))) ,


  );

  Map<String, dynamic> toJson() => {
    "dayName": dayName,
    "dayDate": dayDate,
    "dayNumber": dayNumber,

    "intervalList":List<dynamic>.from(intervalList!.map((x) => x)),
  };
}

//new 30/8
class StringIntervalWithId{
  String intervalTime;
  String IntervalId;
  StringIntervalWithId({required this.IntervalId ,required this.intervalTime});

  factory StringIntervalWithId.fromJson(Map<String, dynamic> json) => StringIntervalWithId(
    intervalTime: json["intervalTime"],
    IntervalId: json["IntervalId"],

  );
  Map<String, dynamic> toJson() => {
    "intervalTime": intervalTime,
    "IntervalId": IntervalId,
};
}
class DayTimeDetails{
  final String id;
  final List<String> intervalList;
  final DateTime dayDate;
  List<StringIntervalWithId> newIntervals;
  DayTimeDetails({required this.id,required this.intervalList ,required this.dayDate
   ,required this.newIntervals});
  factory DayTimeDetails.fromJson(Map<String, dynamic> json) => DayTimeDetails(
    id: json["id"],

    dayDate: json["dayDate"].toDate(),

    intervalList:List<String>.from(json["intervalList"].map((x) => x)),

    newIntervals:List<StringIntervalWithId>.from(json["newIntervals"].map((x)=>
        StringIntervalWithId.fromJson(x as Map<String , dynamic>))) ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dayDate": dayDate,
    "intervalList":List<dynamic>.from(intervalList!.map((x) => x)),
    "newIntervals":List<dynamic>.from(newIntervals!.map((x) => x)),

  };
}

class Appointment{
  final String id;
  final String doctorImage;
  final String doctorName;
  final String appointWith;
  final String appointBy;
   String doctorDeviceToken;
  String PatientDeviceToken;
  final List<DayTimeDetails> appointsList;


  Appointment({required this.id , required this.doctorImage ,required this.doctorName,

    required this.appointWith ,required this.appointBy ,this.doctorDeviceToken="",this.PatientDeviceToken="",
    required this.appointsList });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    doctorName: json["doctorName"],
    doctorImage: json["doctorImage"],
    appointWith: json["appointWith"],
    appointBy: json["appointBy"],
    doctorDeviceToken: json["doctorDeviceToken"],
    PatientDeviceToken: json["PatientDeviceToken"],
    appointsList:List<DayTimeDetails>.from(json["appointsList"].map((x)=> DayTimeDetails.fromJson(x as Map<String , dynamic>))) ,


  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "doctorImage": doctorImage,
    "doctorName": doctorName,

    "appointWith": appointWith,
    "appointBy": appointBy,
    "doctorDeviceToken": doctorDeviceToken,
    "PatientDeviceToken": PatientDeviceToken,

    "appointsList":List<dynamic>.from(appointsList!.map((x) => x)),
  };


}

class userModel{
final String id;
final String name;
final bool isDoctor;
final String pictureUrl;
final String email;

userModel({required this.id, required this.name,required this.isDoctor,required this.pictureUrl,
  required
this.email});

factory userModel.fromJson(Map<String, dynamic> json) => userModel(
  id: json["id"],
  name: json["name"],
  email: json["email"],

  pictureUrl: json["pictureUrl"],
  // appointsDays:List<DayDetails>.from(jsonDecode(json["appointsDays"].map((x)=> x))) as List<DayDetails>,

  isDoctor:json["isDoctor"],
);

Map<String, dynamic> toJson() => {
  "id": id,
  "name": name,
  "email": email,

  "pictureUrl":pictureUrl,

  "isDoctor":isDoctor,
};
}