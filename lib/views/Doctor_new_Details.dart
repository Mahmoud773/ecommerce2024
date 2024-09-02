
import 'package:amazon/consts/colors.dart';
import 'package:amazon/models/booking_date_time_converter.dart';
import 'package:amazon/res/components/custom_book_card.dart';
import 'package:amazon/views/patient/booked_seccess_screen.dart';
import 'package:amazon/views/patient/firebasere_pository/patient_firebase_repository.dart';
import 'package:amazon/views/patient_appintment_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../doctors/firestore_Repository/firetore_repository.dart';
import '../doctors/models/doctor_model.dart';
import '../res/components/booking_card2.dart';
import 'home.dart';
import 'package:uuid/uuid.dart';

class DoctorNewDetails extends StatefulWidget {
  final DoctorModel doctorModel;
  const DoctorNewDetails({Key? key , required this.doctorModel}) : super(key: key);

  @override
  State<DoctorNewDetails> createState() => _DoctorNewDetailsState();
}

class _DoctorNewDetailsState extends State<DoctorNewDetails> {

  // DoctorModel doctorModel=DoctorModel(id: uid, email: "");
  // void getDoctors()  async {
  //   doctorsList=  await DoctorsFirestoreRpository.getDoctorAppoints(widget.doctorModel.id);
  // }
  bool isFavoritLoading=false;
  bool isDoctorFavorite = false ;
  bool isBooking = false;
  // void getFavorite ()async{
  //   isDoctorFavorite= await DoctorsFirestoreRpository.markAsFavorite(widget.doctorModel.id);
  // }


  // userModel? user;
  // Future<userModel> getCurrentUser() async {
  //   final currentUser= FirebaseAuth.instance.currentUser;
  //   final result =await  FirebaseFirestore.instance.collection("users").doc("${
  //       currentUser!.uid
  //   }").get();
  //   user=userModel.fromJson(result.data()!);
  //   if(user==null){
  //
  //     final result =await  FirebaseFirestore.instance.collection("users").doc("${
  //         currentUser!.uid
  //     }").get();
  //     user=userModel.fromJson(result.data()!);
  //   }
  //   print("user.email ${(user!.email)}");
  //   print("user.isdoctor ${(user!.isDoctor)}");
  //   return user!;
  //
  // }
   userModel? user;
  // void getCurrentUser() async {
  //   final result =await  FirebaseFirestore.instance.collection("users").doc("${
  //       FirebaseAuth.instance!.currentUser
  //   }").get();
  //   user=userModel.fromJson(result.data()!);
  //   print(user.email);
  // }


  @override
  void initState() {
    isDoctorFavorite=widget.doctorModel.isFavorite;
    // getCurrentUser();
    super.initState();
    // getCurrentUser();
    // initPrefs();
  }

  List<DayTimeDetails> choosenDateTimesList=[];
  DayTimeDetails choosenDayTimeDay=DayTimeDetails(id: Uuid().v1(),
      intervalList: [], dayDate: DateTime.now(),newIntervals: []);
  List<Appointment> patientAppointsList=[];

