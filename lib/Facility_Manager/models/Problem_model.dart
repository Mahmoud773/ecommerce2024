

import 'dart:convert';

import '../../models/booking_date_time_converter.dart';

class ProblemModel{
  bool isOrderStartedFromMaintenance;
  final String id;
  final String number;
  final String unitNumber;
  final String customerName;
  final String problemType;
  final String problemBy;
  final String problemDetails;
  final String problemDate;
  final String problemtime;
   String workOrderDetails;
   String teamMembers;
   String requiredEquipment;
  bool isCompleted;
  bool isPending;
  String rating;
   String badRatingReason;
  String solvedById;
   String TechnicianName;
   String price;
   bool IsNeedRepricing;
  bool isMaintenanceRespondedtoNeedPricing;
  String datePricing;
  bool isPricingVisitDone;
   bool isPaid;
   String solvingDate;
   String mallName;


  bool isAgreeToSolvingDate;
  bool waitingForCustomerToAgreeForSolvingDate;
  bool isCustomerRespondedtoSolvingDate;
  bool waitingCustomerEnsureSolving;
  bool solvedByTechnicianAndWaitingCustomerAgree;
  bool isCustomerRespondedToEnsureSolving;
  String waitTechnicianToSolveAfterPending;
  String requiredDateFromCustomer;

  // bool isFavorite;
  // String deviceToken;
  // List<DayDetails>? appointsDays ;

  ProblemModel(  {required this.id, required this.rating, required this.number, this.problemType ="", required this.problemBy,
    this.problemDetails="" ,this.problemDate="",
    this.problemtime ="" ,
    this.isCompleted =false ,required this.unitNumber, required this.customerName,
    this.workOrderDetails ='', this.teamMembers='', this.requiredEquipment='',
    this.isPending=false , this.solvedById='',
    this.TechnicianName="" ,this.price="" ,this.IsNeedRepricing=false ,
    required this.isAgreeToSolvingDate ,this.isPaid=false , this.solvingDate='',
    this.mallName='',this.waitingCustomerEnsureSolving=true,
    this.solvedByTechnicianAndWaitingCustomerAgree=false,
    this.waitingForCustomerToAgreeForSolvingDate=false,
    this.isCustomerRespondedtoSolvingDate=false,
    this.isCustomerRespondedToEnsureSolving=false,
    this.waitTechnicianToSolveAfterPending="",
    this.requiredDateFromCustomer="",
    this.badRatingReason="",
    this.datePricing="",
    this.isMaintenanceRespondedtoNeedPricing=false,
    this.isPricingVisitDone=false,
    this.isOrderStartedFromMaintenance=false,
    // this.appointsDays , this.isFavorite=false ,this.isDoctor=false,
    // this.deviceToken=""
  });


