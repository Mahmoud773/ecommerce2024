
import 'package:amazon/Facility_Manager/models/Problem_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
final List<Map<String, dynamic>> _listItem = [
  {"image": 'assets/FMimages/aircondition.jpg', "problemType": "تكييف AC"},
  {"image": 'assets/FMimages/civil.jpg', "problemType": "مدنى Civil"},
  {"image": 'assets/FMimages/electricity1.jpg', "problemType": "كهرباء Electricity"},
  {"image": 'assets/FMimages/it.jpg', "problemType": "تكنولوجيا المعلومات It"},
  {"image": 'assets/FMimages/lc1.jpg', "problemType": "L.C نيار خفيف"},
  {"image": 'assets/FMimages/plumbing.jpg', "problemType": "سباكة Plumbing"},
  {"image": 'assets/FMimages/HK.JPG', "problemType": " H.K"},

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
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Card(
          color: Colors.transparent,
          elevation: 0,
          child: Container(

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(widget.item["image"]),
                    fit: BoxFit.cover
                )
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
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top:widget.item["problemType"]=="تكنولوجيا المعلومات It"? 5:0),
          width: 150,
          //       decoration:
          //            BoxDecoration(
          //     borderRadius: BorderRadius.circular(20),
          // color: Colors.white
          // ),
          child: Text(widget.item["problemType"], style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ],
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

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
        height: 210,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.9)
          // image: DecorationImage(
          //     image: AssetImage('assets/images/one.jpg'),
          //     fit: BoxFit.cover
          // )
        ),
        child: ListTile(leading: CircleAvatar(backgroundImage:  AssetImage(getImagePath(widget.problemModel)),
          radius: 30,
        ),
          title: Container(
            width: 50,
            height: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text("order No: ${widget.problemModel.number}", style: TextStyle(
                    color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 5,),
                Text("order date: ${widget.problemModel.problemDate}",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: 5,),
                // Text("solving time: ${widget.problemModel.problemtime.substring(10,15)}",
                //   style: TextStyle(
                //       color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
                //   ),),
                // SizedBox(height: 5,),
                Text("Unit No: ${widget.problemModel.unitNumber}",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: 5,),
                if(widget.problemModel.isPaid &&widget.problemModel.isPending)
                  Row(
                    children: [
                      Text("paid",style: TextStyle(
                          color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
                      )),
                      Checkbox(value: widget.problemModel.isPaid, onChanged: null ,checkColor: Colors.yellowAccent, ),
                    ],
                  )
              ],
            ),
          ),
          trailing: Container(
            width: 50,
            height: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // widget.problemModel.rating ==""
                //     ?
                // Container()
                //     :
                widget.solved?Container(
                  width: 50,

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("${widget.problemModel.rating}"),
                      Icon(Icons.star , color: Colors.amber,)
                    ],),
                ) :
                Container()
                ,
                (widget.Pending==false &&widget.problemModel.solvingDate.length<3)?

                IconButton(
                  onPressed:widget.onPressWhenPending,
                  icon:widget.Pending?  Icon(Icons.question_mark_sharp , size: 30,color: Colors.yellowAccent,):  Icon(Icons.delete),
                  color: Colors.deepPurpleAccent,)
                    :

                Container(),
                (widget.solved==false &&widget.Pending==false &&widget.problemModel.solvingDate.length>3)
                    ?
                IconButton(
                    onPressed:widget.isAgreeToDateonPress,
                    icon:
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text("solving Date\n${widget.problemModel.solvingDate}"),
                        Icon(Icons.question_mark_sharp , size: 30,color: Colors.yellowAccent,),
                      ],
                    ))
                    :
                Container()
              ],
            ),
          ),
        )
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

