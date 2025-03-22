
import 'package:amazon/Facility_Manager/models/Problem_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../res/components/custom_button.dart';
final List<Map<String, dynamic>> _listItem = [
  {"image": 'assets/FMimages/aircondition.jpg', "problemType": "تكييف AC"},
  {"image": 'assets/FMimages/civil.jpg', "problemType": "مدنى Civil"},
  {"image": 'assets/FMimages/electricity1.jpg', "problemType": "كهرباء Electricity"},

  {"image": 'assets/FMimages/lc1.jpg', "problemType": "L.C نيار خفيف"},
  {"image": 'assets/FMimages/plumbing.jpg', "problemType": "سباكة Plumbing"},
  {"image": 'assets/FMimages/HK.JPG', "problemType": " H.K"},
  {"image": 'assets/FMimages/it.jpg', "problemType": "تكنولوجيا المعلومات It"},

];

var item1 ='assets/FMimages/aircondition.jpg';
var item2 ='assets/FMimages/aircondition.jpg';
var item3 ='assets/FMimages/aircondition.jpg';
var item4='assets/FMimages/aircondition.jpg';
var item5 ='assets/FMimages/aircondition.jpg';
var item6 ='assets/FMimages/aircondition.jpg';
var item7 ='assets/FMimages/aircondition.jpg';
class ProblemCard extends StatefulWidget {
  final dynamic item;
  const ProblemCard({super.key, required this.item});

  @override
  State<ProblemCard> createState() => _ProblemCardState();
}

class _ProblemCardState extends State<ProblemCard> {
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // image: DecorationImage(
            //     image: AssetImage(widget.item["image"]),
            //     fit: BoxFit.cover,
            // )
        ),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // image: DecorationImage(
                  //     image: AssetImage(widget.item["image"]),
                  //     fit: BoxFit.cover,
                  // )
                ),
                child: ClipRRect (
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  child: Image(image: AssetImage(widget.item["image"]),  fit: BoxFit.cover,
                   
                  width: width*45/100,),
                ),
            width:width*45/100 ,
              height: 120,
            ),
            Container(
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: Colors.white
              // ),
              color: Colors.deepPurple.withOpacity(0.3),
              padding: EdgeInsets.only(left: 20, top:widget.item["problemType"]=="تكنولوجيا المعلومات It"? 5:0),
              width: width*45/100, //       decoration:
              //            BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              // color: Colors.white
              // ),
              child: Text(widget.item["problemType"], style: TextStyle(fontWeight: FontWeight.bold
              ,color: Colors.white ,fontSize: widget.item["problemType"]=="تكنولوجيا المعلومات It" ?13 :15),),
            ),

          ],
        ),
        // child:
        // Transform.translate(
        //   offset: Offset(-20, 50),
        //   child: Container(
        //     width: 100,
        //     // height: 30,
        //     clipBehavior: Clip.hardEdge,
        //     decoration: BoxDecoration(),
        //     child: Center(
        //       child: MaterialButton(
        //         onPressed: () {
        //         },
        //         color: Colors.grey.withOpacity(0.3),
        //         height: 35,
        //         minWidth: 120,
        //         padding: EdgeInsets.all(0),
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(8)
        //         ),
        //         child: Text("${widget.item["problemType"]}" ,
        //           style: TextStyle(
        //               fontSize: 22, color:  Colors.white
        //         ),)
        //         //Icon(Icons.bookmark , size: 22, color:  Colors.yellow[700]),
        //       ),
        //     ),
        //   ),
        //   // child: InkWell(
        //   //   onLongPress: () {},
        //   //   child: Container(
        //   //     margin: EdgeInsets.symmetric(horizontal:70, vertical: 71),
        //   //     decoration: BoxDecoration(
        //   //       borderRadius: BorderRadius.circular(8),
        //   //       color: Colors.white
        //   //     ),
        //   //     child: Icon(Icons.bookmark_border, size: 22,),
        //   //   ),
        //   // ),
        // ),
      ),
    );
  }
}

