
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../customer_repository/customer_firestore_repository.dart';
import '../models/Problem_model.dart';

class OperatorsHomeScreen extends StatefulWidget {
  const OperatorsHomeScreen({super.key});

  @override
  State<OperatorsHomeScreen> createState() => _OperatorsHomeScreenState();
}

class _OperatorsHomeScreenState extends State<OperatorsHomeScreen> {
  bool _updating=false;
  bool isChecked=false;
  List<ProblemModel> problemsList=[];
  List<ProblemModel> pendingProblemsList=[];
  List<ProblemModel> completedProblemsList=[];

  @override
  Widget build(BuildContext context) {
    problemsList=[];
    pendingProblemsList=[];
    completedProblemsList=[];
    List list7=[];
    return  DefaultTabController(length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Orders"),
            bottom: TabBar(tabs: [
              Tab(icon: Row(
                children: [
                  Text("pending"),
                  Icon(Icons.pending),
                ],
              ),),
              Tab(icon: Row(
                children: [
                  Text("completed"),
                  Icon(Icons.incomplete_circle_outlined),
                ],
              ),)
            ]),
          ),
          body: StreamBuilder(
              stream: CustomersFirestoreRpository.getAllCustomerAppointsAsSgtream(),
              builder: (context, snapshot) {

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.hasData && snapshot.data!.exists ){

                   list7 =snapshot.data!.data()!["appointsDays"];
                  print(list7);
                  print(list7.length);

                  for(var doc =0 ; doc<snapshot.data!.data()!["appointsDays"].length;doc++ ){
                    // var data = doc.data() ;
                   print(doc);
                    problemsList.add(ProblemModel.fromJson(list7[doc]));
                    print("problemsList.length${problemsList.length}");
                  }
                   for(var p = 0;p < problemsList.length ;p++){
                     if(problemsList[p].isCompleted==false){
                       pendingProblemsList.add(problemsList[p]);
                     }if(problemsList[p].isCompleted==true){
                       completedProblemsList.add(problemsList[p]);
                     }
                   }
                  return TabBarView(children: [
                    Column(
                        children:
                        List.generate(pendingProblemsList.length, (index)=>
                            ListTile(title: Text("${pendingProblemsList[index].problemDate}"),
                             trailing: Checkbox(value: pendingProblemsList[index].isCompleted,
                                 onChanged: (val) async{
                                   pendingProblemsList[index].isCompleted=!pendingProblemsList[index].isCompleted;
                                   final problemId=pendingProblemsList[index].problemBy;
                                   // pendingProblemsList[index].isCompleted==val;
                                   completedProblemsList.add(pendingProblemsList[index]);
                                   pendingProblemsList.removeAt(index);
                                   print("pendingProblemsList.length ${pendingProblemsList.length}");
                                   print("completedProblemsList.length ${completedProblemsList.length}");
                                   try{

                                     problemsList=[];
                                     problemsList=pendingProblemsList+completedProblemsList;
                                     await CustomersFirestoreRpository.
                                     uploadAllProblems(problemId,
                                         problemsList, merge: true).then((v){
                                       _updating=false;
                                       ScaffoldMessenger.of(context).clearSnackBars();
                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                         // behavior: SnackBarBehavior.floating,
                                         // shape: RoundedRectangleBorder(
                                         //   side: BorderSide(color: Colors.amberAccent, width: 2),
                                         //   borderRadius: BorderRadius.circular(24),
                                         // ),
                                         // backgroundColor: Colors.amberAccent,
                                         duration: Duration(milliseconds: 4000),
                                         // dismissDirection: DismissDirection.up,
                                         content: Text("notification will be sent to customer}"
                                           , style: TextStyle(color: Colors.white),) ,
                                       ));
                                       //problemsList[index].isCompleted=val!;
                                       setState(() {

                                       });

                                     });
                                   }catch(e){
                                     _updating=false;
                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                         // behavior: SnackBarBehavior.floating,
                                         // shape: RoundedRectangleBorder(
                                         //   side: BorderSide(color: Colors.amberAccent, width: 2),
                                         //   borderRadius: BorderRadius.circular(24),
                                         // ),
                                         // backgroundColor: Colors.amberAccent,
                                         duration: Duration(milliseconds: 4000),
                                         // dismissDirection: DismissDirection.up,
                                         content: Text("some thing wrong , please try again}"
                                           , style: TextStyle(color: Colors.white),) ,
                                       ));
                                   }

                                 }
                                 , checkColor: Colors.indigo,),
                            ),)
                    ),
                    Column(
                        children: List.generate(completedProblemsList.length, (index)=>
                            ListTile(title: Text("${completedProblemsList[index].problemDate}"),
                              trailing: Checkbox(value: completedProblemsList[index].isCompleted,
                                    onChanged: (val) async{
                                      completedProblemsList[index].isCompleted=!completedProblemsList[index].isCompleted;
                                      final problemId=completedProblemsList[index].problemBy;
                                      // pendingProblemsList[index].isCompleted==val;
                                      pendingProblemsList.add(completedProblemsList[index]);
                                      completedProblemsList.removeAt(index);
                                      print("pendingProblemsList.length ${completedProblemsList.length}");
                                      print("completedProblemsList.length ${completedProblemsList.length}");

                                      try{

                                        problemsList=[];
                                        problemsList=pendingProblemsList+completedProblemsList;
                                        await CustomersFirestoreRpository.
                                        uploadAllProblems(problemId,
                                            problemsList, merge: true).then((v){
                                          _updating=false;
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            // behavior: SnackBarBehavior.floating,
                                            // shape: RoundedRectangleBorder(
                                            //   side: BorderSide(color: Colors.amberAccent, width: 2),
                                            //   borderRadius: BorderRadius.circular(24),
                                            // ),
                                            // backgroundColor: Colors.amberAccent,
                                            duration: Duration(milliseconds: 4000),
                                            // dismissDirection: DismissDirection.up,
                                            content: Text("the order now is pending}"
                                              , style: TextStyle(color: Colors.white),) ,
                                          ));
                                          //problemsList[index].isCompleted=val!;
                                          setState(() {

                                          });

                                        });
                                      }catch(e){
                                        _updating=false;
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          // behavior: SnackBarBehavior.floating,
                                          // shape: RoundedRectangleBorder(
                                          //   side: BorderSide(color: Colors.amberAccent, width: 2),
                                          //   borderRadius: BorderRadius.circular(24),
                                          // ),
                                          // backgroundColor: Colors.amberAccent,
                                          duration: Duration(milliseconds: 4000),
                                          // dismissDirection: DismissDirection.up,
                                          content: Text("some thing wrong , please try again}"
                                            , style: TextStyle(color: Colors.white),) ,
                                        ));
                                      }

                                    },
                checkColor: Colors.indigo,),
                                    ),
                            ),

                        )
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