  List<DayTimeDetails> list8 =[];
  var selectedDayIndex=0;
  var selectedTimeIndex=0;
  List<DayDetails> list9 =[];
  @override
  Widget build(BuildContext context) {
    final currentUser= FirebaseAuth.instance.currentUser;

    // if(widget.doctorModel.appointsDays !=null && widget.doctorModel.appointsDays!.length >0)
    // {
    //   print("${widget.doctorModel.appointsDays!.length}");
    //   print("${widget.doctorModel.appointsDays![0].dayDate}");
    //   print("${widget.doctorModel.appointsDays![0].intervalList}");
    //
    // }
    list8=[];
    // print("${widget.doctorModel.isFavorite}");
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Material(
          color: Color(0xFFD9E4EE),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: width,
                  height: height*44/100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${widget.doctorModel.pictureUrl}"),
                      fit: BoxFit.cover,

                    ),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20) ,
                        bottomRight: Radius.circular(20)),


                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          AppColors.primaryColor.withOpacity(0.9),
                          AppColors.primaryColor.withOpacity(0),
                          AppColors.primaryColor.withOpacity(0),
                        ],
                          begin: Alignment.bottomCenter
                          ,
                          end:  Alignment.topCenter,
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Padding(padding: EdgeInsets.only(top: 30 , left: 10 , right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder:
                                      (context)=> Home()));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  width:45 ,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF2F8FF),
                                    borderRadius:BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Icon(Icons.arrow_back ,
                                      color: AppColors.primaryColor, size: 28,),
                                  ),
                                ),
                              ),
                              FutureBuilder(future:
                              DoctorsFirestoreRpository.checkFavorite(widget.doctorModel.id),
                                  builder: (context , snapshot) {
                                    if(snapshot.hasData){
                                      bool _isFavorite=snapshot.data!;
                                      print('_isFavorite1 $_isFavorite');

                                      return StatefulBuilder(
                                        builder: (BuildContext context,
                                            Function setState){
                                          return InkWell(
                                              onTap: ()  {
                                                _isFavorite=!_isFavorite;
                                                isFavoritLoading=true;
                                                setState(() {

                                                });
                                                try{
                                                  DoctorsFirestoreRpository.markAsFavorite(widget.doctorModel.id)
                                                      .then((value) {

                                                    setState(() {
                                                      // _isFavorite = value;
                                                      isFavoritLoading=false;
                                                    });
                                                    print('_isFavorite2 $_isFavorite');

                                                  }).onError((error, stackTrace) {
                                                    _isFavorite=!_isFavorite;
                                                    isFavoritLoading=false;
                                                    setState(() {

                                                    });

                                                  });


                                                } catch(e){
                                                  isFavoritLoading=false;
                                                  _isFavorite=!_isFavorite;
                                                  setState(() {

                                                  });
                                                }


                                                print('_isFavorite2 $_isFavorite');

                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(8),
                                                width:45 ,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF2F8FF),
                                                  borderRadius:BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 4,
                                                      spreadRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                                child:
                                                Center(
                                                  child: isFavoritLoading ? Center(child: CircularProgressIndicator(),):
                                                  Icon(     _isFavorite
                                                      ? Icons.favorite :Icons.favorite_outline ,
                                                    color: AppColors.primaryColor, size: 28,),
                                                ),
                                              )
                                          ) ;
                                        },
                                      );
                                    }else return SizedBox() ;
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Patients" ,
                                    style: TextStyle(
                                      fontSize: 20 ,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,

                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text("1.8k" ,
                                    style: TextStyle(
                                      fontSize: 18 ,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,

                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Experience" ,
                                    style: TextStyle(
                                      fontSize: 20 ,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,

                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text("${widget.doctorModel.experience}" ,
                                    style: TextStyle(
                                      fontSize: 18 ,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,

                                    ),
                                  ),
                                ],
                              ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text("Rating" ,
                              //       style: TextStyle(
                              //         fontSize: 20 ,
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.white,
                              //
                              //       ),
                              //     ),
                              //     SizedBox(height: 8,),
                              //     Text("4.9" ,
                              //       style: TextStyle(
                              //         fontSize: 18 ,
                              //         fontWeight: FontWeight.w500,
                              //         color: Colors.white,
                              //
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)
                  ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.doctorModel.name}" ,
                        style: TextStyle(
                          fontSize: 28 ,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,

                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Icon(MdiIcons.heartPlus, color:Colors.red ,size: 28,),
                          SizedBox(height: 5,),
                          Text("${widget.doctorModel.Category}" ,
                            style: TextStyle(
                              fontSize: 17 ,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text("description about Doctor" ,
                        style: TextStyle(
                          fontSize: 15 ,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        textAlign: TextAlign.justify,

                      ),
                      SizedBox(height: 15,),

                      // BOOK DATE
                      Text("Book Date" ,
                        style: TextStyle(
                          fontSize: 18 ,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        textAlign: TextAlign.justify,

                      ),
                      SizedBox(height: 8,),
                      // StreamBuilder(stream: DoctorsFirestoreRpository.
                      // getDoctorAppointsAsSgtream(widget.doctorModel.id),
                      //     builder: (context, snapshot) {
                      //       // print("${snapshot.data!.data()!}");
                      //       // print("${snapshot.data!.data()}");
                      //       if (snapshot.connectionState == ConnectionState.waiting) {
                      //         return Center(child: CircularProgressIndicator(),);
                      //       }
                      //       if (snapshot.hasData && snapshot.data!.exists) {
                      //
                      //
                      //         print("snapshot.data!.data()!appointsDays ${snapshot.data!.data()!["appointsDays"]}");
                      //
                      //         List list7 =snapshot.data!.data()!["appointsDays"];
                      //         print("list7 $list7");
                      //         // List<DayDetails> list9 =[];
                      //         list7.forEach((element) {
                      //           list9.add(DayDetails.fromJson(element));
                      //           print("list8 $list8");
                      //         });
                      //
                      //
                      //         List<int> daysDate= [];
                      //         list9.forEach((element) {
                      //           daysDate.add(list9.indexOf(element));
                      //         });
                      //         List<List<IntervalDetails>> ind =[];
                      //         list9.forEach((element) {
                      //           ind.add(element.intervalList!);
                      //         });
                      //         return appointsTimes( list9);
                      //
                      //
                      //
                      //
                      //
                      //       }
                      //       if (snapshot.hasError) {
                      //         return Center(child: Text("something went wrong"),);
                      //       }
                      //
                      //       else
                      //         return Center(child: Text("No Appoints yet"),);
                      //     }),

                      StreamBuilder(stream: DoctorsFirestoreRpository.
                      getNewDoctorAppointsAsSgtream(widget.doctorModel.id),
                          builder: (context, snapshot) {
                            list8=[];
                            List list7=[];
                            // print("${snapshot.data!.data()!}");
                            // print("${snapshot.data!.data()}");
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator(),);
                            }
                            if (snapshot.hasData && snapshot.data!.exists) {
                              print("snapshot.data!.data()!appointsDays ${snapshot.data!.data()!["appointsDays"]}");

                              list7 =snapshot.data!.data()!["appointsDays"];
                              print("list7 $list7");
                              // List<DayTimeDetails> list8 =[];
                              list7.forEach((element) {
                                list8.add(DayTimeDetails.fromJson(element));
                                print("list8 $list8");
                              });
                              List<int> daysDate= [];
                              list8.forEach((element) {
                                daysDate.add(list8.indexOf(element));
                              });
                              // List<List<IntervalDetails>> ind =[];
                              // list8.forEach((element) {
                              //   ind.add(element.intervalList!);
                              // });
                              if(list8.isEmpty || list8.length==0)
                                return Center(child: Text("Doctor has no available appoints")) ;
                              else
                              return newAppointsTimes( list8);

                            }
                            if (snapshot.hasError) {
                              return Center(child: Text("something went wrong"),);
                            }

                            else
                              return Center(child: Text("No Appoints yet"),);
                          }),


                    ],
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet:isBooking ? Center(child: CircularProgressIndicator(),) :

      StreamBuilder(
        stream:   FirebaseFirestore.instance.collection("users").
      doc("${currentUser!.uid}").snapshots() ,
          builder: (context , snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasData  ) {
              user= userModel.fromJson(snapshot.data!.data()!);
              // final doctorsList =snapshot!.data!.docs as List<DoctorModel>;
              return Padding(
                padding: const EdgeInsets.only(bottom: 5 ,right: 8,left: 8),
                child: Container(
                  color: Color(0xFFD9E4EE),
                  child: Material(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      child:
                      user!.isDoctor ?
                      StatefulBuilder(
                        builder:(BuildContext context,
                            Function setState){
                          return InkWell(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  BookingCard2(doctorModel: widget.doctorModel,)
                              ));
                            },
                            child: Container(
                              height: 60,
                              width: width,
                              child: Center(child:
                              Text("add Appointment" ,
                                style: TextStyle(
                                  fontSize: 20 ,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,

                                ),
                              ),),
                            ),
                          );
                        },

                      ):
                      StatefulBuilder(
                          builder:(BuildContext context,
                              Function setState){
                            return InkWell(
                              onTap: () async{

                                setState(() {
                                  isBooking=true;
                                });
                                choosenDateTimesList.add(choosenDayTimeDay);
                                // print("choosenDateTimesList ${choosenDateTimesList[0].dayDate}");
                                // print("choosenDateTimesList ${choosenDateTimesList[0].intervalList}");
                                // print("${choosenDateTimesList.length}");

                               list8[selectedDayIndex].intervalList.removeAt(selectedTimeIndex);
                                //new
                                list8[selectedDayIndex].newIntervals.removeAt(selectedTimeIndex);
                                print(list8);
                                Appointment appointment=
                                Appointment(id: Uuid().v1(),
                                    doctorImage:widget.doctorModel.pictureUrl ,
                                    doctorName:widget.doctorModel.name ,
                                    appointWith: "${widget.doctorModel.id}",
                                    appointBy: "${currentUser!.uid}",
                                    appointsList: choosenDateTimesList);
                                patientAppointsList.add(appointment);
                                // setState(() {
                                //
                                // });

                                await DoctorsFirestoreRpository.uploadReservedDoctorAppoints(widget.doctorModel.id,
                                    patientAppointsList ,isUpdating: true);
                                await PatientFireaseRepository.uploadPatientAppoints(
                                    currentUser!.uid, patientAppointsList ,isUpdating: true).
                                then((value) async {
                                  setState(() {
                                    isBooking=false;
                                  });
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                        return AppointmentSuccessBooked(doctorId: widget.doctorModel.id,
                                          list8:list8, );
                                      })
                                  );
                                  await DoctorsFirestoreRpository.
                                  uploadDoctorAppoints(widget.doctorModel.id ,list8 ,
                                      isUpdating:  false);
                                });



                                print(list8);
                              },
                              child: Container(
                                height: 60,
                                width: width,
                                child: Center(child:
                                Text("book Appointment" ,
                                  style: TextStyle(
                                    fontSize: 20 ,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,

                                  ),
                                ),),
                              ),
                            );
                          }

                      )
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     InkWell(
                      //       onTap: (){
                      //
                      //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      //             BookingCard2(doctorModel: widget.doctorModel,)
                      //         ));
                      //       },
                      //       child: Container(
                      //         height: 60,
                      //         width: 100,
                      //         child: Center(child:
                      //         Text("add Appointment" ,
                      //           style: TextStyle(
                      //             fontSize: 20 ,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.white,
                      //
                      //           ),
                      //         ),),
                      //       ),
                      //     ),
                      //     SizedBox(width: 10,),
                      //     InkWell(
                      //       onTap: () async{
                      //         choosenDateTimesList.add(choosenDayTimeDay);
                      //         print("choosenDateTimesList ${choosenDateTimesList[0].dayDate}");
                      //         print("choosenDateTimesList ${choosenDateTimesList[0].intervalList}");
                      //         print("${choosenDateTimesList.length}");
                      //
                      //         list8[selectedDayIndex].intervalList.removeAt(selectedTimeIndex);
                      //
                      //         print(list8);
                      //         Appointment appointment=
                      //         Appointment(doctorImage:widget.doctorModel.pictureUrl ,
                      //             doctorName:widget.doctorModel.name ,
                      //             appointWith: "${widget.doctorModel.id}",
                      //             appointBy: "${currentUser!.uid}",
                      //             appointsList: choosenDateTimesList);
                      //         patientAppointsList.add(appointment);
                      //         await DoctorsFirestoreRpository.
                      //         uploadDoctorAppoints(widget.doctorModel.id ,list8 ,
                      //             isUpdating:  false);
                      //
                      //         setState(() {
                      //
                      //         });
                      //         await DoctorsFirestoreRpository.uploadReservedDoctorAppoints(widget.doctorModel.id,
                      //             patientAppointsList);
                      //         await PatientFireaseRepository.uploadPatientAppoints(
                      //             currentUser!.uid, patientAppointsList ,isUpdating: false).
                      //         then((value) {
                      //           Navigator.of(context).pushReplacement(
                      //               MaterialPageRoute(builder: (context) {
                      //                 return AppointmentView(doctorId: widget.doctorModel.id,);
                      //               })
                      //           );
                      //         });
                      //
                      //
                      //
                      //         print(list8);
                      //       },
                      //       child: Container(
                      //         height: 60,
                      //         width: 100,
                      //         child: Center(child:
                      //         Text("book Appointment" ,
                      //           style: TextStyle(
                      //             fontSize: 20 ,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.white,
                      //
                      //           ),
                      //         ),),
                      //       ),
                      //     )
                      //   ],
                      // )



                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     InkWell(
                    //       onTap: (){
                    //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    //             BookingCard2(doctorModel: widget.doctorModel,)
                    //         ));
                    //       },
                    //       child: Container(
                    //         height: 60,
                    //         width: 50,
                    //         child: Center(child:
                    //         Text("Book Appointment" ,
                    //           style: TextStyle(
                    //             fontSize: 20 ,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.white,
                    //
                    //           ),
                    //         ),),
                    //       ),
                    //     ),
                    //     ,
                    //   ],
                    // ),
                  ),
                ),
              );
            }
            if(snapshot.hasError){
              return Center(child: Text("something went wrong"),);
            }

            else
              return Center(child: Text("please check internet"),);
          }

      ) ,
    );
  }

  List<String> calculateAppointsDetails(List<IntervalDetails> intervalDetails , DateTime day){
    List<String> list1=[];
    var  firstTime =day.toString().substring(11,16) ;
    List<String> intervalTimes=[firstTime];
    List<DateTime>  DatesList=[day];

    List<int> intervalTimeshours=[];



    for(var y=0 ; y<intervalDetails.length ; y++){

      //calculate for start date
      var startString=(intervalDetails[y].intervalStart!.substring(10,15));
      var splited = startString.split(':');

      int starthour = int.parse(splited[0]);
      int startminute = int.parse(splited[1]);

      DateTime daynow= DateTime(day.year , day.month , day.day ,starthour ,startminute);
           print("daynow  $daynow");

           //calculate for last date
      var endString=(intervalDetails[y].intervalEnd!.substring(10,15));
      var endsplited = endString.split(':');

      int endhour = int.parse(endsplited[0]);
      print('endhour $endhour');

      int endminute = int.parse(endsplited[1]);
      print('endminute $endminute');
           DateTime lastIntervalDate= DateTime(day.year , day.month , day.day ,endhour,endminute);

     // DateTime lastIntervalDate=endDate.add(Duration(min))
      print("lastIntervalDate $lastIntervalDate");

      list1.add('${starthour}:${startminute}');
      while((starthour<endhour)){
        startminute += intervalDetails[y].intervalPeriod!;
        if(startminute>=60){
          starthour+=1;
          startminute=0;
        }
        list1.add('${starthour}:${startminute}');
      }
      print(list1);
      // while(daynow.isBefore(lastIntervalDate)){
      //   var result = daynow.add(Duration(minutes: intervalDetails[y].intervalPeriod!));
      //   // DateTime newDate= daynow.add(Duration(minutes: 15));
      //   DatesList.add(result);
      //   daynow.add(Duration(minutes: 15));
      // }
      //
      // var result = daynow.add(Duration(minutes: intervalDetails[y].intervalPeriod!));
      // print("result $result");
      // print(daynow.isBefore(lastIntervalDate));
      //
      // print(DatesList);
      // DatesList.add(result);

      // for( DateTime x =daynow ;x.isBefore(lastIntervalDate) ;
      // x.add(Duration(minutes: intervalDetails[y].intervalPeriod!))){
      //   DatesList.add(x);
      //   print(DatesList.length);
      //   print("DatesList $DatesList");
      // }
      // if(result.isBefore(lastIntervalDate)){
      //   DatesList.add(result.add(Duration(minutes:intervalDetails[y].intervalPeriod! )));
      //   print("DatesList $DatesList");
      // }

      // if(result.isBefore(lastIntervalDate)){
      //
      //   print(lastIntervalDate);
      //   for(int o =0 ;
      //   o<intervalDetails[y].intervalPeriod! ; o+intervalDetails[y].intervalPeriod! ){
      //     if(daynow.isBefore(lastIntervalDate)){
      //       var newDate=daynow.add(Duration(minutes: intervalDetails[y].intervalPeriod!));
      //       print("newDate $newDate");
      //       DatesList.add(newDate);
      //     }
      //     // var newDate=result.add(Duration(minutes: intervalDetails[y].intervalPeriod!));
      //   }
      //   var newDate=result.add(Duration(minutes: intervalDetails[y].intervalPeriod!));
      //   DatesList.add(newDate);
      //   print("newDate $newDate");
      //
      // }
      // var timeFromResult =result.toString().substring(11,16);
      // intervalTimes.add(timeFromResult);
      // print("intervalTimes  $intervalTimes" );
      //
      // var hours = starthour+00 ;
      // int starttime=(starthour*60)+(startminute);
      // var period=intervalDetails[y].intervalPeriod;
      // var minutes =startminute+period! ;

      // for(int o =0 ;o<intervalDetails[y].intervalPeriod! ; o+intervalDetails[y].intervalPeriod!){
      //   var result = daynow.add(Duration(minutes: intervalDetails[y].intervalPeriod!));
      //   var timeString=result.toString().indexOf(" ");
      //   print("result $result");
      //   var newTime=result.toString().substring(timeString ,16);
      //   intervalTimes.add(newTime);
      // }

      // DateTime daynow= DateTime(day.year , day.month , day.day ,starthour ,startminute);
      // print("daynow ${daynow}");
      // var result = daynow.add(Duration(minutes: intervalDetails[y].intervalPeriod!));
      //
      // var timeString=result.toString().indexOf(" ");
      // var newTime=result.toString().substring(timeString ,16);
      // intervalTimes.add(newTime);
      // print("now + 30 min = ${result}");

     //  intervalTimes.add(startminute+period!);
     //  intervalTimeshours.add(starthour);
     //  List<String>  list=[];
     //    list.add(("${starthour.toString()} : ${}"));
     //  intervalTimes.add(startminute+period!);
     //  // var start =int.parse(startString) ;
     //  // print("start $start");
     //  var endString=(intervalDetails[y].intervalStart!.substring(10,15));
     //  int endhour = int.parse(endString[0]);
     //  int endminute = int.parse(endString[1]);
     //  var endTime = (endhour*60)+(endminute);
     //
     // var perio = intervalDetails[y].intervalPeriod;
    //   if(starttime > endTime){
    //     // intervalTimeOfDay.add(time1 TimeOfDay.fromDateTime(time1.));
    //     // var startSeconds =starthour
    //
    //     // intervalTimes.add(x.toInt());
    //     // var x = (endTime+(period!.toInt()))/60;
    //     // intervalTimesDetails.add(x.toInt());
    //     // for(var i=0 ; i<intervalTimes.length ; i++){
    //     //
    //     //   intervalTimesDetails.add((start+intervalTimes[i]));
    //     // }
    //   // } if(endTime > starttime){
    //   //   var hour=(end-start)*60 ;
    //   //   var x=hour/(period!);
    //   //
    //   //   intervalTimes.add(x.toInt());
    //   //   intervalTimesDetails.add(end);
    //   //   intervalTimesDetails.add((end+x.toInt()));
    //   //
    //   //   // for(var i=0 ; i<intervalTimes.length ; i++){
    //   //   //
    //   //   //   intervalTimesDetails.add((end+intervalTimes[i]));
    //   //   // }
    //   // }
    // }
    // var start =int.parse(intervalDetails.intervalStart!.substring(10,15)) ;
    // var end = int.parse(intervalDetails.intervalEnd!.substring(10,15));
    // var period = intervalDetails.intervalPeriod;
    //   if(start > end){
    //     var hour=(start-end)*60 ;
    //     var x=hour/(period!);
    //
    //     intervalTimes.add(x.toInt());
    //     intervalTimesDetails.add(start);
    //     for(var i=0 ; i<intervalTimes.length ; i++){
    //
    //       intervalTimesDetails.add((start+intervalTimes[i]));
    //     }
    //   }

  }
    return list1 ;
}

 Widget appointsTimes( List<DayDetails> list){

   var selectedDayIndex=0;
   var selectedTimeIndex=0;
    return  StatefulBuilder(builder: (BuildContext context,
         setState) {

      return Container(
        height: 200,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              child: ListView.builder(shrinkWrap: true,
                  scrollDirection:Axis.horizontal ,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    // selectedDayIndex=index;
                return Material(
                  color: selectedDayIndex == index ?AppColors.primaryColor :
                  AppColors.primaryColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: (){
                      setState( () =>
                      selectedDayIndex = index
                      );
                      print(selectedDayIndex);
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      child: Center(child:
                      Text("${list[index].dayDate.toString().substring(0,10)}" ,
                        style: TextStyle(
                          fontSize: 20 ,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,

                        ),
                      ),),
                    ),
                  ),
                );
              }),
            ) ,
            SizedBox(height: 10,),
            Container(
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection:Axis.horizontal ,
                  itemCount: calculateAppointsDetails(list[selectedDayIndex].intervalList!,
                      list[selectedDayIndex].dayDate!).length,
                  itemBuilder: (context, ind){
                    List<String> timeList=calculateAppointsDetails(list[selectedDayIndex].intervalList!,
                        list[selectedDayIndex].dayDate!);
                    return Material(
                      color: selectedTimeIndex==ind ?AppColors.primaryColor
                          :AppColors.primaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: (){
                          setState( () =>
                          selectedTimeIndex = ind
                          );
                        },
                        child: Container(
                          height: 60,
                          width: 100,
                          child: Center(child:
                          Text("${timeList[ind]}" ,
                            style: TextStyle(
                              fontSize: 20 ,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),
                          ),),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ) ;

    });


 }
  Widget newAppointsTimes( List<DayTimeDetails> list){

    // var selectedDayIndex=0;
    // var selectedTimeIndex=0;
    return  StatefulBuilder(builder: (BuildContext context,
        setState) {
      return Container(
        height: 180,
        // width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              child: ListView.builder(shrinkWrap: true,
                  scrollDirection:Axis.horizontal ,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    // selectedDayIndex=index;
                    return Container(
                      padding:EdgeInsets.only(right: 5),
                    margin: EdgeInsets.all(5),
                      height: 90,
                      child: Material(
                        color: selectedDayIndex == index ?AppColors.primaryColor :
                        AppColors.primaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: (){
                            setState( () =>
                            selectedDayIndex = index
                            );
                            choosenDayTimeDay=
                                DayTimeDetails(id: Uuid().v1(),
                                    intervalList: [],
                                    dayDate: list[selectedDayIndex].dayDate,
                                newIntervals: []);
                            print(selectedDayIndex);
                          },
                          child: Container(
                            height: 40,
                            width: 120,
                            child: Center(child:
                            Text("${list[index].dayDate.toString().substring(0,10)}" ,
                              style: TextStyle(
                                fontSize: 20 ,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,

                              ),
                            ),),
                          ),
                        ),
                      ),
                    );
                  }),
            ) ,
            SizedBox(height: 8,),
            Container(
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection:Axis.horizontal ,

                  // itemCount: list[selectedDayIndex].intervalList.length,
                  itemCount: list[selectedDayIndex].newIntervals.length,
                  itemBuilder: (context, ind){
                   // List<String> timeList=list[selectedDayIndex].intervalList;
                    //new
                    List<StringIntervalWithId> timeList=list[selectedDayIndex].newIntervals;
                    return Container(
                      // padding:EdgeInsets.only(right: 5),
                      margin: EdgeInsets.only(right: 5),
                      child: Material(
                        color: selectedTimeIndex==ind ?AppColors.primaryColor
                            :AppColors.primaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: (){
                            setState( () =>
                            selectedTimeIndex = ind
                            );
                            choosenDayTimeDay=
                                DayTimeDetails(id: Uuid().v1(),
                                    intervalList: [timeList[ind].intervalTime],
                                    dayDate: list[selectedDayIndex].dayDate,
                                newIntervals: [StringIntervalWithId(IntervalId: Uuid().v1(),
                                    intervalTime: timeList[ind].intervalTime)]  );
                          },
                          child: Container(
                            // padding:EdgeInsets.only(right: 5),
                            // margin: EdgeInsets.only(right: 10),
                            height: 30,
                             width: 60,
                            child: Center(child:
                            Text("${timeList[ind].intervalTime}" ,
                              style: TextStyle(
                                fontSize: 20 ,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,

                              ),
                            ),),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ) ;

    });


  }
}
