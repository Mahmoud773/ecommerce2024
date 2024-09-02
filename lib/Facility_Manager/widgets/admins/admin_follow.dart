

import 'package:amazon/Facility_Manager/customer_repository/customer_firestore_repository.dart';
import 'package:amazon/Facility_Manager/models/Problem_model.dart';
import 'package:amazon/Facility_Manager/paymob_manager/paymentview_check.dart';
import 'package:amazon/Facility_Manager/widgets/badge.dart';
import 'package:amazon/Facility_Manager/widgets/customer_problem_card.dart';
import 'package:amazon/models/booking_date_time_converter.dart';
import 'package:amazon/res/components/Custom_text_field_new.dart';
import 'package:amazon/views/appointment_details_view.dart';
import 'package:amazon/views/patient/firebasere_pository/patient_firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:badges/badges.dart' as badges;
import 'package:connectivity_plus/connectivity_plus.dart';

import '../operators_Problem_CARD_original.dart';
import 'admins_problem_card.dart';

class AdminFollowScreen extends StatefulWidget {
  const AdminFollowScreen({super.key});

  @override
  State<AdminFollowScreen> createState() => _AdminFollowScreenState();
}

class _AdminFollowScreenState extends State<AdminFollowScreen> {
  bool isConnectedToInternet = false;

  //StreamSubscription? internetConnectionStream;
  final user = FirebaseAuth.instance.currentUser;
  List<ProblemModel> problemsList = [];
  List<ProblemModel> beforePendingProblemsList = [];
  List<ProblemModel> pendingProblemsList = [];
  List<ProblemModel> completedProblemsList = [];
  List<ProblemModel> currentCustomerProblems = [];

  List<ProblemModel> searchedProblemsList = [];
  List<ProblemModel> searchedbeforePendingProblemsList = [];
  List<ProblemModel> searchedpendingProblemsList = [];
  List<ProblemModel> searchedcompletedProblemsList = [];

  // userModel? user;
  String doctorId = '';
  bool isDoctor = false;
  List<DayTimeDetails> list9 = [];

  bool endMainDialog = false;
  bool isDialogLoading = false;
  int orderPrice = 0;

  String problemDate = '';
  final now = DateTime.now();
  List textContollersList = [];
  TextEditingController dateTextEditingController = TextEditingController();
  TextEditingController orderpriceTextEditingController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // internetConnectionStream =InternetConnection().onStatusChange.listen((event){
    //
    //   switch (event){
    //     case InternetStatus.connected:
    //       setState(() {
    //         isConnectedToInternet=true;
    //       });
    //
    //       break;
    //     case InternetStatus.connected:
    //       setState(() {
    //         isConnectedToInternet=false;
    //       });
    //       break;
    //     default:
    //       setState(() {
    //         isConnectedToInternet=false;
    //       });
    //       break;
    //   }
    // });
    // initPrefs();
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String OrderDetails = "";
  String orderequipment = "";
  String workTeam = "";
  var noItem = "";
  var firstItem = "تكنولوجيا المعلومات It";
  var secondItem = "مدنى Civil";
  var thirdItem = "تكييف AC";
  var fourthItem = "كهرباء Electricity";
  var fifthItem = "سباكة Plumbing";
  var sixItem = " H.K";
  var seventhItem = "L.C";

  TextEditingController orderDescriptionTextEditingController = TextEditingController();
  TextEditingController orderequipmentEditingController = TextEditingController();
  TextEditingController workTeamTextEditingController = TextEditingController();

  List<Appointment> myComingReservedList = [];
  List<Appointment> doctoAappointsList = [];
  String problemType = "";

