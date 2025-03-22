
import 'package:amazon/Facility_Manager/operators/operator_problem_details.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../customer_repository/customer_firestore_repository.dart';
import '../models/Problem_model.dart';

class OperatorsHomeScreen22 extends StatefulWidget {
  const OperatorsHomeScreen22({super.key});

  @override
  State<OperatorsHomeScreen22> createState() => _OperatorsHomeScreen22State();
}

class _OperatorsHomeScreen22State extends State<OperatorsHomeScreen22> {
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
    return  Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: StreamBuilder(
          stream: CustomersFirestoreRpository.getAllCustomerAppointsAsSgtream(),
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            problemsList=[];
            list7=[];
            if(snapshot.hasData && snapshot.data!.exists ){

              list7 =snapshot.data!.data()!["appointsDays"];
              print(list7);
              print(list7.length);
              problemsList=[];
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
              return GridView.count(crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              children: problemsList.map((item) => Card(
                color: Colors.transparent,
                elevation: 0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      // image: DecorationImage(
                      //     image: AssetImage(),
                      //     fit: BoxFit.cover
                      // )
                  ),
                  child: Transform.translate(
                    offset: Offset(55, -58),
                    child: Container(
                      width: 30,
                      // height: 30,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(),
                      child: Center(
                        child: MaterialButton(
                          onPressed: () {
                           Navigator.push(context,
                           MaterialPageRoute(builder: (context){
                             return OperatorProblemDetails(problemModel: item,problemsList: problemsList,);
                           }));
                          },
                          color: Colors.white,
                          height: 35,
                          minWidth: 40,
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text("${item.problemType}")
                          //
                          // Icon( ? Icons.bookmark :
                          // Icons.bookmark_border, size: 22, color: item["isSaved"] ?
                          // Colors.yellow[700] : Colors.black),
                        ),
                      ),
                    ),
                    // child: InkWell(
                    //   onLongPress: () {},
                    //   child: Container(
                    //     margin: EdgeInsets.symmetric(horizontal:70, vertical: 71),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(8),
                    //       color: Colors.white
                    //     ),
                    //     child: Icon(Icons.bookmark_border, size: 22,),
                    //   ),
                    // ),
                  ),
                ),
              )).toList(),);
            }

            if (snapshot.hasError) {
              return Center(child: Text("something went wrong"),);
            }
            if(problemsList.isEmpty){
              return Center(child: Text("no orders Yet"),);
            }
            else
              return Center(child: Text("no orders Yet"),);
          }
      ),
    );
  }
}
