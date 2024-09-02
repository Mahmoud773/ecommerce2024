import 'package:amazon/Facility_Manager/Add_problem_screen.dart';
import 'package:amazon/Facility_Manager/customer_repository/customer_firestore_repository.dart';
import 'package:amazon/Facility_Manager/models/Customer_model.dart';
import 'package:amazon/Facility_Manager/models/Problem_model.dart';
import 'package:amazon/Facility_Manager/widgets/customer_problem_card.dart';
import 'package:amazon/Facility_Manager/widgets/show_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'My_Problems_screen.dart';
import 'package:showcaseview/showcaseview.dart';


class FacilityHomeScreen extends StatefulWidget {
  CustomerModel? customerModel;
   FacilityHomeScreen({   super.key , this.customerModel});

  @override
  State<FacilityHomeScreen> createState() => _FacilityHomeScreenState();
}

class _FacilityHomeScreenState extends State<FacilityHomeScreen> {
  final  user = FirebaseAuth.instance.currentUser;

//   late CustomerModel customerModel;
// void getCurrentCustomer() async{
//    customerModel =await CustomersFirestoreRpository.getCertaincustomer(user!.uid);
//  }

@override
  void initState() {
 // getCurrentCustomer();
    super.initState();
  }

  var firstItem="تكنولوجيا المعلومات It";
  var secondItem="مدنى Civil";
  var thirdItem="تكييف AC";
  var fourthItem="كهرباء Electricity";
  var fifthItem="سباكة Plumbing";
  var sixItem=" H.K";
  var seventhItem="L.C";

  final List<Map<String, dynamic>> _listItem = [
    {"image": 'assets/FMimages/aircondition.jpg', "problemType": "تكييف AC"},
    {"image": 'assets/FMimages/it.jpg', "problemType": "تكنولوجيا المعلومات It"},
    {"image": 'assets/FMimages/electricity1.jpg', "problemType": "كهرباء Electricity"},

    {"image": 'assets/FMimages/civil.jpg', "problemType": "مدنى Civil"},
    {"image": 'assets/FMimages/lc1.jpg', "problemType": "L.C"},
    {"image": 'assets/FMimages/plumbing.jpg', "problemType": "سباكة Plumbing"},
    {"image": 'assets/FMimages/HK.JPG', "problemType": "H.K"},

  ];

List<ProblemModel> pendingList=[];
  List<ProblemModel> problemsList=[];

  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();

  int pendingListLength=0;

  @override
  Widget build(BuildContext context) {

    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    final uid = user!.uid;
    return   Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu),
        title: Row(
          children: [
            Text("Home"),
            // ShowCaseWidget(
            //     key: _one,
            // description: "you have pending problems",
            //   builder : (context) => Text("pending"),),
          ],
        ),
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:
              (context) {
                return AddProblemScreen(
                  // customerModel: customerModel,
                  problemType: "",);
              }));
            },
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                width: 36,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Icon(Icons.add , color: Colors.white,)),
              ),
            ),
          ) ,

        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height,
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage('assets/images/one.jpg'),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(.4),
                              Colors.black.withOpacity(.2),
                            ]
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Work Order", style: TextStyle(color: Colors.deepPurple,
                            fontSize: 35, fontWeight: FontWeight.bold),),
                        SizedBox(height: 30,),
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                          ),
                          child: Center(child: Text("Hello",
                            style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)),
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 320,
                  child: GridView.count(
                    physics: ScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0,
                    children: _listItem.map((item) =>
                       InkWell(
                           onTap: (){
                             Navigator.push(context,
                             MaterialPageRoute(builder: (context) {
                               return AddProblemScreen(
                                 // customerModel: customerModel,
                                 problemType:item["problemType"] ,);
                             })
                             );
                           },
                           child: ProblemCard(item: item))
                    )
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