  factory ProblemModel.fromJson(Map<String, dynamic> json) => ProblemModel(
    id: json["id"],
    unitNumber: json["unitNumber"],
    isOrderStartedFromMaintenance: json["isOrderStartedFromMaintenance"],
    isPricingVisitDone: json["isPricingVisitDone"],
    isMaintenanceRespondedtoNeedPricing: json["isMaintenanceRespondedtoNeedPricing"],
    customerName: json["customerName"],
    number: json["number"],
    problemType: json["problemType"],
    problemBy: json["problemBy"],
    problemDetails:json["problemDetails"],
    problemDate:json["problemDate"],
    problemtime: json["problemtime"],
      isCompleted: json["isCompleted"],
    workOrderDetails: json["workOrderDetails"],
    teamMembers: json["teamMembers"],
    requiredEquipment: json["requiredEquipment"],
    isPending: json["isPending"],
      rating:json["rating"],
    solvedById:json["solvedById"],
    TechnicianName:json["TechnicianName"],
    price:json["price"],
    IsNeedRepricing:json["IsNeedRepricing"],
    isAgreeToSolvingDate:json["isAgreeToSolvingDate"],
    isPaid:json["isPaid"],
    solvingDate:json["solvingDate"],
    mallName:json["mallName"],
    waitingCustomerEnsureSolving:json["waitingCustomerEnsureSolving"],
    solvedByTechnicianAndWaitingCustomerAgree:json["solvedByTechnicianAndWaitingCustomerAgree"],
    waitingForCustomerToAgreeForSolvingDate:json["waitingForCustomerToAgreeForSolvingDate"],
    isCustomerRespondedtoSolvingDate:json["isCustomerRespondedtoSolvingDate"],
    isCustomerRespondedToEnsureSolving:json["isCustomerRespondedToEnsureSolving"],
    waitTechnicianToSolveAfterPending:json["waitTechnicianToSolveAfterPending"],
    requiredDateFromCustomer:json["requiredDateFromCustomer"],
    badRatingReason:json["badRatingReason"],
    datePricing:json["datePricing"],
    // appointsDays:List<DayDetails>.from(jsonDecode(json["appointsDays"].map((x)=> x))) as List<DayDetails>,
    // appointsDays:List<DayDetails>.from(json["appointsDays"].map((x)=> DayDetails.fromJson(x as Map<String , dynamic>))) ,
    // isFavorite:json["isFavorite"],
    // isDoctor:json["isDoctor"],
    // deviceToken:json["deviceToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isOrderStartedFromMaintenance":isOrderStartedFromMaintenance,
    "unitNumber": unitNumber,
    "isPricingVisitDone": isPricingVisitDone,
    "isMaintenanceRespondedtoNeedPricing":isMaintenanceRespondedtoNeedPricing,
    "customerName": customerName,
    "number": number,
    "problemType": problemType,
    "problemBy": problemBy,
    "problemDetails":problemDetails,
    "problemDate":problemDate,
    "problemtime":problemtime,
    "isCompleted":isCompleted,
    "workOrderDetails":workOrderDetails,
    "teamMembers":teamMembers,
    "requiredEquipment":requiredEquipment,
    "isPending":isPending,
     "rating":rating,
    "solvedById":solvedById,
    "TechnicianName":TechnicianName,
    "price":price,
    "IsNeedRepricing":IsNeedRepricing,

    "isAgreeToSolvingDate":isAgreeToSolvingDate,
    "isPaid":isPaid,
    "solvingDate":solvingDate,
    "mallName":mallName,
    "waitingCustomerEnsureSolving":waitingCustomerEnsureSolving,
    "solvedByTechnicianAndWaitingCustomerAgree":solvedByTechnicianAndWaitingCustomerAgree,
    "waitingForCustomerToAgreeForSolvingDate":waitingForCustomerToAgreeForSolvingDate,
    "isCustomerRespondedtoSolvingDate":isCustomerRespondedtoSolvingDate,
    "isCustomerRespondedToEnsureSolving":isCustomerRespondedToEnsureSolving,
    "waitTechnicianToSolveAfterPending":waitTechnicianToSolveAfterPending,
    "requiredDateFromCustomer":requiredDateFromCustomer,

    "badRatingReason":badRatingReason,
    "datePricing":datePricing,
    // "appointsDays":List<dynamic>.from(appointsDays!.map((x) => x)),
    // "isFavorite":isFavorite,
    // "isDoctor":isDoctor,
    // "deviceToken":deviceToken,
  };
  // ProblemModel copyWith(
  //     {   String? id,
  //       String? name,
  //       String? email,
  //       String? Category,
  //       String? experience,
  //       String? pictureUrl,
  //       bool? isFavorite,
  //       bool? isDoctor,
  //       String? deviceToken,
  //       List<DayDetails>? appointsDays }
  //     )
  // {
  //   return ProblemModel(
  //       id:id ?? this.id ,
  //       id:id ?? this.id ,
  //       id:id ?? this.id ,
  //       number:id ?? this.id ,
  //       problemType:name ?? this.problemType ,
  //       problemBy:email ?? this.problemBy ,
  //       problemDetails:Category ?? this.problemDetails ,
  //       problemDate:experience ?? this.problemDate ,
  //       problemtime:pictureUrl ?? this.problemtime
  //       // isFavorite:isFavorite ?? this.isFavorite ,
  //       // isDoctor:isDoctor ?? this.isDoctor ,
  //       // deviceToken:deviceToken ?? this.deviceToken ,
  //       //
  //       // appointsDays:appointsDays ?? this.appointsDays
  //       );
  //
  // }

}