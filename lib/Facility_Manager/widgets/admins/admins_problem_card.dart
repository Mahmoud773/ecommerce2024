import 'package:flutter/material.dart';

import '../../models/Problem_model.dart';


class AdminProblemCard extends StatefulWidget {
  bool isAdmin;
  String pendingOrSolved;
  Function() onPress;
  final ProblemModel problemModel;
  bool isOperator;
  AdminProblemCard({super.key,required this.pendingOrSolved , required this.problemModel ,
    required this.onPress , required this.isOperator , this.isAdmin=false});

  @override
  State<AdminProblemCard> createState() => _AdminProblemCardState();
}

class _AdminProblemCardState extends State<AdminProblemCard> {
  String orderStatus="";

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return  Container(
      // width: double.infinity,
      // height:
      // (widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==true
      //     &&widget.problemModel.isAgreeToSolvingDate==true
      //     &&widget.problemModel.waitingForCustomerToAgreeForSolvingDate==false
      //     &&widget.problemModel.isCustomerRespondedtoSolvingDate==true
      //
      //     &&widget.problemModel.isPending==true &&
      //     widget.problemModel.waitTechnicianToSolveAfterPending=="yes")?
      //     210
      //     :
      // 190,
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
                    width: width*45/100,

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

                        if(widget.problemModel.solvingDate.length>0)
                          Text("Solve Date: ${widget.problemModel.solvingDate}",
                            style: TextStyle(
                                color: Colors.deepPurple, fontWeight: FontWeight.bold
                            ),),
                        // if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==true
                        //     &&widget.problemModel.isAgreeToSolvingDate==true)
                        //   Padding(
                        //     padding: const EdgeInsets.only(left: 0, ),
                        //     child: Row(
                        //       children: [
                        //         Icon(Icons.notifications_active,  color: Colors.yellowAccent,),
                        //         Padding(
                        //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        //           child: Button(
                        //             height: 40,
                        //             width: 200,
                        //             title: 'customer agree',
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
                // Column(
                //     children: [
                //       SizedBox(height: 10,),
                //       Text("orderStatus")
                //     ]
                // ),
              ],
            ),


          ),
          // not started
          if(widget.problemModel.solvingDate.length<3 &&widget.problemModel.isPaid==false
              &&widget.problemModel.isAgreeToSolvingDate==false
          )
            InkWell(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 10),
                    child:Center(
                      child: SizedBox(
                        height: 50,
                        width: 225,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: widget.onPress,
                          child: Center(
                            child: Row(
                              children: [
                                Icon(Icons.notifications_active_rounded,  color: Colors.yellowAccent,),
                                Text(
                                  getorderStatus(widget.problemModel),
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
                    ),
                  ),
                ],
              ),
            ),
          // InkWell(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          //     child: Row(
          //       children: [
          //         Icon(Icons.notifications_active,  color: Colors.yellowAccent,),
          //         Button(
          //           height: 40,
          //           width: 150,
          //           title: 'choose date',
          //           onPressed:widget.onPress ,
          //           disable: true,
          //         ),
          //       ],
          //     ),
          //   ),
          //   onTap: widget.onPress,
          // ),
          // if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==true
          //     &&widget.problemModel.isAgreeToSolvingDate==true
          //     &&widget.problemModel.isCustomerRespondedtoSolvingDate==true)
          //   InkWell(
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          //       child: Row(
          //         children: [
          //           Icon(Icons.question_mark,  color: Colors.yellowAccent,),
          //           Button(
          //             height: 40,
          //             width: 150,
          //             title: 'start Order',
          //             onPressed:widget.onPress ,
          //             disable: true,
          //           ),
          //         ],
          //       ),
          //     ),
          //     onTap: widget.onPress,
          //   ),
          // wait owner agree to solve date
          if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==false
              &&widget.problemModel.isAgreeToSolvingDate==false
              &&widget.problemModel.isCustomerRespondedtoSolvingDate==false)
            Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 0, ),
                  child:SizedBox(
                    height: 50,
                    width: 260,
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
                            getorderStatus(widget.problemModel),
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

          //customer not agree to solve Date
          if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==false
              &&widget.problemModel.isAgreeToSolvingDate==false
              &&widget.problemModel.waitingForCustomerToAgreeForSolvingDate==false
              &&widget.problemModel.isCustomerRespondedtoSolvingDate==true)
            InkWell(
              child: Column(
                children: [
                  if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==false
                      &&widget.problemModel.isAgreeToSolvingDate==false
                      &&widget.problemModel.waitingForCustomerToAgreeForSolvingDate==false
                      &&widget.problemModel.isCustomerRespondedtoSolvingDate==true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_active,  color: Colors.yellowAccent,),
                        Text(getorderStatus(widget.problemModel),style: TextStyle(
                            color: Colors.yellowAccent
                        ),),
                        //Icon(Icons.pending,  color: Colors.yellowAccent,),
                        //Checkbox(value: widget.problemModel.isAgreeToSolvingDate, onChanged: null ,checkColor: Colors.yellowAccent, ),
                      ],
                    ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, ),
                    child:SizedBox(
                      height: 50,
                      width: 260,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: widget.onPress,
                        child: Row(
                          children: [
                            Icon(Icons.notifications_on,  color: Colors.yellowAccent,),
                            Text(
                              getorderStatus(widget.problemModel),
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

          // for paid and operator already solved and customer said not solved
          if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==true
              &&widget.problemModel.isAgreeToSolvingDate==true
              &&widget.problemModel.waitingForCustomerToAgreeForSolvingDate==false
              &&widget.problemModel.isCustomerRespondedtoSolvingDate==true

              &&widget.problemModel.isPending==true &&
              widget.problemModel.waitTechnicianToSolveAfterPending=="yes")
            InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(widget.problemModel.isPending==true &&
                      widget.problemModel.waitTechnicianToSolveAfterPending=="yes"
                      &&widget.problemModel.isCustomerRespondedToEnsureSolving==true&&
                      widget.problemModel.waitingCustomerEnsureSolving==false)
                    Padding(
                      padding: const EdgeInsets.only(left: 0, ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications_active,  color: Colors.yellowAccent,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            child: Text("customer said not solved",
                              style:TextStyle(color: Colors.yellowAccent) ,),
                          ),
                          //Icon(Icons.pending,  color: Colors.yellowAccent,),
                          //Checkbox(value: widget.problemModel.isAgreeToSolvingDate, onChanged: null ,checkColor: Colors.yellowAccent, ),
                        ],
                      ),
                    ),
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
                        onPressed: widget.onPress,
                        child: Row(
                          children: [
                            Icon(Icons.notifications_on,  color: Colors.yellowAccent,),
                            Text(
                              getorderStatus(widget.problemModel),
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
              onTap: widget.onPress,
            ),

          // customer responded to ensure solving and said not solved
          // if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==true
          //     &&widget.problemModel.isAgreeToSolvingDate==true
          //     &&widget.problemModel.waitingForCustomerToAgreeForSolvingDate==false
          //     &&widget.problemModel.isCustomerRespondedtoSolvingDate==true
          //
          //     &&widget.problemModel.isPending==true &&
          //     widget.problemModel.waitTechnicianToSolveAfterPending=="yes"&&
          //     widget.problemModel.waitingCustomerEnsureSolving==false &&
          //     widget.problemModel.isCustomerRespondedToEnsureSolving==true
          // )
          //   Column(
          //     children: [
          //       SizedBox(height: 10,),
          //       Padding(
          //         padding: const EdgeInsets.only(left: 0, ),
          //         child:SizedBox(
          //           height: 50,
          //           width: 260,
          //           child: ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: Colors.deepPurpleAccent,
          //               foregroundColor: Colors.white,
          //             ),
          //             onPressed: widget.onPress,
          //             child: Row(
          //               children: [
          //                 Icon(Icons.question_mark,  color: Colors.yellowAccent,),
          //                 Text(
          //                   "start solve again ?",
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
          // after solving from technician and waiting customer ensure solving
          if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==true
              &&widget.problemModel.isAgreeToSolvingDate==true
              &&widget.problemModel.waitingForCustomerToAgreeForSolvingDate==false
              &&widget.problemModel.isCustomerRespondedtoSolvingDate==true

              &&widget.problemModel.isPending==true &&
              widget.problemModel.waitTechnicianToSolveAfterPending=="no"&&
              widget.problemModel.waitingCustomerEnsureSolving==true
          )
            Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 0, ),
                  child:SizedBox(
                    height: 50,
                    width: 225,
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
                            getorderStatus(widget.problemModel),
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



          // solved and customer ensure solving and said solved

          if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==true
              &&widget.problemModel.isAgreeToSolvingDate==true
              &&widget.problemModel.waitingForCustomerToAgreeForSolvingDate==false
              &&widget.problemModel.isCustomerRespondedtoSolvingDate==true

              &&widget.problemModel.isPending==false &&
              widget.problemModel.isCompleted==true

          )
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
                            getorderStatus(widget.problemModel),
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
          // Spacer(),
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

          // if(widget.problemModel.solvingDate.length>3 &&widget.problemModel.isPaid==false
          //     &&widget.problemModel.isAgreeToSolvingDate==true)
          //   Padding(
          //     padding: const EdgeInsets.all(5.0),
          //     child: Row(
          //       children: [
          //         Text("waiting customer pay",style: TextStyle(
          //             color: Colors.yellowAccent, fontWeight: FontWeight.bold,fontSize: 12
          //         )),
          //         Icon(Icons.pending,  color: Colors.yellowAccent,)
          //         //Checkbox(value: widget.problemModel.isAgreeToSolvingDate, onChanged: null ,checkColor: Colors.yellowAccent, ),
          //       ],
          //     ),
          //   ),

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
    )  ;

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
String getorderStatus(ProblemModel p){
  //not started
  if(p.solvingDate.length<3 &&p.isPaid==false
      &&p.isAgreeToSolvingDate==false
  ){
    return "not started";
  }
  // solved finally
  if(p.solvingDate.length>3 &&p.isPaid==true
      &&p.isAgreeToSolvingDate==true
      &&p.waitingForCustomerToAgreeForSolvingDate==false
      &&p.isCustomerRespondedtoSolvingDate==true

      &&p.isPending==false &&
      p.isCompleted==true

  ){
    return 'solved';
  }
  // after solving from technician and waiting customer ensure solving
  if(p.solvingDate.length>3 &&p.isPaid==true
      &&p.isAgreeToSolvingDate==true
      &&p.waitingForCustomerToAgreeForSolvingDate==false
      &&p.isCustomerRespondedtoSolvingDate==true

      &&p.isPending==true &&
      p.waitTechnicianToSolveAfterPending=="no"&&
      p.waitingCustomerEnsureSolving==true
  ){
    return "wait owner ensure solve";
  }
  // for paid and operator already solved and customer said not solved
  if(p.solvingDate.length>3 &&p.isPaid==true
      &&p.isAgreeToSolvingDate==true
      &&p.waitingForCustomerToAgreeForSolvingDate==false
      &&p.isCustomerRespondedtoSolvingDate==true

      &&p.isPending==true &&
      p.waitTechnicianToSolveAfterPending=="yes")
  {return "owner waiting for solve";}

  //customer not agree to solve Date
  if(p.solvingDate.length>3 &&p.isPaid==false
      &&p.isAgreeToSolvingDate==false
      &&p.waitingForCustomerToAgreeForSolvingDate==false
      &&p.isCustomerRespondedtoSolvingDate==true)
  {return "owner not agree to solve Date";}

  // wait customer agree for solve date
  if(p.solvingDate.length>3 &&p.isPaid==false
      &&p.isAgreeToSolvingDate==false
      &&p.isCustomerRespondedtoSolvingDate==false)
  {return "wait owner agree to solve Date";}
  // not started
  if(p.solvingDate.length<3 &&p.isPaid==false
      &&p.isAgreeToSolvingDate==false
  )
  {return "not started";}

  else return "not started";
}


double getCardHeight(ProblemModel p){
  return 190;
}
