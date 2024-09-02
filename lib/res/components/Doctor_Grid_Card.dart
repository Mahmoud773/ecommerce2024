
import 'package:amazon/consts/colors.dart';
import 'package:amazon/doctors/models/doctor_model.dart';
import 'package:flutter/material.dart';

import '../../consts/lists.dart';
import '../../views/Doctor_new_Details.dart';
import '../../views/patient/login_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DoctorGridCard extends StatefulWidget {
 final List<DoctorModel> doctorsList;
  const DoctorGridCard({Key? key , required this.doctorsList}) : super(key: key);

  @override
  State<DoctorGridCard> createState() => _DoctorGridCardState();
}

class _DoctorGridCardState extends State<DoctorGridCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      child:ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.doctorsList.length,
          itemBuilder: (context , int index) {
            return InkWell(
              child: Column(
                children: [
                  Container(height: 300,
                    width: 200,
                    margin: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F8FF),
                        borderRadius:BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ]

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            InkWell(onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return DoctorNewDetails(doctorModel: widget.doctorsList[index],);
                              }));
                            },
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15)
                                    ,topRight:Radius.circular(15)
                                ),
                                child:Image.network(widget.doctorsList[index].pictureUrl ,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,),

                                // CachedNetworkImage(
                                //   imageUrl: widget.doctorsList[index].pictureUrl ,
                                //   height: 200,
                                //     width: 200,
                                //   fit: BoxFit.cover,
                                //
                                //   placeholder: (context,url)=>
                                //   Image.asset("assets/images/doctor1.png" ,
                                //     height: 200,
                                //   width: 200,
                                //     fit: BoxFit.cover,
                                //   ),
                                //   errorWidget:(context,url , error)=>
                                //       Container(color:Colors.black12,
                                //       child: Icon(Icons.error , color: Colors.red,size: 100),) ,
                                // )

                                // Image.network("${widget.doctorsList[index].pictureUrl}" ,
                                //   height: 200,
                                //   width: 200,
                                //   fit: BoxFit.cover,
                                // ),

                                // Image.asset(DoctorsImages[index] ,
                                //   height: 200,
                                // width: 200,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 45,
                                width: 45,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF2F8FF),
                                    shape:BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                      ),
                                    ]

                                ),
                                child: Center(
                                  child: Icon(widget.doctorsList[index].isFavorite?Icons.favorite :  Icons.favorite_outline ,
                                    color:AppColors.primaryColor,
                                    size: 28,),

                                ),



                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8,),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${widget.doctorsList[index].name}" ,
                                style: TextStyle(
                                  fontSize: 22 ,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor,

                                ),
                              ),
                              SizedBox(height: 8,),
                              Row(
                                children: [
                                  Icon(Icons.star , color: Colors.amber,),
                                  SizedBox(height: 5,),
                                  Text("${widget.doctorsList[index].Category}" ,
                                    style: TextStyle(
                                      fontSize: 18 ,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,

                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),)
                      ],
                    ),
                  )
                ],
              ),
              onTap: (){
                Navigator.of(context).push( MaterialPageRoute(builder: (context) =>
                    DoctorNewDetails(
                      doctorModel: widget.doctorsList[index]!,
                    )
                  // PatientLoginScreen()
                ));
              },
            );
          }),

      // GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //
      // ),
      //     itemBuilder: (context , index) {
      //   return  InkWell(
      //     child: Column(
      //       children: [
      //         Container(height: 250,
      //           width: 250,
      //           margin: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
      //           decoration: BoxDecoration(
      //               color: Color(0xFFF2F8FF),
      //               borderRadius:BorderRadius.circular(15),
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.black12,
      //                   blurRadius: 4,
      //                   spreadRadius: 2,
      //                 ),
      //               ]
      //
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Stack(
      //                 children: [
      //                   InkWell(onTap: () {
      //                     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                       return DoctorNewDetails(doctorModel: widget.doctorsList[index],);
      //                     }));
      //                   },
      //                     child: ClipRRect(
      //                       borderRadius: BorderRadius.only(topLeft: Radius.circular(15)
      //                           ,topRight:Radius.circular(15)
      //                       ),
      //                       child:Image.network(widget.doctorsList[index].pictureUrl ,
      //                         height: 200,
      //                         width: 200,
      //                         fit: BoxFit.cover,),
      //
      //                       // CachedNetworkImage(
      //                       //   imageUrl: widget.doctorsList[index].pictureUrl ,
      //                       //   height: 200,
      //                       //     width: 200,
      //                       //   fit: BoxFit.cover,
      //                       //
      //                       //   placeholder: (context,url)=>
      //                       //   Image.asset("assets/images/doctor1.png" ,
      //                       //     height: 200,
      //                       //   width: 200,
      //                       //     fit: BoxFit.cover,
      //                       //   ),
      //                       //   errorWidget:(context,url , error)=>
      //                       //       Container(color:Colors.black12,
      //                       //       child: Icon(Icons.error , color: Colors.red,size: 100),) ,
      //                       // )
      //
      //                       // Image.network("${widget.doctorsList[index].pictureUrl}" ,
      //                       //   height: 200,
      //                       //   width: 200,
      //                       //   fit: BoxFit.cover,
      //                       // ),
      //
      //                       // Image.asset(DoctorsImages[index] ,
      //                       //   height: 200,
      //                       // width: 200,
      //                       //   fit: BoxFit.cover,
      //                       // ),
      //                     ),
      //                   ),
      //                   Align(
      //                     alignment: Alignment.topRight,
      //                     child: Container(
      //                       height: 45,
      //                       width: 45,
      //                       margin: EdgeInsets.all(8),
      //                       decoration: BoxDecoration(
      //                           color: Color(0xFFF2F8FF),
      //                           shape:BoxShape.circle,
      //                           boxShadow: [
      //                             BoxShadow(
      //                               color: Colors.black12,
      //                               blurRadius: 4,
      //                               spreadRadius: 2,
      //                             ),
      //                           ]
      //
      //                       ),
      //                       child: Center(
      //                         child: Icon(widget.doctorsList[index].isFavorite?Icons.favorite :  Icons.favorite_outline ,
      //                           color:AppColors.primaryColor,
      //                           size: 28,),
      //
      //                       ),
      //
      //
      //
      //                     ),
      //                   )
      //                 ],
      //               ),
      //               SizedBox(height: 8,),
      //               Padding(padding: EdgeInsets.symmetric(horizontal: 5),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text("${widget.doctorsList[index].name}" ,
      //                       style: TextStyle(
      //                         fontSize: 22 ,
      //                         fontWeight: FontWeight.w500,
      //                         color: AppColors.primaryColor,
      //
      //                       ),
      //                     ),
      //                     SizedBox(height: 8,),
      //                     Row(
      //                       children: [
      //                         Icon(Icons.star , color: Colors.amber,),
      //                         SizedBox(height: 5,),
      //                         Text("4.9" ,
      //                           style: TextStyle(
      //                             fontSize: 16 ,
      //                             fontWeight: FontWeight.w500,
      //                             color: Colors.black.withOpacity(0.6),
      //
      //                           ),
      //                         ),
      //                       ],
      //                     )
      //                   ],
      //                 ),)
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //     onTap: (){
      //       Navigator.of(context).push( MaterialPageRoute(builder: (context) =>
      //           DoctorNewDetails(
      //             doctorModel: widget.doctorsList[index]!,
      //           )
      //         // PatientLoginScreen()
      //       ));
      //     },
      //   ) ;
      //     },
      //   itemCount:widget.doctorsList.length ,
      //
      //     ),



    );
  }
}

class DoctorInnerCard extends StatelessWidget {
  const DoctorInnerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

