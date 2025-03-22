

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

import '../consts/colors.dart';
import '../consts/fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:badges/badges.dart' as badges;
import 'package:connectivity_plus/connectivity_plus.dart';

import 'Home_with_bottomBar_Screenr.dart';
import 'facility_home_screen.dart';

class MyProblemsScreen2222222222222 extends StatefulWidget {
  final String doctorId;
  List<DayTimeDetails>? list8;

  MyProblemsScreen2222222222222({Key? key , required this.doctorId  , this.list8}) : super(key: key);
  // final _customViewKey = GlobalKey<>();
  @override
  State<MyProblemsScreen2222222222222> createState() => _MyProblemsScreen2222222222222State();
}

class _MyProblemsScreen2222222222222State extends State<MyProblemsScreen2222222222222> {

  final  user = FirebaseAuth.instance.currentUser;
  List<ProblemModel> problemsList=[];
  List<ProblemModel> currentCustomerProblemsList=[];
  List<ProblemModel> beforePendingProblemsList=[];
  List<ProblemModel> pendingProblemsList=[];
  List<ProblemModel> completedProblemsList=[];
  // userModel? user;
  String doctorId='';
  bool isDoctor=false;
  List<DayTimeDetails> list9 =[];
  TextEditingController requiredDateFromCustomerController=TextEditingController();
  final now=DateTime.now();
String requiredDateFromCustomer="";

String badRatingReason="";

  String repricingDate='';
  TextEditingController datePricingTextEditingController =TextEditingController();



  @override
  void initState() {
    super.initState();
    // initPrefs();
  }