class OperatorProblemCard extends StatefulWidget {
    Function() onPressWhenPending;
    Function() isAgreeToDateonPress;
  final ProblemModel problemModel;
  bool Pending;
  bool solved;
   OperatorProblemCard({super.key,  required this.problemModel , required this.onPressWhenPending ,
     required this.Pending, required this.solved,required this.isAgreeToDateonPress });

  @override
  State<OperatorProblemCard> createState() => _OperatorProblemCardState();
}

class _OperatorProblemCardState extends State<OperatorProblemCard> {
  final now=DateTime.now();
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    final nowToString=DateFormat("yyyy-MM-dd").format(now);
    print(nowToString);
    print(widget.problemModel.datePricing);
    return Container(
      // width: double.infinity,
      // height: 190,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey.withOpacity(0.9)
        // image: DecorationImage(
        //     image: AssetImage('assets/images/one.jpg'),
        //     fit: BoxFit.cover
        // )
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(backgroundImage:  AssetImage(getImagePath(widget.problemModel)),
                    radius: 30,
                  ),
                ),
                Padding(padding: EdgeInsets.all(5) ,
                  child: Container(
                    width: width*60/100,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5,),
                        Text("order No: ${widget.problemModel.number}", style: TextStyle(
                            color: Colors.deepPurple, fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 5,),
                        Text("order date: ${widget.problemModel.problemDate.substring(0,11)}",
                          style: TextStyle(
                              color: Colors.deepPurple, fontWeight: FontWeight.bold
                          ),),
                        SizedBox(height: 5,),
                        // Text("solving time: ${widget.problemModel.problemtime.substring(10,15)}",
                        //   style: TextStyle(
                        //       color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
                        //   ),),
                        // SizedBox(height: 5,),
                        Text("Unit No: ${widget.problemModel.unitNumber}",
                          style: TextStyle(
                              color: Colors.deepPurple, fontWeight: FontWeight.bold
                          ),),
                        //SizedBox(height: 5,),
                        Text("mall Name: ${widget.problemModel.mallName}",
                          style: TextStyle(
                              color: Colors.deepPurple, fontWeight: FontWeight.bold
                          ),),
                        if(widget.problemModel.solvingDate.length<3 &&widget.problemModel.isPaid==false
                            &&widget.problemModel.isAgreeToSolvingDate==false &&
                            widget.problemModel.isCustomerRespondedtoSolvingDate==false
                            &&widget.problemModel.isMaintenanceRespondedtoNeedPricing==true &&
                            widget.problemModel.IsNeedRepricing==true &&
                            widget.problemModel.datePricing.length <3
                        )
                          Row(
                            children: [
                              Icon(Icons.notifications_active,  color: Colors.yellowAccent,),
                              Text(
                                "we need a visit for pricing",
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellowAccent
                                ),
                              ),
                            ],
                          ),
                        if(widget.problemModel.datePricing.length>3 &&widget.problemModel.solvingDate.length<3)
                          Row(
                            children: [
                              Icon(Icons.notifications_active_sharp , color: Colors.yellowAccent,),
                              Text("pricing date: ${widget.problemModel.datePricing}",
                                style: TextStyle(
                                  color: Colors.yellowAccent, fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),),
                            ],
                          ),
                        if(widget.problemModel.solvingDate.length>3
                        &&widget.problemModel.requiredDateFromCustomer.length<3
                        )
                          Row(
                            children: [
                              Icon(Icons.notifications_active,  color: Colors.yellowAccent,),
                              Text(
                                "solving date: ${widget.problemModel.solvingDate}",
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellowAccent
                                ),
                              ),
                            ],
                          ),
                        if(widget.problemModel.solvingDate.length>3
                            &&widget.problemModel.requiredDateFromCustomer.length>3&&
                            widget.problemModel.solvingDate!=widget.problemModel.requiredDateFromCustomer
                        )
                          Row(
                            children: [
                              Icon(Icons.notifications_active,  color: Colors.yellowAccent,),
                              Text(
                                "required date: ${widget.problemModel.requiredDateFromCustomer}",
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellowAccent
                                ),
                              ),
                            ],
                          ),
                        if((widget.problemModel.solvingDate.length>3&&
                            widget.problemModel.requiredDateFromCustomer.length>3)
                        &&
                        widget.problemModel.solvingDate==widget.problemModel.requiredDateFromCustomer)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.notifications_active,  color: Colors.yellowAccent,),
                              Text(
                                "Maintenance agree to\n required date:"
                                    "${widget.problemModel.requiredDateFromCustomer}",
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellowAccent
                                ),
                              ),
                            ],
                          ),

                        // if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==true
                        //     &&widget.problemModel.isAgreeToSolvingDate==true)
                        //   Padding(
                        //     padding: const EdgeInsets.only(left: 0, ),
                        //     child: Row(
                        //       children: [
                        //         Icon(Icons.notifications_active,  color: Colors.yellowAccent,),
                        //         Padding(
                        //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        //           child: Button(
                        //             height: 40,
                        //             width: 150,
                        //             title: 'waiting solving...',
                        //             onPressed:() {} ,
                        //             disable: false,
                        //           ),
                        //         ),
                        //         //Icon(Icons.pending,  color: Colors.yellowAccent,),
                        //         //Checkbox(value: widget.problemModel.isAgreeToSolvingDate, onChanged: null ,checkColor: Colors.yellowAccent, ),
                        //       ],
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
              ],
            ),


          ),

          // if(widget.problemModel.solvingDate.length>3
          //     &&widget.problemModel.requiredDateFromCustomer.length>3&&
          //     widget.problemModel.solvingDate!=widget.problemModel.requiredDateFromCustomer
          // )
          //   Container(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         SizedBox(height: 10,),
          //         Padding(
          //           padding: const EdgeInsets.only(left: 0, ),
          //           child:SizedBox(
          //             height: 50,
          //             //width: width*60/100,
          //             child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                 backgroundColor: Colors.yellowAccent,
          //                 foregroundColor: Colors.deepPurpleAccent,
          //               ),
          //               onPressed: (){},
          //               child: Row(
          //                 mainAxisSize: MainAxisSize.min,
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Icon(Icons.notifications_active,  color: Colors.deepPurpleAccent,),
          //                   Text(
          //                     "waiting maintenance respond...",
          //                     style: const TextStyle(
          //                       fontSize: 13,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          if(widget.problemModel.solvingDate.length<3 &&widget.problemModel.isPaid==false
              &&widget.problemModel.isAgreeToSolvingDate==false
              && widget.problemModel.isMaintenanceRespondedtoNeedPricing==false &&
              widget.problemModel.IsNeedRepricing==false
          )
            Container(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, ),
                    child:SizedBox(
                      height: 50,
                      width: width*80/100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: (){},
                        child: Row(
                          children: [
                            Icon(Icons.notifications_active,  color: Colors.yellowAccent,),
                            Text(
                              "waiting maintenance respond",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if(widget.problemModel.solvingDate.length<3 &&widget.problemModel.isPaid==false
              &&widget.problemModel.isAgreeToSolvingDate==false &&
              widget.problemModel.isCustomerRespondedtoSolvingDate==false
          &&widget.problemModel.isMaintenanceRespondedtoNeedPricing==true &&
              widget.problemModel.IsNeedRepricing==true && widget.problemModel.datePricing.length <3
          )
            InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, ),
                    child:SizedBox(
                      height: 50,
                      width: 230,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed:  widget.isAgreeToDateonPress,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.question_mark_outlined,  color: Colors.yellowAccent,),
                            SizedBox(width: 5,),
                            Text(
                              "choose pricing date ?",

                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: (){},
            ),

          // cst responded and choose repricing visit date
          if(widget.problemModel.solvingDate.length<3 &&widget.problemModel.isPaid==false
              &&widget.problemModel.isAgreeToSolvingDate==false &&
              widget.problemModel.isCustomerRespondedtoSolvingDate==false
              &&widget.problemModel.isMaintenanceRespondedtoNeedPricing==true &&
              widget.problemModel.IsNeedRepricing==true && widget.problemModel.datePricing.length >3
          )
            InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, ),
                    child:SizedBox(
                      height: 50,
                      width: 230,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: (){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.notifications_active_rounded,  color: Colors.yellowAccent,),
                            SizedBox(width: 5,),
                            if( nowToString!=widget.problemModel.datePricing)
                            Text(
                              "wait pricing visit",

                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if( nowToString==widget.problemModel.datePricing)
                              Text(
                                "pricing visit is today",

                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap:nowToString==widget.problemModel.datePricing ? (){} : widget.isAgreeToDateonPress,
            ),
          if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==false
              &&widget.problemModel.isAgreeToSolvingDate==false &&
              widget.problemModel.isCustomerRespondedtoSolvingDate==false)
            InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, ),
                    child:SizedBox(
                      height: 50,
                      width: 230,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: widget.isAgreeToDateonPress,
                        child: Row(
                          children: [
                            Icon(Icons.question_mark_outlined,  color: Colors.yellowAccent,),
                            Text(
                              "confirm solve date ?",

                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: widget.isAgreeToDateonPress,
            ),
          if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==false
              &&widget.problemModel.isAgreeToSolvingDate==false &&
              widget.problemModel.isCustomerRespondedtoSolvingDate==true
          &&(widget.problemModel.requiredDateFromCustomer==widget.problemModel.solvingDate)
          )
            InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, ),
                    child:SizedBox(
                      height: 50,
                      width: 230,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: widget.isAgreeToDateonPress,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.question_mark_outlined,  color: Colors.yellowAccent,),
                            Text(
                              "please pay ${widget.problemModel.price}?",

                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: widget.isAgreeToDateonPress,
            ),

          if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==false
              &&widget.problemModel.isAgreeToSolvingDate==false &&
              widget.problemModel.isCustomerRespondedtoSolvingDate==true
          &&(widget.problemModel.requiredDateFromCustomer!=widget.problemModel.solvingDate)
          )
            Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 0, ),
                  child:SizedBox(
                    height: 50,
                    width: 220,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: (){},
                      child: Row(
                        children: [
                          Icon(Icons.notifications,  color: Colors.yellowAccent,),
                          Text(
                            "wait another date",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if(widget.problemModel.solvingDate.length>3 &&
              widget.problemModel.isPending==true&&widget.problemModel.isCompleted==false &&
              widget.problemModel.isPaid==true
              &&
              widget.problemModel.solvedByTechnicianAndWaitingCustomerAgree==false
              &&widget.problemModel.isAgreeToSolvingDate==true
              &&
              widget.problemModel.isCustomerRespondedtoSolvingDate==true
          )
            Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 0, ),
                  child:SizedBox(
                    height: 50,
                    width: 211,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: (){},
                      child: Row(
                        children: [
                          Icon(Icons.notifications_active,  color: Colors.yellowAccent,),
                          Text(
                            "waiting solve ...",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          // if(widget.problemModel.solvingDate.length>3 &&
          //     widget.problemModel.isPending==true&&widget.problemModel.isCompleted==false &&
          //     widget.problemModel.isPaid==true
          //     &&widget.problemModel.isAgreeToSolvingDate==true)
          //   Column(
          //     children: [
          //       SizedBox(height: 10,),
          //       Padding(
          //         padding: const EdgeInsets.only(left: 0, ),
          //         child:SizedBox(
          //           height: 50,
          //           width: 211,
          //           child: ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: Colors.deepPurpleAccent,
          //               foregroundColor: Colors.white,
          //             ),
          //             onPressed: widget.isAgreeToDateonPress,
          //             child: Row(
          //               children: [
          //                 Icon(Icons.notifications_active,  color: Colors.yellowAccent,),
          //                 Text(
          //                   "waiting solve ...",
          //                   style: const TextStyle(
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),

          if(widget.problemModel.solvingDate.length>3 &&
              widget.problemModel.isPending==true&&widget.problemModel.isCompleted==false &&
              widget.problemModel.isPaid==true &&
              widget.problemModel.solvedByTechnicianAndWaitingCustomerAgree==true &&
          widget.problemModel.waitTechnicianToSolveAfterPending!="yes"
          &&widget.problemModel.isCustomerRespondedToEnsureSolving==false
              &&widget.problemModel.isAgreeToSolvingDate==true)
            InkWell(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, ),
                    child:SizedBox(
                      height: 50,
                      width: 215,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: widget.onPressWhenPending,
                        child: Row(
                          children: [
                            Icon(Icons.question_mark,  color: Colors.yellowAccent,),
                            Text(
                              "confirm solving ?",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: widget.onPressWhenPending,
            ),
         // solved and customer ensure  solving
          if(widget.problemModel.solvingDate.length>3 &&
              widget.problemModel.isPending==false&&widget.problemModel.isCompleted==true )
            Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 0, ),
                  child:SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: (){},
                      child: Row(
                        children: [
                          Icon(Icons.star,  color: Colors.yellowAccent,),
                          Text("${widget.problemModel.rating}"),
                          SizedBox(width: 10,),
                          Text(
                            "solved ",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          //Spacer(),
          // if(widget.problemModel.isPaid &&widget.problemModel.isPending)
          //   Column(
          //     children: [
          //       Row(
          //         children: [
          //           Text("paid",style: TextStyle(
          //               color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
          //           )),
          //           Checkbox(value: widget.problemModel.isPaid, onChanged: null ,checkColor: Colors.yellowAccent, ),
          //         ],
          //       ),
          //       Row(children: [
          //         Text("start to solve" ,
          //           style: TextStyle(
          //               color: Colors.yellowAccent, fontWeight: FontWeight.bold
          //           ),
          //
          //         ),
          //         Icon(Icons.start, color: Colors.yellowAccent)
          //       ],)
          //     ],
          //   ),
          // if(widget.problemModel.solvingDate.length<3)
          //   Row(
          //     children: [
          //       Text("Start Order",style: TextStyle(
          //           color: Colors.yellowAccent, fontWeight: FontWeight.bold
          //       )),
          //       IconButton(onPressed: widget.onPress, icon: Icon(Icons.start, color: Colors.yellowAccent,))
          //     ],
          //   ),

          if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==false
              &&widget.problemModel.isAgreeToSolvingDate==true)
            InkWell(onTap: widget.isAgreeToDateonPress,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 10),
                    child:SizedBox(
                      height: 50,
                      width: 215,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: widget.isAgreeToDateonPress,
                        child: Row(
                          children: [
                            Icon(Icons.question_mark,  color: Colors.yellowAccent,),
                            Text(
                              "pay now ?",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if(widget.problemModel.solvingDate.length>3 &&
              widget.problemModel.isPending==true&&
              widget.problemModel.waitTechnicianToSolveAfterPending=="yes"
          &&widget.problemModel.isCustomerRespondedToEnsureSolving==true

          )
            Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 0, ),
                  child:SizedBox(
                    height: 50,
                    width: 211,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: (){},
                      child: Row(
                        children: [
                          Icon(Icons.notifications_active_sharp,  color: Colors.yellowAccent,),
                          //Text("${widget.problemModel.rating}"),
                          Text(
                            "waiting solve again ",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          // widget.isOperator?
          // Column(crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     IconButton(
          //       icon: Container(
          //         // height: 10,
          //         child: Column(children: [
          //           Text("solved ?", style: TextStyle(
          //               color: Colors.deepPurpleAccent , fontSize: 15
          //           ),),
          //           //Icon(Icons.question_mark, color: Colors.yellowAccent,)
          //         ],),
          //       ), onPressed:
          //     widget.onPress
          //       ,
          //
          //     ),
          //     Row(
          //       children: [
          //         Text("started",style: TextStyle(
          //             color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
          //         )),
          //         Checkbox(value: widget.problemModel.solvingDate.length>3 ? true  :false,
          //           onChanged: null ,checkColor: Colors.yellowAccent, ),
          //       ],
          //     ),
          //     Row(
          //       children: [
          //         Text("paid",style: TextStyle(
          //             color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
          //         )),
          //         Checkbox(value: widget.problemModel.isPaid, onChanged: null ,checkColor: Colors.yellowAccent, ),
          //       ],
          //     ),
          //   ],)
          //     :
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //
          //     IconButton(onPressed: widget.onPress,
          //       icon:widget.isOperator?  Icon(Icons.start):
          //       Icon(Icons.start),
          //       color: Colors.deepPurpleAccent,),
          //     // Row(
          //     //   children: [
          //     //     Text("started",style: TextStyle(
          //     //         color: Colors.yellowAccent, fontWeight: FontWeight.bold
          //     //     )),
          //     //     Checkbox(value: widget.problemModel.solvingDate.length>3 ? true  :false,
          //     //       onChanged: null ,checkColor: Colors.yellowAccent, ),
          //     //   ],
          //     // ),
          //     // Row(
          //     //   children: [
          //     //     Text("paid",style: TextStyle(
          //     //         color: Colors.yellowAccent, fontWeight: FontWeight.bold
          //     //     )),
          //     //     SizedBox(width: 5,),
          //     //     Checkbox(value: widget.problemModel.isPaid, onChanged: null ,checkColor: Colors.yellowAccent, ),
          //     //   ],
          //     // ),
          //   ],
          //
          // ),
        ],

      ),

      // ListTile(leading: CircleAvatar(backgroundImage:  AssetImage(getImagePath(widget.problemModel)),
      //   radius: 30,
      // ),
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       SizedBox(height: 10,),
      //       Text("order No: ${widget.problemModel.number}", style: TextStyle(
      //           color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
      //       ),),
      //       SizedBox(height: 5,),
      //       Text("order date: ${widget.problemModel.problemDate}",
      //         style: TextStyle(
      //             color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
      //         ),),
      //       SizedBox(height: 5,),
      //       // Text("solving time: ${widget.problemModel.problemtime.substring(10,15)}",
      //       //   style: TextStyle(
      //       //       color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
      //       //   ),),
      //       // SizedBox(height: 5,),
      //       Text("Unit No: ${widget.problemModel.unitNumber}",
      //         style: TextStyle(
      //             color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
      //         ),),
      //       if(widget.problemModel.isPaid &&widget.problemModel.isPending)
      //         Row(
      //           children: [
      //             Text("paid",style: TextStyle(
      //                 color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
      //             )),
      //             Checkbox(value: widget.problemModel.isPaid, onChanged: null ,checkColor: Colors.yellowAccent, ),
      //           ],
      //         )
      //     ],
      //   ),
      //   trailing:widget.isOperator?
      //       Column(crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         IconButton(
      //           icon: Container(
      //            // height: 10,
      //             child: Column(children: [
      //               Text("solved ?", style: TextStyle(
      //                   color: Colors.deepPurpleAccent , fontSize: 15
      //               ),),
      //               //Icon(Icons.question_mark, color: Colors.yellowAccent,)
      //             ],),
      //           ), onPressed:
      //           widget.onPress
      //         ,
      //
      //         ),
      //       ],)
      //       :
      //   Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //
      //       IconButton(onPressed: widget.onPress,
      //       icon:widget.isOperator?  Icon(Icons.start):
      //       Icon(Icons.start),
      //       color: Colors.deepPurpleAccent,)],
      //   ),
      // )
      // Container(
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(20),
      //       gradient: LinearGradient(
      //           begin: Alignment.bottomRight,
      //           colors: [
      //             Colors.black.withOpacity(.4),
      //             Colors.black.withOpacity(.2),
      //           ]
      //       )
      //   ),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       // Text("Facility Manager", style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),),
      //       SizedBox(height: 50,),
      //       Container(
      //         height: 50,
      //      width: double.infinity ,
      //         margin: EdgeInsets.symmetric(vertical: 5),
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: Colors.white
      //         ),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text("problem No : ${widget.problemModel.number}",
      //               style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),),
      //             Text("problem date : ${widget.problemModel.problemDate}",
      //               style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),),
      //           ],
      //         ),
      //       ),
      //       SizedBox(height: 10,),
      //     ],
      //   ),
      // ),
    );

    //   Padding(padding: EdgeInsets.all(10),
    // child: Card(
    //   color: Colors.transparent,
    //   elevation: 0,
    //   child: Container(
    //       height: 200,
    //       width: 350,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(20),
    //           image: DecorationImage(
    //               image: AssetImage(getImagePath(widget.problemModel)),
    //               fit: BoxFit.cover
    //           )
    //       ),
    //       child: Column(children: [
    //         SizedBox(height: 100,),
    //         Container(
    //
    //           margin: EdgeInsets.symmetric(horizontal: 40),
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10),
    //               color: Colors.white.withOpacity(0.7)
    //           ),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text("problem No : ${widget.problemModel.number}",
    //                 style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),),
    //               SizedBox(height: 20,),
    //               Text("problem Date : ${widget.problemModel.problemDate}",
    //                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
    //
    //             ],
    //           ),
    //         ),
    //       ],)
    //     // Transform.translate(
    //     //   offset: Offset(55, -58),
    //     //   child: Container(
    //     //     width: 30,
    //     //     // height: 30,
    //     //     clipBehavior: Clip.hardEdge,
    //     //     decoration: BoxDecoration(),
    //     //     child: Center(
    //     //       child: MaterialButton(
    //     //         onPressed: () {
    //     //           setState(() {
    //     //
    //     //
    //     //           });
    //     //         },
    //     //         color: Colors.white,
    //     //         height: 35,
    //     //         minWidth: 40,
    //     //         padding: EdgeInsets.all(0),
    //     //         shape: RoundedRectangleBorder(
    //     //             borderRadius: BorderRadius.circular(8)
    //     //         ),
    //     //         child: Icon(Icons.bookmark , size: 22, color:  Colors.yellow[700]),
    //     //       ),
    //     //     ),
    //     //   ),
    //     //   // child: InkWell(
    //     //   //   onLongPress: () {},
    //     //   //   child: Container(
    //     //   //     margin: EdgeInsets.symmetric(horizontal:70, vertical: 71),
    //     //   //     decoration: BoxDecoration(
    //     //   //       borderRadius: BorderRadius.circular(8),
    //     //   //       color: Colors.white
    //     //   //     ),
    //     //   //     child: Icon(Icons.bookmark_border, size: 22,),
    //     //   //   ),
    //     //   // ),
    //     // ),
    //   ),
    // ),);
  }
}



String getImagePath(ProblemModel p){
  if(p.problemType=="تكييف AC"){
    return "assets/FMimages/aircondition.jpg";
  }
  if(p.problemType=="مدنى Civil"){
    return 'assets/FMimages/civil.jpg';
  }
  if(p.problemType=="كهرباء Electricity"){
    return 'assets/FMimages/electricity1.jpg';
  }
  if(p.problemType=="تكنولوجيا المعلومات It"){
    return'assets/FMimages/it.jpg' ;
  }
  if(p.problemType=="L.C"){
    return 'assets/FMimages/lc1.jpg';
  }
  if(p.problemType=="سباكة Plumbing"){
    return  'assets/FMimages/plumbing.jpg';
  }
  else return 'assets/FMimages/HK.JPG' ;
}

