

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/booking_date_time_converter.dart';

class PatientFireaseRepository{

  // upload appoints in details with string List
  static Future<void> uploadPatientAppoints(String uid ,
      List<Appointment> list , {bool isUpdating=false}) async{
    List yourItemList= ConvertCustomAppointmentsToMap(customSteps: list);
    try{
      final document =await FirebaseFirestore.instance.collection("PatientsAppoints").
      doc(uid).get();
      if(document.exists ==false ||isUpdating ==false)
      {
        await FirebaseFirestore.instance.collection("PatientsAppoints").
        doc(uid).set({"appointsDays" :FieldValue.arrayUnion(yourItemList) }
           //,SetOptions(merge: true)
        );
      }
      else{
        await FirebaseFirestore.instance.collection("PatientsAppoints").
        doc(uid).update({"appointsDays" :FieldValue.arrayUnion(yourItemList) });
      }

    }

    catch(e){
      throw Exception(e.toString());
    }

  }
  // list for first uplaod appoints
  static List<Map> ConvertCustomStepsToMap({required List<Appointment> customSteps}) {
    List<Map> steps = [];
    List<Map> intervals = [];
    for (int i = 0; i < customSteps.length; i++){
      customSteps[i].appointsList!.forEach((element) {
        Map interval =element.toJson() ;
        intervals.add(interval);
      });

      Map step = {
        "id":customSteps[i].id ,
        "doctorImage":customSteps[i].doctorImage ,
        "doctorName":customSteps[i].doctorName ,
        "appointWith":customSteps[i].appointWith ,
        "appointBy":customSteps[i].appointBy,
        "doctorDeviceToken":customSteps[i].doctorDeviceToken,
        "PatientDeviceToken":customSteps[i].PatientDeviceToken,
       // "appointsList": customSteps[i].appointsList
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
  static List<Map> newConvertCustomStepsToMap({required List<DayTimeDetails> customSteps}) {

    List<Map> steps = [];
    List<Map> intervals = [];
    List<Map> newIntervals=[];

    // new

    // for (int i = 0; i < customSteps.length; i++){
    //   Map interval=  customSteps[i].toJson();
    //   intervals.add(interval);
    //   Map step = {
    //     "id":customSteps[i].id ,
    //     "intervalList": customSteps[i].intervalList,
    //     "dayDate":customSteps[i].dayDate ,
    //   };
    //
    //   // steps.add(step);
    //   print(intervals);
    //
    // }
 // new
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
    // return intervals;
   }

   // new
  static List<Map>  newCustomIntervalsWithId({required List<StringIntervalWithId> customSteps }){
    List<Map> intervals = [];
    for (int i = 0; i < customSteps.length; i++){
      Map interval=  customSteps[i].toJson();
      intervals.add(interval);
    }
    return intervals;
  }
  // new get doctor appoints strings list details as stream
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getNewPatientAppointsAsSgtream(String uid) {
    return FirebaseFirestore.instance.collection("PatientsAppoints").doc(uid).snapshots();
  }

  
  // //delete appoint
  // static Future<void> deleteAppoint({ required String patientId ,required String doctorId}) async{
  //    await FirebaseFirestore.instance.collection("PatientsAppoints").doc(patientId).get().;
  // }
  // search doctors

}