  List<Appointment> myComingReservedList =[];
  List<Appointment> doctoAappointsList =[];
  // final ValueNotifier<int> badgeNumber=ValueNotifier(0) ;
  int badgeNumber=0;
  @override
  Widget build(BuildContext context) {

    final uid = user!.uid;
    double barRating=3.0;
    bool isBadRating=false;
    return DefaultTabController(length: 3,
        child: StreamBuilder(
          stream: CustomersFirestoreRpository.getAllCustomerAppointsAsSgtream(),
          builder: (context, snapshot) {
            completedProblemsList=[];
            pendingProblemsList=[];
            beforePendingProblemsList=[];
            problemsList=[];
            if(snapshot.hasData && snapshot.data!.exists ){

              for(var doc in snapshot.data!.data()!["appointsDays"]){
                // var data = doc.data() ;
                print(snapshot.data!.data()!["appointsDays"]);
                print(problemsList.length);
                problemsList.add(ProblemModel.fromJson(doc));

              }

              problemsList.forEach((item){
                if(item.problemBy==uid){
                  currentCustomerProblemsList.add(item);
                  if(item.isCompleted==true&&item.isPending==false){
                    completedProblemsList.add(item);
                  }if(item.isPending==true&&item.isCompleted==false){
                    pendingProblemsList.add(item);
                  }if(item.isCompleted==false &&item.isPending==false){
                    beforePendingProblemsList.add(item);
                  }
                }

              });


              badgeNumber= pendingProblemsList.length;

            }
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return FMHomeBarscreen();
                  }));
                }, icon: Icon(Icons.arrow_back)),
                title: Text("My Orders"),
                bottom: TabBar(tabs: [
                  Tab(icon: Row(
                    children: [
                      Text("orders"),
                      Icon(Icons.menu),
                    ],
                  ),),
                  Tab(icon: Row(
                    children: [
                      Text("pending"),
                      badges.Badge(

                        badgeContent: Text('${pendingProblemsList.length}',style: TextStyle(
                          color: Colors.white
                        ),),
                        child: Icon(Icons.pending),
                        position: badges.BadgePosition.topEnd(top: -20, end: -15),
                        showBadge:pendingProblemsList.length>0 ?true : false ,
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Colors.red,
                        ),
                      )
                      ,
                      // MyBadge(number: 0, increaseNumber: 0, listLenght: pendingProblemsList.length, update: true,)
                    ],
                  ),),
                  Tab(icon: Row(
                    children: [
                      Text("solved"),
                      Icon(Icons.check),
                    ],
                  ),

                  )
                ]),
              ),
              body: snapshot.connectionState==ConnectionState.waiting ?
                  Center(child: CircularProgressIndicator(),)
                  :
              (snapshot.hasData && snapshot.data!.exists) ?
              TabBarView(children: [
                SingleChildScrollView(
                  child: Column(
                      children:
              beforePendingProblemsList.length>0?
                      List.generate(beforePendingProblemsList.length, (index)=>

                          OperatorProblemCard(Pending: false,solved: false,
                            problemModel:beforePendingProblemsList[index] ,onPressWhenPending:
                                (){
                              AwesomeDialog(context: context ,
                                  dialogType:DialogType.question ,
                                  desc:"Do you want remove this order" ,
                                  btnCancelOnPress: (){
                                    return;
                                  },
                                  btnOkOnPress: () async {
                                    final ProblemModel problemModel=beforePendingProblemsList[index] ;
                                    currentCustomerProblemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                    problemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);


                                    await CustomersFirestoreRpository.uploadProblems(uid,

                                        currentCustomerProblemsList ,merge: false);
                                    await CustomersFirestoreRpository.uploadAllProblems("", problemsList, merge: false);

                                    return;
                                  },
                                  // async{
                                  //   final ProblemModel problemModel=beforePendingProblemsList[index] ;
                                  //   problemModel.isCompleted=true;
                                  //   problemModel.isPending=false;
                                  //   print(problemModel.problemType);
                                  //   print("problemsList${problemsList.length}");
                                  //    problemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                  //   currentCustomerProblemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                  //
                                  //   print("problemsList${problemsList.length}");
                                  //   problemsList.add(problemModel);
                                  //   currentCustomerProblemsList.add(problemModel);
                                  //   await CustomersFirestoreRpository.uploadProblems(uid,
                                  //
                                  //       currentCustomerProblemsList ,merge: false);
                                  //   await CustomersFirestoreRpository.uploadAllProblems("", problemsList, merge: false);
                                  //
                                  //   return;
                                  // } ,
                                  dismissOnTouchOutside: true).show();

                            },
                            isAgreeToDateonPress: (){
                            // if maintenance need pricing visit
                            if(beforePendingProblemsList[index].isMaintenanceRespondedtoNeedPricing &&
                                beforePendingProblemsList[index].IsNeedRepricing
                            )
                              {
                              AwesomeDialog(context: context ,
                              body: Column(
                                children: [
                                  Text("Maintenance team need you to \n choose date for pricing visit"),
                                  MyCustomTextField(
                                    onSave: (String? value){

                                      repricingDate =value!;
                                      repricingDate= datePricingTextEditingController.text;
                                    },
                                    icon: Icons.timelapse_outlined,
                                    hint: "choose date for visit Pricing",
                                    validator: (String? value){
                                      if(value == null ||value.isEmpty || value.length <3){
                                        return "choose date for visit Pricing";
                                      }
                                    },
                                    onTap: () async{
                                      var date = await  showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate:DateTime.now() ,
                                        lastDate: DateTime(now.year, now.month , now.day+7),
                                      );
                                      if(date != null) {

                                        String formattedDate =DateFormat("yyyy-MM-dd").format(date);
                                        repricingDate=formattedDate;

                                        datePricingTextEditingController.text=formattedDate;
                                        //textContollersList.add(TextEditingController(text:formattedDate ));
                                      }
                                    },

                                    textEditingController: datePricingTextEditingController,
                                  ),
                                ],
                              ),
                                btnOkOnPress: () async{
                                  final ProblemModel problemModel=beforePendingProblemsList[index] ;
                                  problemModel.datePricing=repricingDate;
                                  final currentIndex=problemsList.indexWhere((item)=>item.id==problemModel.id);
                                  problemsList[currentIndex]=problemModel;

                                  await CustomersFirestoreRpository.uploadAllProblems
                                    ("", problemsList, merge: false).then((v){
                                      AwesomeDialog(context: context ,
                                      title: "you will get visit on date",
                                        btnOkOnPress: (){
                                        return;
                                        }
                                      ).show();
                                  });
                                }
                              ).show();
                              }

                            if(beforePendingProblemsList[index].solvingDate.length>3 &&
                                beforePendingProblemsList[index].isPaid==false
                                &&beforePendingProblemsList[index].isAgreeToSolvingDate==false &&
                                beforePendingProblemsList[index].isCustomerRespondedtoSolvingDate==true
                                &&(beforePendingProblemsList[index].requiredDateFromCustomer==
                                    beforePendingProblemsList[index].solvingDate)
                            ){

                                final ProblemModel problemModel=beforePendingProblemsList[index] ;
                                problemModel.isAgreeToSolvingDate=true;
                                problemModel.waitingForCustomerToAgreeForSolvingDate=false;
                                problemModel.isCustomerRespondedtoSolvingDate=true;

                                AwesomeDialog(context: context,
                                  title: "pay ${beforePendingProblemsList[index].price}",
                                  dialogType: DialogType.info,
                                  desc: "Please Pay ${problemModel.price}",
                                  btnOkOnPress: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (BuildContext context) {
                                          return PaymentView(price: problemModel.price,problemModel: problemModel,
                                            problemsList:problemsList, currentCustomerProblemList: currentCustomerProblemsList,
                                            customerId: uid,
                                          ) ;
                                        }));
                                  },
                                ).show();
                                // currentCustomerProblemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                // problemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                // await CustomersFirestoreRpository.uploadProblems(uid,
                                //
                                //     currentCustomerProblemsList ,merge: false);
                                // await CustomersFirestoreRpository.uploadAllProblems("", problemsList, merge: false);

                                return;

                            }
                            if(beforePendingProblemsList[index].isMaintenanceRespondedtoNeedPricing==true &&
                                beforePendingProblemsList[index].IsNeedRepricing==false
                            )
                              {AwesomeDialog(context: context ,
                                  dialogType:DialogType.question ,
                                  title: "solving date ${beforePendingProblemsList[index].solvingDate}",
                                  desc:"Do you agree to solving Date" ,
                                  btnCancelText: "No",
                                  btnCancelOnPress: (){

                                    AwesomeDialog(context: context,
                                        dialogType: DialogType.info,
                                        title: "thanks",
                                        desc: "choose another date",

                                        btnOkOnPress: () async{
                                          final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
                                          if (connectivityResult.contains(ConnectivityResult.none)) {
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (con){
                                              return FMHomeBarscreen();
                                            }));
                                            return ;
                                          }else{
                                            try{
                                              if(requiredDateFromCustomer.length>8){
                                                beforePendingProblemsList[index].isAgreeToSolvingDate=false;
                                                beforePendingProblemsList[index].requiredDateFromCustomer=requiredDateFromCustomer;
                                                final ProblemModel problemModel=beforePendingProblemsList[index] ;

                                                // currentCustomerProblemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                                //problemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                                // problemModel.isAgreeToSolvingDate=false;

                                                problemModel.waitingForCustomerToAgreeForSolvingDate=false;
                                                problemModel.isCustomerRespondedtoSolvingDate=true;
                                                final currentIndex=problemsList.indexWhere((item)=>item.id==problemModel.id);
                                                problemsList[currentIndex]=problemModel;
                                                //problemsList.add(problemModel);
                                                //currentCustomerProblemsList.add(problemModel);

                                                // await CustomersFirestoreRpository.uploadProblems(uid,
                                                //
                                                //     problemsList ,merge: false);
                                                await CustomersFirestoreRpository.uploadAllProblems
                                                  ("", problemsList, merge: false).then((x){

                                                });

                                                AwesomeDialog(context: context,
                                                    title: "you will get reply soon",
                                                    btnOkOnPress: (){return;},
                                                    dismissOnTouchOutside: true
                                                ).show();
                                                return;
                                              }
                                              else{

                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  // behavior: SnackBarBehavior.floating,
                                                  // shape: RoundedRectangleBorder(
                                                  //   side: BorderSide(color: Colors.amberAccent, width: 2),
                                                  //   borderRadius: BorderRadius.circular(24),
                                                  // ),
                                                  // backgroundColor: Colors.amberAccent,
                                                  duration: Duration(milliseconds: 3000),
                                                  // dismissDirection: DismissDirection.up,
                                                  content: Text("please choose another date"
                                                    , style: TextStyle(color: Colors.white),) ,
                                                ));
                                                ScaffoldMessenger.of(context).clearSnackBars();
                                              }
                                            }
                                            on FirebaseAuthException catch(error){
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                // behavior: SnackBarBehavior.floating,
                                                // shape: RoundedRectangleBorder(
                                                //   side: BorderSide(color: Colors.amberAccent, width: 2),
                                                //   borderRadius: BorderRadius.circular(24),
                                                // ),
                                                // backgroundColor: Colors.amberAccent,
                                                duration: Duration(milliseconds: 3000),
                                                // dismissDirection: DismissDirection.up,
                                                content: Text("${error.message.toString()}"
                                                  , style: TextStyle(color: Colors.white),) ,
                                              ));
                                              ScaffoldMessenger.of(context).clearSnackBars();
                                            }catch(e ){
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                // behavior: SnackBarBehavior.floating,
                                                // shape: RoundedRectangleBorder(
                                                //   side: BorderSide(color: Colors.amberAccent, width: 2),
                                                //   borderRadius: BorderRadius.circular(24),
                                                // ),
                                                // backgroundColor: Colors.amberAccent,
                                                duration: Duration(milliseconds: 3000),
                                                // dismissDirection: DismissDirection.up,
                                                content: Text("${e.toString()}"
                                                  , style: TextStyle(color: Colors.white),) ,
                                              ));
                                              ScaffoldMessenger.of(context).clearSnackBars();
                                              rethrow;

                                            }
                                          }


                                        },
                                        body: MyCustomTextField(onSave: (value){
                                          requiredDateFromCustomer=value!;
                                          requiredDateFromCustomer=requiredDateFromCustomerController.text;
                                        },
                                            onTap:() async{
                                              var date = await  showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate:DateTime.now() ,
                                                lastDate: DateTime(now.year, now.month , now.day+7),
                                              );
                                              if(date != null) {

                                                String formattedDate =DateFormat("yyyy-MM-dd").format(date);
                                                requiredDateFromCustomer=formattedDate;

                                                requiredDateFromCustomerController.text=formattedDate;

                                              }
                                            } ,
                                            textEditingController: requiredDateFromCustomerController,
                                            icon: Icons.date_range,
                                            hint: "choose required date", validator:(value){
                                              if(value!.length<3){
                                                return "please choose date";
                                              }
                                            }),
                                        dismissOnTouchOutside: false
                                    ).show();
                                    // beforePendingProblemsList[index].isAgreeToSolvingDate=false;
                                    // beforePendingProblemsList[index].requiredDateFromCustomer=requiredDateFromCustomer;
                                    // final ProblemModel problemModel=beforePendingProblemsList[index] ;
                                    // currentCustomerProblemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                    // problemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                    // // problemModel.isAgreeToSolvingDate=false;
                                    // problemModel.waitingForCustomerToAgreeForSolvingDate=false;
                                    // problemModel.isCustomerRespondedtoSolvingDate=true;
                                    // problemsList.add(problemModel);
                                    // currentCustomerProblemsList.add(problemModel);
                                    //
                                    // // Future.delayed(Duration(seconds: 5),
                                    // //         () {
                                    // //
                                    // //     }
                                    // // );
                                    //
                                    // return;
                                  },
                                  btnOkOnPress: () async {
                                    final ProblemModel problemModel=beforePendingProblemsList[index] ;
                                    problemModel.isAgreeToSolvingDate=true;
                                    problemModel.waitingForCustomerToAgreeForSolvingDate=false;
                                    problemModel.isCustomerRespondedtoSolvingDate=true;

                                    AwesomeDialog(context: context,
                                      title: "pay ${beforePendingProblemsList[index].price}",
                                      dialogType: DialogType.info,
                                      desc: "Please Pay ${problemModel.price}",
                                      btnOkOnPress: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (BuildContext context) {
                                              return PaymentView(price: problemModel.price,problemModel: problemModel,
                                                problemsList:problemsList, currentCustomerProblemList: currentCustomerProblemsList,
                                                customerId: uid,
                                              ) ;
                                            }));
                                      },
                                    ).show();
                                    // currentCustomerProblemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                    // problemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                    // await CustomersFirestoreRpository.uploadProblems(uid,
                                    //
                                    //     currentCustomerProblemsList ,merge: false);
                                    // await CustomersFirestoreRpository.uploadAllProblems("", problemsList, merge: false);

                                    return;
                                  },
                                  // async{
                                  //   final ProblemModel problemModel=beforePendingProblemsList[index] ;
                                  //   problemModel.isCompleted=true;
                                  //   problemModel.isPending=false;
                                  //   print(problemModel.problemType);
                                  //   print("problemsList${problemsList.length}");
                                  //    problemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                  //   currentCustomerProblemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                                  //
                                  //   print("problemsList${problemsList.length}");
                                  //   problemsList.add(problemModel);
                                  //   currentCustomerProblemsList.add(problemModel);
                                  //   await CustomersFirestoreRpository.uploadProblems(uid,
                                  //
                                  //       currentCustomerProblemsList ,merge: false);
                                  //   await CustomersFirestoreRpository.uploadAllProblems("", problemsList, merge: false);
                                  //
                                  //   return;
                                  // } ,
                                  dismissOnTouchOutside: true).show();}
                            }
                            ,),
                        // ListTile(title: Text("${beforePendingProblemsList[index].problemDate}"),
                        //   trailing: IconButton(onPressed:
                        //       () {
                        //     AwesomeDialog(context: context ,
                        //     btnOkOnPress: ()async{
                        //       final ProblemModel problemModel=beforePendingProblemsList[index] ;
                        //       problemModel.isCompleted=true;
                        //       problemModel.isPending=false;
                        //       print(problemModel.problemType);
                        //       print("problemsList${problemsList.length}");
                        //        problemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                        //       currentCustomerProblemsList.removeWhere((item)=>item.id==beforePendingProblemsList[index].id);
                        //
                        //       print("problemsList${problemsList.length}");
                        //       problemsList.add(problemModel);
                        //       currentCustomerProblemsList.add(problemModel);
                        //       await CustomersFirestoreRpository.uploadProblems(uid,
                        //
                        //           currentCustomerProblemsList ,merge: false);
                        //       await CustomersFirestoreRpository.uploadAllProblems("", problemsList, merge: false);
                        //
                        //       return;
                        //     } ,
                        //     dismissOnTouchOutside: true).show();
                        //   }
                        //   ,
                        //       icon: Icon(Icons.reorder)),
                        //
                        // ),
                      ):[
                SizedBox(height:300 ,),
                        Center(child: Text("No orders"),)
              ]
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                      children:
                      List.generate(pendingProblemsList.length, (index)
                      {
                        // MyBadge(number: 0, increaseNumber: 0, listLenght:
                        // pendingProblemsList.length, update: true,);
                        return  pendingProblemsList.length >0 ?OperatorProblemCard(Pending: true,solved: false,
                          onPressWhenPending: (){
                            AwesomeDialog(context: context ,
                                btnCancelText: "No",
                                btnOkText: "Yes",
                                btnCancelOnPress: () async{
                                  final ProblemModel problemModel=pendingProblemsList[index] ;
                                  problemModel.isCompleted=false;
                                  problemModel.waitingCustomerEnsureSolving=false;
                                  problemModel.waitingForCustomerToAgreeForSolvingDate=false;
                                  problemModel.isCustomerRespondedToEnsureSolving=true;
                                  problemModel.waitTechnicianToSolveAfterPending="yes";
                                    final problemModelIndex= problemsList.indexWhere((item)=>item.id==pendingProblemsList[index].id);
                                  problemsList[problemModelIndex]=problemModel;
                                  // problemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                                  // currentCustomerProblemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                                  print("problemsList${problemsList.length}");
                                  // problemsList.add(problemModel);
                                  // currentCustomerProblemsList.add(problemModel);
                                  await CustomersFirestoreRpository.uploadProblems(uid,

                                      problemsList ,merge: false);
                                  await CustomersFirestoreRpository.uploadAllProblems
                                    ("", problemsList, merge: false);
                                     AwesomeDialog(
                                       context: context,
                                       desc: "sorry you will get reply soon",
                                       btnOkOnPress: (){return;},
                                       dismissOnTouchOutside: true

                                     ).show();
                                  return;
                                },
                                btnOkOnPress: ()async{

                                  AwesomeDialog(context: context,
                                    desc: " we care about you \n"
                                        "please give a rating ",
                                    dismissOnTouchOutside: true,
                                    btnCancelOnPress: ()async{
                                      final ProblemModel problemModel=pendingProblemsList[index] ;
                                      problemModel.isCompleted=true;
                                      problemModel.isPending=false;
                                      problemModel.waitingCustomerEnsureSolving=false;
                                      problemModel.solvedByTechnicianAndWaitingCustomerAgree=false;
                                      problemModel.isCustomerRespondedToEnsureSolving=true;
                                      problemModel.waitTechnicianToSolveAfterPending="no";
                                      print(problemModel.problemType);
                                      // problemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                                      // currentCustomerProblemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                                      // print("problemsList${problemsList.length}");
                                      // problemsList.add(problemModel);
                                      // currentCustomerProblemsList.add(problemModel);
                                      final currentIndex=problemsList.indexWhere((item)=>item.id==problemModel.id);
                                      problemsList[currentIndex]=problemModel;
                                      await CustomersFirestoreRpository.uploadProblems(uid,

                                          problemsList ,merge: false);
                                      await CustomersFirestoreRpository.uploadAllProblems
                                        ("", problemsList, merge: false);
                                      await CustomersFirestoreRpository.updateOperatorRating(problemModel.solvedById,

                                          problemModel.rating);
                                      return ;
                                    },
                                    title: "Rating",
                                    dialogType: DialogType.question,
                                    btnOkOnPress: ()async{
                                      final ProblemModel problemModel=pendingProblemsList[index] ;
                                      problemModel.isCompleted=true;
                                      problemModel.isPending=false;
                                      problemModel.waitingCustomerEnsureSolving=false;
                                      problemModel.solvedByTechnicianAndWaitingCustomerAgree=false;
                                      problemModel.isCustomerRespondedToEnsureSolving=true;
                                      problemModel.waitTechnicianToSolveAfterPending="no";
                                      problemModel.rating=barRating.toString();
                                      problemModel.badRatingReason= badRatingReason;
                                      print(problemModel.problemType);
                                      // problemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                                      // currentCustomerProblemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                                      // print("problemsList${problemsList.length}");
                                      // problemsList.add(problemModel);
                                      // currentCustomerProblemsList.add(problemModel);
                                      final currentIndex=problemsList.indexWhere((item)=>item.id==problemModel.id);
                                      problemsList[currentIndex]=problemModel;
                                      await CustomersFirestoreRpository.uploadProblems(uid,

                                          problemsList ,merge: false);
                                      await CustomersFirestoreRpository.uploadAllProblems
                                        ("", problemsList, merge: false);
                                      await CustomersFirestoreRpository.updateOperatorRating(problemModel.solvedById,

                                          problemModel.rating);

                                      return ;
                                    },
                                    body: StatefulBuilder(builder: (BuildContext context,
                                        void Function(void Function()) setState) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text("Rating $barRating"),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                setState(()=> barRating=rating);
                                              },
                                              updateOnDrag: true,
                                            ),
                                            barRating<3.0
                                                ?
                                            Column(children: [
                                              Text("please tell us what do you dislike?"),
                                              MyCustomTextField(onSave: (value){
                                                badRatingReason=value!;
                                              },
                                                  icon:Icons.rate_review ,
                                                  hint: "what do you dislike",
                                                  validator: (value){}),
                                            ],)
                                                :
                                            Container(),

                                          ],
                                        ),
                                      );;

                                    },),

                                  ).show();
                                  return;
                                } ,
                                dialogType: DialogType.question,
                                desc: 'Do you ensure solving ',
                                dismissOnTouchOutside: true).show();
                          },
                          isAgreeToDateonPress: (){

                          },
                          problemModel:pendingProblemsList[index] ,
                        ):
                        Column(
                          children: [
                            SizedBox(height:300 ,),
                            Center(child: Text("No Pending orders"),),
                          ],
                        )
                        ;
                      }



                        // ListTile(title: Text("${pendingProblemsList[index].problemDate}"),
                        //   trailing: IconButton(onPressed: () {
                        //     AwesomeDialog(context: context ,
                        //         btnOkOnPress: ()async{
                        //           final ProblemModel problemModel=pendingProblemsList[index] ;
                        //           problemModel.isCompleted=true;
                        //           problemModel.isPending=false;
                        //           print(problemModel.problemType);
                        //           problemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                        //           currentCustomerProblemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                        //           print("problemsList${problemsList.length}");
                        //           problemsList.add(problemModel);
                        //           currentCustomerProblemsList.add(problemModel);
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
                ),
                SingleChildScrollView(
                  child: Column(

                      children: completedProblemsList.length>0 ?List.generate(completedProblemsList.length, (index)=>

                          OperatorProblemCard(problemModel:completedProblemsList[index] , onPressWhenPending: () {

                          },
                             isAgreeToDateonPress: (){

                            },
                            Pending: false,solved: true,)
                      ):
                          [
                            SizedBox(height:300 ,),
                            Center(child: Text("No Pending orders"),)]
                  ),
                ),
              ])
                  :

             problemsList.length==0
                 ?
             TabBarView(children: [
               Center(child: Text("no orders"),),
               Center(child: Text("no orders"),),
               Center(child: Text("no orders"),),
             ]
             )
                 :
             TabBarView(children: [
               Center(child: Text("something went wrong"),),
               Center(child: Text("something went wrong"),),
               Center(child: Text("something went wrong"),),
             ]
             )

            );
          }
        )
    );
  }
}
