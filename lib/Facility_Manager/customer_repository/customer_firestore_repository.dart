
import 'dart:convert';

import 'package:amazon/Facility_Manager/models/Customer_model.dart';
import 'package:amazon/Facility_Manager/models/Problem_model.dart';
import 'package:amazon/doctors/models/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'dart:io';

import '../../models/booking_date_time_converter.dart';
class CustomersFirestoreRpository {

  var usersCollection =FirebaseFirestore.instance.collection("customers");

  //user picture
  Future<String> uploadPicture(String file, String userId) async {
    try {
      File imageFile = File(file);
      Reference firebaseStoreRef = FirebaseStorage
          .instance
          .ref()
          .child('$userId/PP/${userId}_lead');
      await firebaseStoreRef.putFile(
        imageFile,
      );
      String url = await firebaseStoreRef.getDownloadURL();
      await usersCollection
          .doc(userId)
          .update({'picture': url});
      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // get Doctors  as future
  static Future<List<DoctorModel>> getAllDoctors() async {
    List<DoctorModel> doctorsList =[];
    try{
      final data =await FirebaseFirestore.instance.collection("customers").get();
      for (var doc in data.docs){
        doctorsList.add(DoctorModel.fromJson(
            doc.data()
        ));
      }
    }catch(e){
      throw Exception(e.toString());
    }
    return doctorsList;
  }
  // get certain customer
  static Future<CustomerModel> getCertaincustomer(String uid)  async{
    CustomerModel customerModel =CustomerModel(id:uid,email: "", deviceToken: "",
    appointsDays: [] , Category: "", experience: "", isDoctor: false,isFavorite: false ,name: ""
            ,pictureUrl: '');
    try{
    final data =await FirebaseFirestore.instance.collection("customers").doc(uid).get();
    customerModel=CustomerModel.fromJson(data.data()!);

    }catch(e){
    throw Exception(e.toString());
    }
    return customerModel;
  }

  // get certain customer as Stream
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getCertaincustomerAsStream(String uid , bool isDoctor)  {
      return FirebaseFirestore.instance.collection(isDoctor ?"customers" :"operators").doc(uid).snapshots();

  }
  // get certain user as Stream
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getCertainUserAsStream(String uid )  {
    return FirebaseFirestore.instance.collection("users").doc(uid).snapshots();

  }


  // get doctors as stream

  static Stream<QuerySnapshot<Map<String, dynamic>>>  getDoctorsAsStream() {
    return   FirebaseFirestore.instance.collection("customers").snapshots();
  }

  // search doctors
  static Stream<QuerySnapshot<Map<String, dynamic>>>  searchDoctors(String searchedValue){
    return FirebaseFirestore.instance
        .collection('customers')
        .orderBy('name')
        .startAt([searchedValue]).endAt([searchedValue + "\uf8ff"]).snapshots();
  }

  // // search doctors categories

  static Stream<QuerySnapshot<Map<String, dynamic>>>  searchDoctorCategories(String searchedValue , intIndex){
    return FirebaseFirestore.instance
        .collection('customers')
        .orderBy('Category')
        .startAt([searchedValue]).endAt([searchedValue + "\uf8ff"]).snapshots();
  }




  // update Doctor appoints
  static Future<void> updateDoctor(String uid , List<DayDetails> list) async {

    List yourItemList= ConvertCustomStepsToMap(customSteps: list);
    try{
      await FirebaseFirestore.instance.collection("customers").
      doc(uid).update({"appointsDays" : FieldValue.arrayUnion(yourItemList)});
    }

    catch(e){
      throw Exception(e.toString());
    }

  }


  static List<Map> ConvertCustomStepsToMap({required List<DayDetails> customSteps}) {



    List<Map> steps = [];
    List<Map> intervals = [];
    for (int i = 0; i < customSteps.length; i++){
      customSteps[i].intervalList!.forEach((element) {
        Map interval =element.toJson() ;
        intervals.add(interval);
      });

      Map step = {
        "intervalList": intervals,
        "dayDate":customSteps[i].dayDate ,
        "dayName":customSteps[i].dayName,
        "dayNumber" :customSteps[i].dayNumber,
      };
      steps.add(step);

    }
    // customSteps.forEach((DayDetails customStep) {
    //  // Map interval =customStep.intervalList
    //   Map step = customStep.toJson();
    //   steps.add(step);
    // });
    return steps;
  }

  //  upload Doctor appoints
  static Future<void> uploadAppoints(String uid , List<DayDetails> list) async {

    List yourItemList= ConvertCustomStepsToMap(customSteps: list);
    try{
      await FirebaseFirestore.instance.collection("doctorAppoints").
      doc(uid).set({"appointsDays" : FieldValue.arrayUnion(yourItemList)} ,SetOptions(merge: true));
    }

    catch(e){
      throw Exception(e.toString());
    }

  }


//new new new new *******************************************************
  // update operator Rating
  static Future<void> updateOperatorRating(String uid , String rating) async{

    try{
      await FirebaseFirestore.instance.collection("operators").doc(uid).
    update({"experience": rating});
    }

    catch(e){
      throw Exception(e.toString());
    }
  }
  // list for first uplaod appoints
  static List<Map> ConvertCustomProblemsToMap({required List<ProblemModel> customSteps}) {

    List<Map> steps = [];
    List<Map> intervals = [];
    for (int i = 0; i < customSteps.length; i++){
      // customSteps[i].intervalList!.forEach((element) {
      //   Map interval =element.toJson() ;
      //   intervals.add(interval);
      // });

      Map step = {
        "id": customSteps[i].id,
        "unitNumber": customSteps[i].unitNumber,
        "customerName": customSteps[i].customerName,
        "problemType": customSteps[i].problemType,
        "problemBy": customSteps[i].problemBy,
        "problemDetails": customSteps[i].problemDetails,
        "problemDate": customSteps[i].problemDate,
        "problemtime": customSteps[i].problemtime,
        "isCompleted": customSteps[i].isCompleted,
        "number": customSteps[i].number,
        "workOrderDetails": customSteps[i].workOrderDetails,
        "teamMembers": customSteps[i].teamMembers,
        "requiredEquipment": customSteps[i].requiredEquipment,
        "isPending": customSteps[i].isPending,
        "solvedBy": customSteps[i].solvedById,
        "rating": customSteps[i].rating,
        "solvedById": customSteps[i].solvedById,
        "TechnicianName": customSteps[i].TechnicianName,
        "price": customSteps[i].price,
        "IsNeedRepricing": customSteps[i].IsNeedRepricing,
        "isAgreeToSolvingDate": customSteps[i].isAgreeToSolvingDate,
        "isPaid": customSteps[i].isPaid,
        "solvingDate": customSteps[i].solvingDate,
        "mallName":customSteps[i].mallName,
        "waitingCustomerEnsureSolving":customSteps[i].waitingCustomerEnsureSolving,
        "solvedByTechnicianAndWaitingCustomerAgree":customSteps[i].solvedByTechnicianAndWaitingCustomerAgree,
        "waitingForCustomerToAgreeForSolvingDate":customSteps[i].waitingForCustomerToAgreeForSolvingDate,
        "isCustomerRespondedtoSolvingDate":customSteps[i].isCustomerRespondedtoSolvingDate,
        "isCustomerRespondedToEnsureSolving":customSteps[i].isCustomerRespondedToEnsureSolving,
        "waitTechnicianToSolveAfterPending":customSteps[i].waitTechnicianToSolveAfterPending,
        "requiredDateFromCustomer":customSteps[i].requiredDateFromCustomer,
        "badRatingReason":customSteps[i].badRatingReason,
        "datePricing":customSteps[i].datePricing,
        "isMaintenanceRespondedtoNeedPricing":customSteps[i].isMaintenanceRespondedtoNeedPricing,
        "isPricingVisitDone":customSteps[i].isPricingVisitDone,
        "isOrderStartedFromMaintenance":customSteps[i].isOrderStartedFromMaintenance,
      };
      steps.add(step);

    }
    // customSteps.forEach((DayDetails customStep) {
    //  // Map interval =customStep.intervalList
    //   Map step = customStep.toJson();
    //   steps.add(step);
    // });
    return steps;
  }

  // new upload certain customer Problems
  static Future<void> uploadProblems(String uid , List<ProblemModel> list  , {bool merge =true}) async {

    List yourItemList= ConvertCustomProblemsToMap(customSteps: list);
    try{
      await FirebaseFirestore.instance.collection("customer_problems").
      doc(uid).set({"appointsDays" : FieldValue.arrayUnion(yourItemList)} ,SetOptions(merge: merge));
    }

    catch(e){
      throw Exception(e.toString());
    }

  }

  // new upload all customers Problems
  static Future<void> uploadAllProblems(String uid , List<ProblemModel> list ,  {bool merge =true} ) async {

    List yourItemList= ConvertCustomProblemsToMap(customSteps: list);
    try{
      await FirebaseFirestore.instance.collection("all_problems").
      doc("all_problems").set({"appointsDays" : FieldValue.arrayUnion(yourItemList)} ,SetOptions(merge: merge));

    }

    catch(e){
      throw Exception(e.toString());
    }

  }


  // new get certain customer problems as stream
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getCustomerAppointsAsSgtream(String uid) {
    return FirebaseFirestore.instance.collection("customer_problems").doc(uid).snapshots();
  }

  // new get all  customer problems as stream
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getAllCustomerAppointsAsSgtream() {
    return FirebaseFirestore.instance.collection("all_problems").doc("all_problems").snapshots();
  }

  // new get waiting for ensure solving from customer

  // static Stream<DocumentSnapshot<Map<String, dynamic>>> getWaitingEnsureSolving() {
  //   return FirebaseFirestore.instance.collection("all_problems").doc("all_problems").
  // }

  // upload appoints in details with string List
  static Future<void> uploadDoctorAppoints(String uid , List<DayTimeDetails> list ,
      {bool isUpdating=false}) async{
    List yourItemList= newConvertCustomStepsToMap(customSteps: list);
    try{

      await FirebaseFirestore.instance.collection("newdoctorAppoints").
      doc(uid).set({"appointsDays" :FieldValue.arrayUnion(yourItemList) }

          ,SetOptions(merge: isUpdating)

      );

    }

    catch(e){
      throw Exception(e.toString());
    }

  }
  // list for first uplaod appoints
  static List<Map> newConvertCustomStepsToMap({required List<DayTimeDetails> customSteps}) {

    List<Map> steps = [];
    List<Map> intervals = [];
    // new
    List<Map> newIntervals=[];

    // for (int i = 0; i < customSteps.length; i++){
    //
    //   Map interval=  customSteps[i].toJson();
    //   intervals.add(interval);
    //   Map step = {
    //     "id":customSteps[i].id ,
    //     "intervalList": customSteps[i].intervalList,
    //     "dayDate":customSteps[i].dayDate ,
    //     //new
    //
    //   };
    //   // steps.add(step);
    //   print(intervals);
    // }

    //new
    for (int i = 0; i < customSteps.length; i++){
      newIntervals=newCustomIntervalsWithId(customSteps:customSteps[i].newIntervals );
      // Map interval=  customSteps[i].toJson();
      // intervals.add(interval);
      Map step = {
        "id":customSteps[i].id ,
        "intervalList": customSteps[i].intervalList,
        "dayDate":customSteps[i].dayDate ,
        //new
        "newIntervals":newIntervals
      };
      steps.add(step);
      print(intervals);
    }


    return steps;
  }
  //new new
  static List<Map>  newCustomIntervalsWithId({required List<StringIntervalWithId> customSteps }){
    List<Map> intervals = [];
    for (int i = 0; i < customSteps.length; i++){
      Map interval=  customSteps[i].toJson();
      intervals.add(interval);
    }
    return intervals;
  }

  //delete Ccanceled appoint with a patient
  static Future<void> deleteAppointFromReservedDoctorAppoints({required String uid ,
    required String deletedAppointmentId}) async {

    List<Appointment> appointsList =[];
    try{
      final data =await FirebaseFirestore.instance.collection("Doctors_Reserved_Appoints").doc(uid).get();
      for (var doc in data.data()!["appointsDays"]){
        appointsList.add(Appointment.fromJson(
            doc
        ));
      }
      print("appointsList${appointsList.length}");
      appointsList.removeWhere((element) => element.id ==deletedAppointmentId);
      print("appointsList${appointsList.length}");
      await uploadReservedDoctorAppoints(uid,appointsList ,isUpdating: true);

    }catch(e){
      throw Exception(e.toString());
    }

  }

// get certain doctor appoints
  static Future<DoctorModel> getDoctorAppoints(String uid) async {
    DoctorModel doctorModel=DoctorModel(id: uid, email: "");

    try {
      final result= await FirebaseFirestore.instance.collection("customers").doc("uid");
      doctorModel=DoctorModel.fromJson(result as Map<String, dynamic>);
    }catch(e){
      throw Exception(e.toString());
    }
    return doctorModel;
  }

// get certain doctor appoints as Stream
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getDoctorAppointsAsSgtream(String uid) {
    return FirebaseFirestore.instance.collection("doctorAppoints").doc(uid).snapshots();
  }


  // new get doctor appoints strings list details as stream
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getNewDoctorAppointsAsSgtream(String uid) {
    return FirebaseFirestore.instance.collection("newdoctorAppoints").doc(uid).snapshots();
  }


  // upload reserved Doctor appoints with patient
  static Future<void> uploadReservedDoctorAppoints(String uid ,
      List<Appointment> list , {bool isUpdating=false}) async{
    List yourItemList= ConvertCustomAppointmentsToMap(customSteps: list);

    try{
      final document=await FirebaseFirestore.instance.collection("Doctors_Reserved_Appoints").
      doc(uid).get();
      if(document.exists ==false || isUpdating==false){
        await FirebaseFirestore.instance.collection("Doctors_Reserved_Appoints").
        doc(uid).set({"appointsDays" :FieldValue.arrayUnion(yourItemList) }
          //,SetOptions(merge: true)
        );
      } else   {
        await FirebaseFirestore.instance.collection("Doctors_Reserved_Appoints").
        doc(uid).update({"appointsDays" :FieldValue.arrayUnion(yourItemList) });

      }
    }

    catch(e){
      throw Exception(e.toString());
    }

  }
  // list for first uplaod appoints
  static List<Map> ConvertCustomAppointmentsToMap({required List<Appointment> customSteps}) {
    List<Map> steps = [];
    List<Map> intervals = [];
    for (int i = 0; i < customSteps.length; i++){
      intervals =newConvertCustomStepsToMap(customSteps: customSteps[i].appointsList!);
      // customSteps[i].appointsList!.forEach((element) {
      //   Map interval =element.toJson() ;
      //   intervals.add(interval);
      // });

      Map step = {
        "id":customSteps[i].id ,
        "doctorImage":customSteps[i].doctorImage ,
        "doctorName":customSteps[i].doctorName ,
        "appointWith":customSteps[i].appointWith ,
        "appointBy":customSteps[i].appointBy,
        "doctorDeviceToken":customSteps[i].doctorDeviceToken,
        "PatientDeviceToken":customSteps[i].PatientDeviceToken,

        "appointsList" :intervals,
      };
      steps.add(step);

    }
    // customSteps.forEach((DayDetails customStep) {
    //  // Map interval =customStep.intervalList
    //   Map step = customStep.toJson();
    //   steps.add(step);
    // });
    return steps;
  }

  // new get reserved doctor appointments strings list details as stream with patient
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getReservedDoctorsAppointsAsSgtream(String uid) {
    return FirebaseFirestore.instance.collection("Doctors_Reserved_Appoints").doc(uid).snapshots();
  }

  // get new doctor appoints as future

  Future<List<DayTimeDetails>> getDoctorAppointsAsFuture(String uid) async{
    final result = await FirebaseFirestore.instance.collection("newdoctorAppoints").doc(uid).get();

    List<DayTimeDetails> list =[];
    print("${result.data()!["appointsDays"] }");
    list= result.data()!["appointsDays"] ;
    return list ;
  }





  // mark as favorite
  static Future<bool> markAsFavorite(String uid) async{
    bool isFavorite=false;
    var doctorModel =await FirebaseFirestore.instance.collection("customers").doc(uid).get();
    DoctorModel doctorModel1=DoctorModel.fromJson(doctorModel.data()!);
    // ? DoctorModel  doctorModel1= doctorModel.copyWith(isFavorite: !doctorModel.isFavorite );
    try{await FirebaseFirestore.instance.collection("customers").doc(uid).update
      ({"isFavorite" :!doctorModel1.isFavorite});
    isFavorite  =doctorModel1.isFavorite;
    } catch(e){

    }
    return isFavorite;
  }
// check if favorite
  static Future<bool> checkFavorite(String uid) async{
    bool isFavorite=false;

    try{
      var doctorModel = await FirebaseFirestore.instance.collection("customers").doc(uid).get();
      DoctorModel doctorModel1=DoctorModel.fromJson(doctorModel.data()!);
      isFavorite=doctorModel1.isFavorite;
    }catch(e) {

    }

    // ? DoctorModel  doctorModel1= doctorModel.copyWith(isFavorite: !doctorModel.isFavorite );

    return isFavorite;
  }

}