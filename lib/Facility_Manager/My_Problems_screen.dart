

import 'package:amazon/Facility_Manager/customer_repository/customer_firestore_repository.dart';
import 'package:amazon/Facility_Manager/models/Problem_model.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import '../consts/colors.dart';
import '../consts/fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:badges/badges.dart' as badges;
class MyProblemsScreen extends StatefulWidget {
  final String doctorId;
  List<DayTimeDetails>? list8;

  MyProblemsScreen({Key? key , required this.doctorId  , this.list8}) : super(key: key);
  // final _customViewKey = GlobalKey<>();
  @override
  State<MyProblemsScreen> createState() => _MyProblemsScreenState();
}

class _MyProblemsScreenState extends State<MyProblemsScreen> {

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
        child: Scaffold(
          appBar: AppBar(
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
                  StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {

                    // return badgeNumber>0 ?
                     return badges.Badge(
                      badgeContent: Text('${pendingProblemsList.length}'),
                      child: Icon(Icons.pending),
                      position: badges.BadgePosition.topEnd(top: -10, end: -12),
                       showBadge:pendingProblemsList.length>0 ?true : false ,
                    );
                        // : Icon(Icons.pending);
                  }, )
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
          body: StreamBuilder(
            stream: CustomersFirestoreRpository.getAllCustomerAppointsAsSgtream(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
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


                return TabBarView(children: [
                  SingleChildScrollView(
                    child: Column(
                        children: List.generate(beforePendingProblemsList.length, (index)=>

                                    OperatorProblemCard(Pending: false,solved: false,
                    problemModel:beforePendingProblemsList[index] ,
                                      onPressWhenPending:
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

                                    }, isAgreeToDateonPress: () {  }
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
                        )
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children:
                      List.generate(pendingProblemsList.length, (index)
                            {
                              // MyBadge(number: 0, increaseNumber: 0, listLenght:
                              // pendingProblemsList.length, update: true,);
                              return OperatorProblemCard(Pending: true,solved: false,
                                onPressWhenPending: (){
                                  AwesomeDialog(context: context ,
                                      btnCancelOnPress: (){
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

                                            print(problemModel.problemType);
                                            problemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                                            currentCustomerProblemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                                            print("problemsList${problemsList.length}");
                                            problemsList.add(problemModel);
                                            currentCustomerProblemsList.add(problemModel);
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
                                            problemModel.rating=barRating.toString();
                                            print(problemModel.problemType);
                                            problemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                                            currentCustomerProblemsList.removeWhere((item)=>item.id==pendingProblemsList[index].id);
                                            print("problemsList${problemsList.length}");
                                            problemsList.add(problemModel);
                                            currentCustomerProblemsList.add(problemModel);
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
                                                    MyCustomTextField(onSave: (value){},
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
                                problemModel:pendingProblemsList[index], isAgreeToDateonPress: () {  } ,
                              );
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
                        children: List.generate(completedProblemsList.length, (index)=>

                        OperatorProblemCard(problemModel:completedProblemsList[index] , onPressWhenPending: () {

                        },
                          Pending: false,solved: true, isAgreeToDateonPress: () {  },)
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
             if(problemsList.isEmpty){
               return TabBarView(children: [
                 Center(child: Text("something went wrong"),),
                 Center(child: Text("something went wrong"),),
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