  @override
  Widget build(BuildContext context) {
    final uid = user!.uid;

    return DefaultTabController(length: 3,
        child: Scaffold(
          appBar: AppBar(
              title: Text("Orders"),
              // leading: IconButton(onPressed: (){
              //   Navigator.push(context, MaterialPageRoute(builder: (c){
              //     return FMOperatorsSettingsView();
              //   }));
              //
              // }, icon: Icon(Icons.arrow_back)),
              bottom: TabBar(tabs: [
                Tab(icon: Row(
                  children: [
                    Text("orders"),
                    Icon(Icons.reorder),
                  ],
                ),),
                Tab(icon: Row(
                  children: [
                    Text("pending"),
                    Icon(Icons.pending),
                  ],
                ),),
                Tab(icon: Row(
                  children: [
                    Text("solved"),
                    Icon(Icons.check),
                  ],
                ),

                )
              ])),
          // actions: [
          //   PopupMenuButton(
          //     initialValue:"",
          //     itemBuilder: (context) =>[
          //       PopupMenuItem(child:
          //       Text("all orders") ,
          //         value: noItem,) ,
          //       PopupMenuItem(child:
          //       Text(firstItem) ,
          //         value: firstItem,) ,
          //       PopupMenuItem(child:
          //       Text(secondItem) ,
          //         value: secondItem,) ,
          //       PopupMenuItem(child:
          //       Text(thirdItem) ,
          //         value: thirdItem,) ,
          //       PopupMenuItem(child:
          //       Text(fourthItem) ,
          //         value: fourthItem,) ,
          //       PopupMenuItem(child:
          //       Text(fifthItem) ,
          //         value: fifthItem,) ,
          //       PopupMenuItem(child:
          //       Text(sixItem) ,
          //         value: sixItem,) ,
          //       PopupMenuItem(child:
          //       Text(seventhItem) ,
          //         value: seventhItem,) ,
          //
          //     ]
          //     ,onSelected: (value){
          //     setState(() {
          //       //widget.problemType=value;
          //       problemType=value.toString();
          //       print(problemType);
          //     });
          //   },
          //   )
          // ],
          // ),,
          body: StreamBuilder(
              stream: CustomersFirestoreRpository
                  .getAllCustomerAppointsAsSgtream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(),);
                }
                searchedProblemsList = [];
                completedProblemsList = [];
                pendingProblemsList = [];
                beforePendingProblemsList = [];
                problemsList = [];
                if (snapshot.hasData && snapshot.data!.exists) {
                  for (var doc in snapshot.data!.data()!["appointsDays"]) {
                    // var data = doc.data() ;
                    print(snapshot.data!.data()!["appointsDays"]);
                    print(problemsList.length);
                    problemsList.add(ProblemModel.fromJson(doc));
                  }

                  if (problemsList.length > 0) {
                    problemsList.forEach((item) {
                      if (item.isCompleted == true && item.isPending == false) {
                        completedProblemsList.add(item);
                      }
                      if (item.isPending == true && item.isCompleted == false) {
                        pendingProblemsList.add(item);
                      }
                      if (item.isCompleted == false &&
                          item.isPending == false) {
                        beforePendingProblemsList.add(item);
                      }
                    });
                    if (problemType != "") {
                      problemsList.forEach((item) {
                        if (item.problemType == problemType) {
                          searchedProblemsList.add(item);
                        } else if (item.problemType == problemType) {
                          searchedProblemsList.add(item);
                        } else if (item.problemType == problemType) {
                          searchedProblemsList.add(item);
                        } else if (item.problemType == problemType) {
                          searchedProblemsList.add(item);
                        } else if (item.problemType == problemType) {
                          searchedProblemsList.add(item);
                        } else if (item.problemType == problemType) {
                          searchedProblemsList.add(item);
                        } else if (item.problemType == problemType) {
                          searchedProblemsList.add(item);
                        }
                      });
                      if (searchedProblemsList.length > 0) {
                        searchedbeforePendingProblemsList = [];
                        searchedcompletedProblemsList = [];
                        searchedpendingProblemsList = [];
                        searchedProblemsList.forEach((item) {
                          if (item.isCompleted == true &&
                              item.isPending == false) {
                            searchedcompletedProblemsList.add(item);
                          }
                          if (item.isPending == true &&
                              item.isCompleted == false) {
                            searchedpendingProblemsList.add(item);
                          }
                          if (item.isCompleted == false &&
                              item.isPending == false) {
                            searchedbeforePendingProblemsList.add(item);
                          }
                        });
                      }
                      print("searchedProblemsList ${searchedProblemsList
                          .length}");
                    }
                  }
                  return searchedProblemsList.length > 0 ?

                  TabBarView(children: [
                    beforePendingProblemsList.length > 0 ?
                    SingleChildScrollView(
                      child: Column(
                          children: List.generate(
                              searchedbeforePendingProblemsList.length,
                                  (index) =>
                                  ProblemCardForOperators(onPress:
                                      () {},
                                    problemModel: searchedbeforePendingProblemsList[index],
                                    isOperator: false,
                                    pendingOrSolved: 'pending',)


                            // ListTile(title: Text("${beforePendingProblemsList[index].problemDate}"),
                            //   trailing: IconButton
                            //     (onPressed: () {
                            //     AwesomeDialog(context: context ,
                            //         body: SingleChildScrollView(child:
                            //         Form(
                            //           key: _formKey,
                            //           child: Column(
                            //             children: [
                            //               Text("${beforePendingProblemsList[index].problemType}"),
                            //               SizedBox(height: 10,),
                            //               MyCustomTextField(
                            //                 obsecureText: false,
                            //                 hint: "order Description",
                            //                 textEditingController: orderDescriptionTextEditingController,
                            //                 onSave: (String? value){
                            //                   OrderDetails=orderDescriptionTextEditingController.text ;
                            //                   OrderDetails =value!;
                            //                   beforePendingProblemsList[index].workOrderDetails=OrderDetails;
                            //                 },
                            //                 validator: (String? value){
                            //                   if(value == null ||value.isEmpty || value.length <20){
                            //                     return "problem details must be not less than 20 characters";
                            //                   }else OrderDetails=orderDescriptionTextEditingController.text ;
                            //                 },
                            //                 icon: Icons.report_problem_outlined,
                            //
                            //               ),
                            //               SizedBox(height: 20,),
                            //               MyCustomTextField(
                            //                 obsecureText: false,
                            //                 hint: "Order equipment",
                            //                 textEditingController: orderequipmentEditingController,
                            //                 onSave: (String? value){
                            //                   orderequipment=  orderequipmentEditingController.text ;
                            //                   orderequipment =value!;
                            //                   beforePendingProblemsList[index].requiredEquipment=orderequipment;
                            //                 },
                            //                 validator: (String? value){
                            //                   if(value == null ||value.isEmpty || value.length <20){
                            //                     return "must be not less than 3 characters";
                            //                   }else orderequipment=orderequipmentEditingController.text ;
                            //                 },
                            //                 icon: Icons.person,
                            //
                            //               ),
                            //               SizedBox(height: 20,),
                            //               MyCustomTextField(
                            //                 obsecureText: false,
                            //                 hint: "Enter unit Number",
                            //                 textEditingController: workTeamTextEditingController,
                            //                 onSave: (String? value){
                            //                   workTeam =   workTeamTextEditingController.text;
                            //                   workTeam =value!;
                            //                   beforePendingProblemsList[index].teamMembers=workTeam;
                            //                 },
                            //                 validator: (String? value){
                            //                   if(value == null ||value.isEmpty || value.length <20){
                            //                     return "problem details must be not less than 20 characters";
                            //                   }else  workTeam =   workTeamTextEditingController.text;
                            //                 },
                            //                 icon: Icons.report_problem_outlined,
                            //
                            //               ),
                            //               SizedBox(height: 10,),
                            //               Padding(
                            //                 padding: const EdgeInsets.only(bottom: 5 ,right: 8,left: 8),
                            //                 child: Container(
                            //                   color: Color(0xFFD9E4EE),
                            //                   child: Material(
                            //                       color: AppColors.primaryColor,
                            //                       borderRadius: BorderRadius.circular(10),
                            //                       child:InkWell(
                            //                         onTap: () async {
                            //
                            //                           if(_formKey.currentState!.validate()){
                            //                             _formKey.currentState!.save();
                            //                             ProblemModel problemModel=beforePendingProblemsList[index];
                            //                            problemsList.removeWhere((item) => item.id==problemModel.id);
                            //                             //widget.problemModel.isCompleted=true;
                            //                             problemModel.isPending=true;
                            //                             problemModel.solvedBy=uid;
                            //                             problemsList.add(problemModel);
                            //
                            //                             await CustomersFirestoreRpository.uploadAllProblems("", problemsList, merge: false);
                            //                             await CustomersFirestoreRpository.uploadProblems(problemModel.problemBy,
                            //
                            //                                 problemsList ,merge: false).then(
                            //                                     (value){
                            //                                   // showDialog(context: context, builder:
                            //                                   // (context) {
                            //                                   //   return Column(
                            //                                   //     children: [
                            //                                   //       Text("please let customer ensure solving"),
                            //                                   //
                            //                                   //     ],
                            //                                   //   );
                            //                                   // }
                            //                                   // );
                            //
                            //                                   AwesomeDialog(context: context
                            //                                       ,title: "solved" ,
                            //                                       desc: "please let customer ensure solving" ,
                            //                                       dismissOnTouchOutside: true,
                            //                                       btnCancelOnPress: (){return ;},
                            //                                       btnOkOnPress: (){
                            //                                         return ;
                            //                                       }
                            //                                   ).show();
                            //                                 }
                            //                             );
                            //                           }
                            //                         },
                            //                         child: Container(
                            //                           height: 60,
                            //                           width: 200,
                            //                           child: Center(child:
                            //                           Text("Save Order" ,
                            //                             style: TextStyle(
                            //                               fontSize: 20 ,
                            //                               fontWeight: FontWeight.bold,
                            //                               color: Colors.white,
                            //
                            //                             ),
                            //                           ),),
                            //                         ),
                            //                       )
                            //
                            //                     // Row(
                            //                     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //                     //   children: [
                            //                     //     InkWell(
                            //                     //       onTap: (){
                            //                     //
                            //                     //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //                     //             BookingCard2(doctorModel: widget.doctorModel,)
                            //                     //         ));
                            //                     //       },
                            //                     //       child: Container(
                            //                     //         height: 60,
                            //                     //         width: 100,
                            //                     //         child: Center(child:
                            //                     //         Text("add Appointment" ,
                            //                     //           style: TextStyle(
                            //                     //             fontSize: 20 ,
                            //                     //             fontWeight: FontWeight.bold,
                            //                     //             color: Colors.white,
                            //                     //
                            //                     //           ),
                            //                     //         ),),
                            //                     //       ),
                            //                     //     ),
                            //                     //     SizedBox(width: 10,),
                            //                     //     InkWell(
                            //                     //       onTap: () async{
                            //                     //         choosenDateTimesList.add(choosenDayTimeDay);
                            //                     //         print("choosenDateTimesList ${choosenDateTimesList[0].dayDate}");
                            //                     //         print("choosenDateTimesList ${choosenDateTimesList[0].intervalList}");
                            //                     //         print("${choosenDateTimesList.length}");
                            //                     //
                            //                     //         list8[selectedDayIndex].intervalList.removeAt(selectedTimeIndex);
                            //                     //
                            //                     //         print(list8);
                            //                     //         Appointment appointment=
                            //                     //         Appointment(doctorImage:widget.doctorModel.pictureUrl ,
                            //                     //             doctorName:widget.doctorModel.name ,
                            //                     //             appointWith: "${widget.doctorModel.id}",
                            //                     //             appointBy: "${currentUser!.uid}",
                            //                     //             appointsList: choosenDateTimesList);
                            //                     //         patientAppointsList.add(appointment);
                            //                     //         await DoctorsFirestoreRpository.
                            //                     //         uploadDoctorAppoints(widget.doctorModel.id ,list8 ,
                            //                     //             isUpdating:  false);
                            //                     //
                            //                     //         setState(() {
                            //                     //
                            //                     //         });
                            //                     //         await DoctorsFirestoreRpository.uploadReservedDoctorAppoints(widget.doctorModel.id,
                            //                     //             patientAppointsList);
                            //                     //         await PatientFireaseRepository.uploadPatientAppoints(
                            //                     //             currentUser!.uid, patientAppointsList ,isUpdating: false).
                            //                     //         then((value) {
                            //                     //           Navigator.of(context).pushReplacement(
                            //                     //               MaterialPageRoute(builder: (context) {
                            //                     //                 return AppointmentView(doctorId: widget.doctorModel.id,);
                            //                     //               })
                            //                     //           );
                            //                     //         });
                            //                     //
                            //                     //
                            //                     //
                            //                     //         print(list8);
                            //                     //       },
                            //                     //       child: Container(
                            //                     //         height: 60,
                            //                     //         width: 100,
                            //                     //         child: Center(child:
                            //                     //         Text("book Appointment" ,
                            //                     //           style: TextStyle(
                            //                     //             fontSize: 20 ,
                            //                     //             fontWeight: FontWeight.bold,
                            //                     //             color: Colors.white,
                            //                     //
                            //                     //           ),
                            //                     //         ),),
                            //                     //       ),
                            //                     //     )
                            //                     //   ],
                            //                     // )
                            //
                            //
                            //
                            //                     // Row(
                            //                     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //                     //   children: [
                            //                     //     InkWell(
                            //                     //       onTap: (){
                            //                     //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //                     //             BookingCard2(doctorModel: widget.doctorModel,)
                            //                     //         ));
                            //                     //       },
                            //                     //       child: Container(
                            //                     //         height: 60,
                            //                     //         width: 50,
                            //                     //         child: Center(child:
                            //                     //         Text("Book Appointment" ,
                            //                     //           style: TextStyle(
                            //                     //             fontSize: 20 ,
                            //                     //             fontWeight: FontWeight.bold,
                            //                     //             color: Colors.white,
                            //                     //
                            //                     //           ),
                            //                     //         ),),
                            //                     //       ),
                            //                     //     ),
                            //                     //     ,
                            //                     //   ],
                            //                     // ),
                            //                   ),
                            //                 ),
                            //               ),
                            //
                            //               // StreamBuilder(stream: stream, builder: (context,snapshot)
                            //               // {
                            //               //   return ;
                            //               // }
                            //               // ),
                            //
                            //             ],
                            //           ),
                            //         )
                            //          ,),
                            //         btnOkOnPress: (){
                            //       return ;
                            //           // final ProblemModel problemModel=beforePendingProblemsList[index] ;
                            //           // problemModel.isCompleted=true;
                            //           // problemModel.isPending=false;
                            //           // print(problemModel.problemType);
                            //           // print("problemsList${problemsList.length}");
                            //           // problemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                            //           // print("problemsList${problemsList.length}");
                            //           // problemsList.add(problemModel);
                            //           //
                            //           // await CustomersFirestoreRpository.uploadProblems(uid,
                            //           //
                            //           //     problemsList ,merge: false);
                            //           // await CustomersFirestoreRpository.uploadAllProblems("", problemsList, merge: false);
                            //           //
                            //           // return;
                            //         } ,
                            //         dismissOnTouchOutside: true).show();
                            //   },
                            //       icon: Icon(Icons.reorder)),
                            //
                            // ),
                          )
                      ),
                    ) :
                    Center(child: Text("No Orders yet"),),
                    searchedpendingProblemsList.length > 0 ?
                    SingleChildScrollView(
                      child: Column(
                          children: List.generate(
                              searchedpendingProblemsList.length, (index) =>


                              ProblemCardForOperators(onPress: () {},
                                problemModel: searchedpendingProblemsList[index],
                                isOperator: true, pendingOrSolved: 'pending',)


                            // ListTile(title: Text("${pendingProblemsList[index].problemDate}"),
                            //   trailing: IconButton(onPressed: () {
                            //     AwesomeDialog(context: context ,
                            //         btnOkOnPress: ()async{
                            //           final ProblemModel problemModel=pendingProblemsList[index] ;
                            //           problemModel.isCompleted=true;
                            //           problemModel.isPending=false;
                            //           print(problemModel.problemType);
                            //           problemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                            //           print("problemsList${problemsList.length}");
                            //           problemsList.add(problemModel);
                            //
                            //           await CustomersFirestoreRpository.uploadProblems(uid,
                            //
                            //               problemsList ,merge: false);
                            //           await CustomersFirestoreRpository.uploadAllProblems("", problemsList, merge: false);
                            //
                            //           return;
                            //         } ,
                            //         dismissOnTouchOutside: true).show();
                            //   }, icon: Icon(Icons.reorder)),
                            //
                            // ),
                          )
                      ),
                    ) : Center(child: Text("No Orders yet"),),
                    SingleChildScrollView(
                      child: Column(
                          children: List.generate(
                              searchedcompletedProblemsList.length, (index) =>
                              ProblemCardForOperators(isOperator: true,
                                problemModel: searchedcompletedProblemsList[index],
                                onPress: () {},
                                pendingOrSolved: "solved",
                              )
                          )
                      ),
                    ),
                  ])
                      :
                  TabBarView(children: [
                    beforePendingProblemsList.length > 0 ?
                    SingleChildScrollView(
                      child: Column(
                          children: List.generate(
                              beforePendingProblemsList.length,
                                  (index) =>
                                      AdminProblemCard(
                                    onPress: () {},
                                    problemModel:
                                    beforePendingProblemsList[index],
                                    isOperator: false,
                                    pendingOrSolved: 'pending',)


                            // ListTile(title: Text("${beforePendingProblemsList[index].problemDate}"),
                            //   trailing: IconButton
                            //     (onPressed: () {
                            //     AwesomeDialog(context: context ,
                            //         body: SingleChildScrollView(child:
                            //         Form(
                            //           key: _formKey,
                            //           child: Column(
                            //             children: [
                            //               Text("${beforePendingProblemsList[index].problemType}"),
                            //               SizedBox(height: 10,),
                            //               MyCustomTextField(
                            //                 obsecureText: false,
                            //                 hint: "order Description",
                            //                 textEditingController: orderDescriptionTextEditingController,
                            //                 onSave: (String? value){
                            //                   OrderDetails=orderDescriptionTextEditingController.text ;
                            //                   OrderDetails =value!;
                            //                   beforePendingProblemsList[index].workOrderDetails=OrderDetails;
                            //                 },
                            //                 validator: (String? value){
                            //                   if(value == null ||value.isEmpty || value.length <20){
                            //                     return "problem details must be not less than 20 characters";
                            //                   }else OrderDetails=orderDescriptionTextEditingController.text ;
                            //                 },
                            //                 icon: Icons.report_problem_outlined,
                            //
                            //               ),
                            //               SizedBox(height: 20,),
                            //               MyCustomTextField(
                            //                 obsecureText: false,
                            //                 hint: "Order equipment",
                            //                 textEditingController: orderequipmentEditingController,
                            //                 onSave: (String? value){
                            //                   orderequipment=  orderequipmentEditingController.text ;
                            //                   orderequipment =value!;
                            //                   beforePendingProblemsList[index].requiredEquipment=orderequipment;
                            //                 },
                            //                 validator: (String? value){
                            //                   if(value == null ||value.isEmpty || value.length <20){
                            //                     return "must be not less than 3 characters";
                            //                   }else orderequipment=orderequipmentEditingController.text ;
                            //                 },
                            //                 icon: Icons.person,
                            //
                            //               ),
                            //               SizedBox(height: 20,),
                            //               MyCustomTextField(
                            //                 obsecureText: false,
                            //                 hint: "Enter unit Number",
                            //                 textEditingController: workTeamTextEditingController,
                            //                 onSave: (String? value){
                            //                   workTeam =   workTeamTextEditingController.text;
                            //                   workTeam =value!;
                            //                   beforePendingProblemsList[index].teamMembers=workTeam;
                            //                 },
                            //                 validator: (String? value){
                            //                   if(value == null ||value.isEmpty || value.length <20){
                            //                     return "problem details must be not less than 20 characters";
                            //                   }else  workTeam =   workTeamTextEditingController.text;
                            //                 },
                            //                 icon: Icons.report_problem_outlined,
                            //
                            //               ),
                            //               SizedBox(height: 10,),
                            //               Padding(
                            //                 padding: const EdgeInsets.only(bottom: 5 ,right: 8,left: 8),
                            //                 child: Container(
                            //                   color: Color(0xFFD9E4EE),
                            //                   child: Material(
                            //                       color: AppColors.primaryColor,
                            //                       borderRadius: BorderRadius.circular(10),
                            //                       child:InkWell(
                            //                         onTap: () async {
                            //
                            //                           if(_formKey.currentState!.validate()){
                            //                             _formKey.currentState!.save();
                            //                             ProblemModel problemModel=beforePendingProblemsList[index];
                            //                            problemsList.removeWhere((item) => item.id==problemModel.id);
                            //                             //widget.problemModel.isCompleted=true;
                            //                             problemModel.isPending=true;
                            //                             problemModel.solvedBy=uid;
                            //                             problemsList.add(problemModel);
                            //
                            //                             await CustomersFirestoreRpository.uploadAllProblems("", problemsList, merge: false);
                            //                             await CustomersFirestoreRpository.uploadProblems(problemModel.problemBy,
                            //
                            //                                 problemsList ,merge: false).then(
                            //                                     (value){
                            //                                   // showDialog(context: context, builder:
                            //                                   // (context) {
                            //                                   //   return Column(
                            //                                   //     children: [
                            //                                   //       Text("please let customer ensure solving"),
                            //                                   //
                            //                                   //     ],
                            //                                   //   );
                            //                                   // }
                            //                                   // );
                            //
                            //                                   AwesomeDialog(context: context
                            //                                       ,title: "solved" ,
                            //                                       desc: "please let customer ensure solving" ,
                            //                                       dismissOnTouchOutside: true,
                            //                                       btnCancelOnPress: (){return ;},
                            //                                       btnOkOnPress: (){
                            //                                         return ;
                            //                                       }
                            //                                   ).show();
                            //                                 }
                            //                             );
                            //                           }
                            //                         },
                            //                         child: Container(
                            //                           height: 60,
                            //                           width: 200,
                            //                           child: Center(child:
                            //                           Text("Save Order" ,
                            //                             style: TextStyle(
                            //                               fontSize: 20 ,
                            //                               fontWeight: FontWeight.bold,
                            //                               color: Colors.white,
                            //
                            //                             ),
                            //                           ),),
                            //                         ),
                            //                       )
                            //
                            //                     // Row(
                            //                     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //                     //   children: [
                            //                     //     InkWell(
                            //                     //       onTap: (){
                            //                     //
                            //                     //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //                     //             BookingCard2(doctorModel: widget.doctorModel,)
                            //                     //         ));
                            //                     //       },
                            //                     //       child: Container(
                            //                     //         height: 60,
                            //                     //         width: 100,
                            //                     //         child: Center(child:
                            //                     //         Text("add Appointment" ,
                            //                     //           style: TextStyle(
                            //                     //             fontSize: 20 ,
                            //                     //             fontWeight: FontWeight.bold,
                            //                     //             color: Colors.white,
                            //                     //
                            //                     //           ),
                            //                     //         ),),
                            //                     //       ),
                            //                     //     ),
                            //                     //     SizedBox(width: 10,),
                            //                     //     InkWell(
                            //                     //       onTap: () async{
                            //                     //         choosenDateTimesList.add(choosenDayTimeDay);
                            //                     //         print("choosenDateTimesList ${choosenDateTimesList[0].dayDate}");
                            //                     //         print("choosenDateTimesList ${choosenDateTimesList[0].intervalList}");
                            //                     //         print("${choosenDateTimesList.length}");
                            //                     //
                            //                     //         list8[selectedDayIndex].intervalList.removeAt(selectedTimeIndex);
                            //                     //
                            //                     //         print(list8);
                            //                     //         Appointment appointment=
                            //                     //         Appointment(doctorImage:widget.doctorModel.pictureUrl ,
                            //                     //             doctorName:widget.doctorModel.name ,
                            //                     //             appointWith: "${widget.doctorModel.id}",
                            //                     //             appointBy: "${currentUser!.uid}",
                            //                     //             appointsList: choosenDateTimesList);
                            //                     //         patientAppointsList.add(appointment);
                            //                     //         await DoctorsFirestoreRpository.
                            //                     //         uploadDoctorAppoints(widget.doctorModel.id ,list8 ,
                            //                     //             isUpdating:  false);
                            //                     //
                            //                     //         setState(() {
                            //                     //
                            //                     //         });
                            //                     //         await DoctorsFirestoreRpository.uploadReservedDoctorAppoints(widget.doctorModel.id,
                            //                     //             patientAppointsList);
                            //                     //         await PatientFireaseRepository.uploadPatientAppoints(
                            //                     //             currentUser!.uid, patientAppointsList ,isUpdating: false).
                            //                     //         then((value) {
                            //                     //           Navigator.of(context).pushReplacement(
                            //                     //               MaterialPageRoute(builder: (context) {
                            //                     //                 return AppointmentView(doctorId: widget.doctorModel.id,);
                            //                     //               })
                            //                     //           );
                            //                     //         });
                            //                     //
                            //                     //
                            //                     //
                            //                     //         print(list8);
                            //                     //       },
                            //                     //       child: Container(
                            //                     //         height: 60,
                            //                     //         width: 100,
                            //                     //         child: Center(child:
                            //                     //         Text("book Appointment" ,
                            //                     //           style: TextStyle(
                            //                     //             fontSize: 20 ,
                            //                     //             fontWeight: FontWeight.bold,
                            //                     //             color: Colors.white,
                            //                     //
                            //                     //           ),
                            //                     //         ),),
                            //                     //       ),
                            //                     //     )
                            //                     //   ],
                            //                     // )
                            //
                            //
                            //
                            //                     // Row(
                            //                     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //                     //   children: [
                            //                     //     InkWell(
                            //                     //       onTap: (){
                            //                     //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //                     //             BookingCard2(doctorModel: widget.doctorModel,)
                            //                     //         ));
                            //                     //       },
                            //                     //       child: Container(
                            //                     //         height: 60,
                            //                     //         width: 50,
                            //                     //         child: Center(child:
                            //                     //         Text("Book Appointment" ,
                            //                     //           style: TextStyle(
                            //                     //             fontSize: 20 ,
                            //                     //             fontWeight: FontWeight.bold,
                            //                     //             color: Colors.white,
                            //                     //
                            //                     //           ),
                            //                     //         ),),
                            //                     //       ),
                            //                     //     ),
                            //                     //     ,
                            //                     //   ],
                            //                     // ),
                            //                   ),
                            //                 ),
                            //               ),
                            //
                            //               // StreamBuilder(stream: stream, builder: (context,snapshot)
                            //               // {
                            //               //   return ;
                            //               // }
                            //               // ),
                            //
                            //             ],
                            //           ),
                            //         )
                            //          ,),
                            //         btnOkOnPress: (){
                            //       return ;
                            //           // final ProblemModel problemModel=beforePendingProblemsList[index] ;
                            //           // problemModel.isCompleted=true;
                            //           // problemModel.isPending=false;
                            //           // print(problemModel.problemType);
                            //           // print("problemsList${problemsList.length}");
                            //           // problemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                            //           // print("problemsList${problemsList.length}");
                            //           // problemsList.add(problemModel);
                            //           //
                            //           // await CustomersFirestoreRpository.uploadProblems(uid,
                            //           //
                            //           //     problemsList ,merge: false);
                            //           // await CustomersFirestoreRpository.uploadAllProblems("", problemsList, merge: false);
                            //           //
                            //           // return;
                            //         } ,
                            //         dismissOnTouchOutside: true).show();
                            //   },
                            //       icon: Icon(Icons.reorder)),
                            //
                            // ),
                          )
                      ),
                    ) : Center(child: Text("No Orders yet"),),
                    pendingProblemsList.length > 0 ?
                    SingleChildScrollView(
                      child: Column(
                          children: List.generate(
                              pendingProblemsList.length, (index) =>


                              AdminProblemCard(onPress: () {},
                                problemModel: pendingProblemsList[index],
                                isOperator: true, pendingOrSolved: 'pending',)


                            // ListTile(title: Text("${pendingProblemsList[index].problemDate}"),
                            //   trailing: IconButton(onPressed: () {
                            //     AwesomeDialog(context: context ,
                            //         btnOkOnPress: ()async{
                            //           final ProblemModel problemModel=pendingProblemsList[index] ;
                            //           problemModel.isCompleted=true;
                            //           problemModel.isPending=false;
                            //           print(problemModel.problemType);
                            //           problemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                            //           print("problemsList${problemsList.length}");
                            //           problemsList.add(problemModel);
                            //
                            //           await CustomersFirestoreRpository.uploadProblems(uid,
                            //
                            //               problemsList ,merge: false);
                            //           await CustomersFirestoreRpository.uploadAllProblems("", problemsList, merge: false);
                            //
                            //           return;
                            //         } ,
                            //         dismissOnTouchOutside: true).show();
                            //   }, icon: Icon(Icons.reorder)),
                            //
                            // ),
                          )
                      ),
                    ) : Center(child: Text("No Orders yet"),),
                    SingleChildScrollView(
                      child: Column(
                          children: List.generate(
                              completedProblemsList.length, (index) =>
                              AdminProblemCard(isOperator: true,
                                problemModel: completedProblemsList[index],
                                onPress: () {},
                                pendingOrSolved: "solved",
                              )
                          )
                      ),
                    ),
                  ]);
                }
                // if(!snapshot.data!.exists)
                //   {
                //
                //     return TabBarView(children: [
                //       Center(child: Text("no orders Yet"),),
                //       Center(child: Text("no orders Yet"),),
                //     ]);
                //   }
                if (snapshot.hasError) {
                  return TabBarView(children: [
                    Center(child: Text("something went wrong"),),
                    Center(child: Text("something went wrong"),),
                  ]);
                }
                if (problemsList.isEmpty) {
                  return TabBarView(children: [
                    Center(child: Text("no orders Yet"),),
                    Center(child: Text("no orders Yet"),),
                  ]);
                }
                else
                  return TabBarView(children: [
                    Center(child: Text("no orders Yet"),),
                    Center(child: Text("no orders Yet"),),
                  ]
                  );
              }
          ),
        )
    );
  }
}