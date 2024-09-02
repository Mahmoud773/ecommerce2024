
import 'package:amazon/doctors/firestore_Repository/firetore_repository.dart';
import 'package:amazon/models/booking_date_time_converter.dart';
import 'package:amazon/views/appointment_details_view.dart';
import 'package:amazon/views/patient/firebasere_pository/patient_firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consts/colors.dart';
import '../consts/fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class AppointmentView extends StatefulWidget {
  final String doctorId;
  List<DayTimeDetails>? list8;

   AppointmentView({Key? key , required this.doctorId  , this.list8}) : super(key: key);

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  userModel? user;
   String doctorId='';
  bool isDoctor=false;
   List<DayTimeDetails> list9 =[];


  // SharedPreferences? prefs;
  // void initPrefs() async {
  //   prefs = await SharedPreferences.getInstance();
  //   isDoctor=prefs?.getBool("isDoctor") ?? false;
  //   print("isDoctor $isDoctor");
  // }
  @override
  void initState() {
    super.initState();
    // initPrefs();
  }
  final currentuser= FirebaseAuth.instance.currentUser;
  List<Appointment> myComingReservedList =[];
   List<Appointment> doctoAappointsList =[];
  @override
  Widget build(BuildContext context) {
    final currentUser= FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(title: "Appointments" , size: AppSizes.size18 ,
            color: AppColors.whiteColor),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream:  FirebaseFirestore.instance.collection("users").
          doc("${currentUser!.uid}").snapshots() ,
          builder: (context , snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasData  ) {
              user= userModel.fromJson(snapshot.data!.data()!);
              // final doctorsList =snapshot!.data!.docs as List<DoctorModel>;
              return  StreamBuilder(
                stream: user!.isDoctor ?
                DoctorsFirestoreRpository.getReservedDoctorsAppointsAsSgtream(currentuser!.uid)
                    :PatientFireaseRepository.
                getNewPatientAppointsAsSgtream(currentuser!.uid),
                builder:(context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(),);
                  }

                  if (snapshot.hasData && snapshot.data!.exists){


                    List list7 =snapshot.data!.data()!["appointsDays"];
                    print("list7 $list7");
                    myComingReservedList =[];
                    list7.forEach((element) {
                      myComingReservedList.add(Appointment.fromJson(element));
                    });

                    if(myComingReservedList.isEmpty || myComingReservedList.length==0){
                      return Center(child: AppStyles.bold(title:
                      "NO coming Appoints" ,
                          color: AppColors.textColor.withOpacity(0.5)),);
                    }
                    // List list7 =snapshot.data!.data()!["appointsDays"];
                    // print("list7 ${list7}");
                    // list7.forEach((element) {
                    //   appointsList.add(Appointment.fromJson(element));
                    //   // print("list8 $list8");
                    // });
                    // print("appointsList ${myComingReservedList[0].doctorImage}");
                    return
                      ListView.builder(
                          itemCount: myComingReservedList.length,
                          itemBuilder: (context , int index) {
                            // Appointment appointment=myComingReservedList[index] ;
                            // doctorId= appointment.appointWith;
                            return  Padding(
                              key: ValueKey(myComingReservedList[index].id),
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  Get.to( () => AppointmentDetailsView());
                                },
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:NetworkImage("${myComingReservedList[index].doctorImage}"),
                                  backgroundColor: Colors.transparent,

                                  // child: Image.network("${appointsList[index].doctorImage}"),
                                ),
                                title: AppStyles.bold(title: "${myComingReservedList[index].doctorName}"),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppStyles.bold(title:
                                    "${myComingReservedList[index].appointsList[0].
                                    dayDate.toString().substring(0,10)}" ,
                                        color: AppColors.textColor.withOpacity(0.5))
                                    ,
                                    AppStyles.normal(title:
                                    "${myComingReservedList[index].appointsList[0].intervalList[0]}" ,
                                        color: AppColors.textColor.withOpacity(0.5))
                                  ],
                                ),
                                trailing: IconButton(onPressed: ()
                                 {AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      animType: AnimType.rightSlide,
                                      title: 'cancel Appointment',
                                       desc: 'Do you want cancel this Appointment',
                                      btnCancelOnPress: () {
                                        return;
                                      },
                                  btnOkOnPress: () async{
                                  String doctorId=myComingReservedList[index].appointWith  ;
                                  String appointId=myComingReservedList[index].id;
                                  Appointment cancelledAppointment=myComingReservedList[index];
                                  myComingReservedList.removeAt(index);
                                  // print("myComingReservedList ${myComingReservedList.length}");
                                  // print("myComingReservedList ${myComingReservedList}");
                                  await PatientFireaseRepository.uploadPatientAppoints(
                                  currentUser!.uid, myComingReservedList ,isUpdating: false);
                                  final data =await FirebaseFirestore.instance.collection("Doctors_Reserved_Appoints")
                                      .doc("${doctorId}").get();
                                  // data.data()!["appointsDays"].removeWhere((key, value) => (value.id ==appointId));
                                  List<Appointment> appointsList =[];
                                  for (var doc in data.data()!["appointsDays"]){
                                  appointsList.add(Appointment.fromJson(
                                  doc
                                  ));
                                  }
                                  appointsList.removeWhere((element) => element.id==appointId);
                                  await  DoctorsFirestoreRpository.uploadReservedDoctorAppoints(doctorId,
                                  appointsList ,isUpdating: false);
                                  // for return cancelled time to available doctor times
                                  final data1 =await FirebaseFirestore.instance.
                                  collection("newdoctorAppoints")
                                      .doc("${doctorId}").get();
                                  List<DayTimeDetails> daysList=[];
                                  for (var doc in data1.data()!["appointsDays"]){
                                  daysList.add(DayTimeDetails.fromJson(
                                  doc
                                  ));
                                  }
                                  DayTimeDetails dayTimeDetails=  daysList.
                                  firstWhere((element) => element.dayDate ==
                                  cancelledAppointment.appointsList[0].
                                  dayDate);
                                  int ind=daysList.indexWhere((element) => element.dayDate ==
                                  cancelledAppointment.appointsList[0].
                                  dayDate);
                                  print("ind ind $ind");
                                  // dayTimeDetails.newIntervals.add(cancelledAppointment.
                                  // appointsList[0].newIntervals[0]);

                                  List<String> timesString=[];
                                  var stringind= dayTimeDetails.intervalList.indexWhere((element) {
                                  TimeOfDay _startTime = TimeOfDay(hour:int.parse(element.split(":")[0]),
                                  minute: int.parse(element.split(":")[1]));
                                  TimeOfDay _startTime1 =
                                  TimeOfDay(hour:int.parse(cancelledAppointment.appointsList[0].newIntervals[0].intervalTime.
                                  split(":")[0]),
                                  minute: int.parse(cancelledAppointment.appointsList[0].newIntervals[0].intervalTime.split(":")[1]));
                                  double toDouble(TimeOfDay _startTime) => _startTime.hour + _startTime.minute/60.0;
                                  double first =toDouble( _startTime);
                                  double second =toDouble( _startTime1);

                                  if(first >=second ){
                                  return true;
                                  }else return false;
                                  }


                                  );
                                  List<StringIntervalWithId> list111 =[cancelledAppointment.appointsList[0].newIntervals[0]];
                                  dayTimeDetails.newIntervals.replaceRange(stringind, stringind+1,
                                  list111);

                                  // dayTimeDetails.newIntervals.add(cancelledAppointment.
                                  // appointsList[0].newIntervals[0]);
                                  List<DayTimeDetails> replacements= [];
                                  replacements.add(dayTimeDetails);
                                  daysList.replaceRange(ind, ind+1, replacements);

                                  await DoctorsFirestoreRpository.uploadDoctorAppoints(doctorId ,daysList
                                  ,isUpdating:false );
                                     return;

                                  },


                                  )..show();
                                  // Appointment appointment=myComingReservedList[index];
                                  //
                                  // myComingReservedList.removeAt(index);
                                  // await PatientFireaseRepository.uploadPatientAppoints(
                                  //     currentUser!.uid, myComingReservedList ,isUpdating: false);
                                  // await DoctorsFirestoreRpository.
                                  // deleteAppointFromReservedDoctorAppoints
                                  //   (deletedAppointmentId: appointment.id ,uid:appointment.appointWith
                                  // ).then((value) =>
                                  //
                                  //     setState(() {
                                  //
                                  //     })
                                  // );



                                  // final Appointment doctorAppointment=doctoAappointsList.firstWhere((element) =>
                                  // (element.appointBy==appointsList[index].appointBy)
                                  //     &&(element.appointsList[0].dayDate ==
                                  //     appointsList[index].appointsList[index].dayDate) &&(
                                  //     element.appointsList[0].intervalList[0]==appointsList[index].appointsList[0]
                                  // ));
                                  // print(doctorAppointment.toString());

                                  // doctoAappointsList.where((element) =>
                                  //  (element.appointBy==appointsList[index].appointBy)
                                  //      &&(element.appointsList[0].dayDate ==
                                  //      appointsList[index].appointsList[index].dayDate) &&(
                                  //  element.appointsList[0].intervalList[0]==appointsList[index].appointsList[0]
                                  //  ));

                                  // await DoctorsFirestoreRpository.
                                  // uploadDoctorAppoints(doctorId ,list9 ,
                                  //     isUpdating:  false);
                                  // AwesomeDialog(
                                  //   context: context,
                                  //   animType: AnimType.scale,
                                  //   dialogType: DialogType.question,
                                  //   body: Center(child: Text(
                                  //     'Do You want to cancel this Appoint ?',
                                  //     style: TextStyle(fontStyle: FontStyle.italic),
                                  //   ),),
                                  //   title: 'Alert',
                                  //   desc:   'This is also Ignored',
                                  //   btnCancelText: "No",
                                  //   btnCancelOnPress: () {
                                  //
                                  //     Navigator.of(context).pop();
                                  //
                                  //   }
                                  //   ,
                                  //   btnOkOnPress: () async {
                                  //     Appointment appointment=myComingReservedList[index];
                                  //
                                  //     myComingReservedList.removeAt(index);
                                  //     print("myComingReservedList ${myComingReservedList.length}");
                                  //     await PatientFireaseRepository.uploadPatientAppoints(
                                  //         currentUser!.uid, myComingReservedList ,isUpdating: true);
                                  //     await DoctorsFirestoreRpository.
                                  //     deleteAppointFromReservedDoctorAppoints
                                  //       (deletedAppointmentId: appointment.id ,uid:appointment.appointWith
                                  //     );
                                  //     Navigator.of(context).pushReplacement(
                                  //       MaterialPageRoute(builder: (context) {return AppointmentView(
                                  //         doctorId: widget.doctorId,list8: [],
                                  //       );})
                                  //     );
                                  //   },
                                  //
                                  // )..show();
                                 //  String doctorId=myComingReservedList[index].appointWith  ;
                                 //  String appointId=myComingReservedList[index].id;
                                 //  Appointment cancelledAppointment=myComingReservedList[index];
                                 //  myComingReservedList.removeAt(index);
                                 //  // print("myComingReservedList ${myComingReservedList.length}");
                                 //  // print("myComingReservedList ${myComingReservedList}");
                                 //  await PatientFireaseRepository.uploadPatientAppoints(
                                 //      currentUser!.uid, myComingReservedList ,isUpdating: false);
                                 //  final data =await FirebaseFirestore.instance.collection("Doctors_Reserved_Appoints")
                                 //      .doc("${doctorId}").get();
                                 //  // data.data()!["appointsDays"].removeWhere((key, value) => (value.id ==appointId));
                                 //  List<Appointment> appointsList =[];
                                 //  for (var doc in data.data()!["appointsDays"]){
                                 //    appointsList.add(Appointment.fromJson(
                                 //        doc
                                 //    ));
                                 //  }
                                 //  appointsList.removeWhere((element) => element.id==appointId);
                                 //  await  DoctorsFirestoreRpository.uploadReservedDoctorAppoints(doctorId,
                                 //      appointsList ,isUpdating: false);
                                 //   // for return cancelled time to available doctor times
                                 //  final data1 =await FirebaseFirestore.instance.
                                 //  collection("newdoctorAppoints")
                                 //      .doc("${doctorId}").get();
                                 //  List<DayTimeDetails> daysList=[];
                                 //  for (var doc in data1.data()!["appointsDays"]){
                                 //    daysList.add(DayTimeDetails.fromJson(
                                 //        doc
                                 //    ));
                                 //  }
                                 //  DayTimeDetails dayTimeDetails=  daysList.
                                 //  firstWhere((element) => element.dayDate ==
                                 //      cancelledAppointment.appointsList[0].
                                 //  dayDate);
                                 //  int ind=daysList.indexWhere((element) => element.dayDate ==
                                 //      cancelledAppointment.appointsList[0].
                                 //      dayDate);
                                 //  print("ind ind $ind");
                                 //  // dayTimeDetails.newIntervals.add(cancelledAppointment.
                                 //  // appointsList[0].newIntervals[0]);
                                 //
                                 //  List<String> timesString=[];
                                 // var stringind= dayTimeDetails.intervalList.indexWhere((element) {
                                 //   TimeOfDay _startTime = TimeOfDay(hour:int.parse(element.split(":")[0]),
                                 //       minute: int.parse(element.split(":")[1]));
                                 //   TimeOfDay _startTime1 =
                                 //   TimeOfDay(hour:int.parse(cancelledAppointment.appointsList[0].newIntervals[0].intervalTime.
                                 //   split(":")[0]),
                                 //       minute: int.parse(cancelledAppointment.appointsList[0].newIntervals[0].intervalTime.split(":")[1]));
                                 //   double toDouble(TimeOfDay _startTime) => _startTime.hour + _startTime.minute/60.0;
                                 //    double first =toDouble( _startTime);
                                 //    double second =toDouble( _startTime1);
                                 //
                                 //   if(first >=second ){
                                 //     return true;
                                 //   }else return false;
                                 // }
                                 //
                                 //
                                 // );
                                 // List<StringIntervalWithId> list111 =[cancelledAppointment.appointsList[0].newIntervals[0]];
                                 //  dayTimeDetails.newIntervals.replaceRange(stringind, stringind+1,
                                 //      list111);
                                 //
                                 //  // dayTimeDetails.newIntervals.add(cancelledAppointment.
                                 //  // appointsList[0].newIntervals[0]);
                                 //  List<DayTimeDetails> replacements= [];
                                 //  replacements.add(dayTimeDetails);
                                 //  daysList.replaceRange(ind, ind+1, replacements);
                                 //
                                 //  await DoctorsFirestoreRpository.uploadDoctorAppoints(doctorId ,daysList
                                 //      ,isUpdating:false );
                                }
                                ,
                                    icon: Icon(Icons.delete ,
                                      color: Colors.amber,)),
                                // AppStyles.normal(title: "Appointment Time" ,
                                //     color: AppColors.textColor.withOpacity(0.5)),

                              ),
                            );
                          }) ;

                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("something went wrong"),);
                  }

                  else
                    return Center(child: Text("No Appoints yet"),);
                } ,
              );
            }
            else return Center(child: Text("please check internet"),);
          },

        ),
      ),
    );
  }
}
