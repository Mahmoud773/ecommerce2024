import 'package:amazon/Facility_Manager/models/Problem_model.dart';
import 'package:amazon/doctors/models/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uuid/uuid.dart';

import '../consts/colors.dart';
import '../ecommerce/services/auth.dart';
import '../models/booking_date_time_converter.dart';
import '../res/components/Custom_text_field_new.dart';
import '../views/patient/booked_seccess_screen.dart';
import 'Home_with_bottomBar_Screenr.dart';
import 'Success_add_problemScreen.dart';
import 'customer_repository/customer_auth.dart';
import 'customer_repository/customer_firestore_repository.dart';
import 'facility_home_screen.dart';
import 'models/Customer_model.dart';

class AddProblemScreen extends StatefulWidget {
   String problemType;
  // final CustomerModel customerModel;
   AddProblemScreen({ super.key,
     // required this.customerModel ,
     required this.problemType});

  @override
  State<AddProblemScreen> createState() => _AddProblemScreenState();
}

class _AddProblemScreenState extends State<AddProblemScreen> {

  final User? user = FirebaseAuth.instance.currentUser;

  ProblemModel problemModel =ProblemModel(id: Uuid().v1(),
      problemBy: "", number: '', unitNumber: '', customerName: '', rating: '', isAgreeToSolvingDate: false);
  List<ProblemModel> probelmList=[];
  var firstItem="تكنولوجيا المعلومات It";
  var secondItem="مدنى Civil";
  var thirdItem="تكييف AC";
  var fourthItem="كهرباء Electricity";
  var fifthItem="سباكة Plumbing";
  var sixItem="H.K";
  var seventhItem="L.C";
  var eighthItem="other";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth=Auth();
  bool _saving = false;
  String problemType="";
  String email='';
  String problemDetails='';
  String name='';
  String unitNumber='';
  String problemDate='';
  String problemTime='';
  String mallName='';
  String repricingDate='';

  final now=DateTime.now();
  List  textContollersList=[];
  TextEditingController detailsTextEditingController =TextEditingController();
  TextEditingController nameTextEditingController =TextEditingController();
  TextEditingController unitNumberTextEditingController =TextEditingController();
  TextEditingController dateTextEditingController =TextEditingController();
  TextEditingController mallNameTextEditingController =TextEditingController();
  TextEditingController datePricingTextEditingController =TextEditingController();
  List<DayDetails> daysDetails=[];

  IntervalDetails _intervalDetails= IntervalDetails();


  @override
  Widget build(BuildContext context) {
   print(widget.problemType);
    final uid = user!.uid;
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return ModalProgressHUD(
        inAsyncCall: _saving,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
            leading: IconButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return FMHomeBarscreen();
              }));
            }, icon: Icon(Icons.arrow_back)),
          title: Text("Make an Order"),
          actions: <Widget>[
            InkWell(
              onTap: (){},
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  width: 36,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("0")),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
                width:double.infinity*90/100,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/fm3.jpg'),
                        fit: BoxFit.cover
                    )
                ),
                //child: Image.asset('assets/images/fm2.jpg'),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                height: 60,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[400],

                ),

               child:
                 Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 10,),
                      Text("problem type",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width:10),
                      Text((widget.problemType.length>1 && problemType.length<1)?"${widget.problemType}" :"${problemType}",
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      Spacer(),
                      PopupMenuButton(
                        initialValue: widget.problemType,
                        itemBuilder: (context) =>[
                          PopupMenuItem(child:
                          Text(firstItem) ,
                            value: firstItem,) ,
                          PopupMenuItem(child:
                          Text(secondItem) ,
                            value: secondItem,) ,
                          PopupMenuItem(child:
                          Text(thirdItem) ,
                            value: thirdItem,) ,
                          PopupMenuItem(child:
                          Text(fourthItem) ,
                            value: fourthItem,) ,
                          PopupMenuItem(child:
                          Text(fifthItem) ,
                            value: fifthItem,) ,
                          PopupMenuItem(child:
                          Text(sixItem) ,
                            value: sixItem,) ,
                          PopupMenuItem(child:
                          Text(seventhItem) ,
                            value: seventhItem,) ,
                          // PopupMenuItem(child:
                          // Text(eighthItem) ,
                          //   value: eighthItem,) ,

                        ]
                        ,onSelected: (value){
                        setState(() {
                          //widget.problemType=value;
                          problemType=value;
                          print(problemType);
                        });
                      },
                      ),
                    ],
                  ),



              ) ,
              SizedBox(height: 20,),
              MyCustomTextField(
                obsecureText: false,
                hint: "Enter problem details",
                textEditingController: detailsTextEditingController,
                onSave: (String? value){
                  //problemDetails=detailsTextEditingController.text ;
                  problemDetails =value!;
                },
                validator: (String? value){
                  if(value == null ||value.isEmpty || value.length <3){
                    return "problem details must be not less than 3 characters";
                  }else problemDetails=detailsTextEditingController.text ;
                },
                icon: Icons.report_problem_outlined,

              ),
              SizedBox(height: 20,),
              MyCustomTextField(
                obsecureText: false,
                hint: "Enter Your name",
                textEditingController: nameTextEditingController,
                onSave: (String? value){
                name=  nameTextEditingController.text ;
                  name =value!;
                },
                validator: (String? value){
                  if(value == null ||value.isEmpty || value.length <3){
                    return "name must be not less than 3 characters";
                  }else name=nameTextEditingController.text ;
                },
                icon: Icons.person,

              ),
              SizedBox(height: 20,),
              MyCustomTextField(
                obsecureText: false,
                hint: "Enter unit Number",
                textEditingController: unitNumberTextEditingController,
                onSave: (String? value){
                  unitNumber =   unitNumberTextEditingController.text;
                  unitNumber =value!;
                },
                validator: (String? value){
                  if(value == null ||value.isEmpty || value.length <3){
                    return "problem details must be not less than 5 characters";
                  }
                },
                icon: Icons.report_problem_outlined,

              ),
              SizedBox(height: 20,),
              MyCustomTextField(
                onSave: (String? value){

                  mallName =value!;
                  mallName= mallNameTextEditingController.text;
                },
                icon: Icons.timelapse_outlined,
                hint: "enter Mall name",
                validator: (String? value){
                  if(value == null ||value.isEmpty || value.length <3){
                    return "enter Mall name";
                  }
                },

                // onTap: ()async{
                //   var time= await  pickTime();
                //   if(time !=null) {
                //     problemTime =time.toString();
                //     mallNameTextEditingController.text=problemTime;
                //     _intervalDetails=IntervalDetails(
                //         intervalNumber:0,
                //         intervalStart:time.toString(),
                //         intervalEnd: time.toString() ,
                //         intervalPeriod: 0
                //     );
                //
                //   }
                // },
                textEditingController: mallNameTextEditingController,
              ),

              // MyCustomTextField(
              //   obsecureText: false,
              //   hint: "choose available solving date",
              //   onSave: (String? value){
              //     problemDate =value!;
              //   },
              //   validator: (String? value){
              //     if(value == null ||value.isEmpty || value.length <3){
              //       return "please choose date";
              //     }
              //   },
              //   icon: Icons.date_range,
              //   onTap: () async{
              //       var date = await  showDatePicker(
              //         context: context,
              //         initialDate: DateTime.now(),
              //         firstDate:DateTime.now() ,
              //         lastDate: DateTime(now.year, now.month , now.day+7),
              //       );
              //       if(date != null) {
              //
              //         String formattedDate =DateFormat("yyyy-MM-dd").format(date);
              //         problemDate=formattedDate;
              //
              //         dateTextEditingController.text=formattedDate;
              //         textContollersList.add(TextEditingController(text:formattedDate ));
              //
              //       }
              //     },
              //
              //   textEditingController:dateTextEditingController,
              //
              // ),
              SizedBox(height: 20,),
              //date pricing text field
              // problemType==eighthItem?
              // MyCustomTextField(
              //   onSave: (String? value){
              //
              //     mallName =value!;
              //     mallName= mallNameTextEditingController.text;
              //   },
              //   icon: Icons.timelapse_outlined,
              //   hint: "choose date to Pricing",
              //   validator: (String? value){
              //     if(value == null ||value.isEmpty || value.length <3){
              //       return "choose date to Pricing";
              //     }
              //   },
              //   onTap: () async{
              //     var date = await  showDatePicker(
              //       context: context,
              //       initialDate: DateTime.now(),
              //       firstDate:DateTime.now() ,
              //       lastDate: DateTime(now.year, now.month , now.day+7),
              //     );
              //     if(date != null) {
              //
              //       String formattedDate =DateFormat("yyyy-MM-dd").format(date);
              //       repricingDate=formattedDate;
              //
              //       datePricingTextEditingController.text=formattedDate;
              //       //textContollersList.add(TextEditingController(text:formattedDate ));
              //     }
              //   },
              //   // onTap: ()async{
              //   //   var time= await  pickTime();
              //   //   if(time !=null) {
              //   //     problemTime =time.toString();
              //   //     mallNameTextEditingController.text=problemTime;
              //   //     _intervalDetails=IntervalDetails(
              //   //         intervalNumber:0,
              //   //         intervalStart:time.toString(),
              //   //         intervalEnd: time.toString() ,
              //   //         intervalPeriod: 0
              //   //     );
              //   //
              //   //   }
              //   // },
              //   textEditingController: datePricingTextEditingController,
              // ):
              // Container(),
           //    MyCustomTextField(
           //      onSave: (String? value){
           //      problemTime =value!;
           //    },
           //      icon: Icons.timelapse_outlined,
           //        hint: "choose solving time",
           //      validator: (String? value){
           //      if(value == null ||value.isEmpty || value.length <3){
           //      return "please choose date";
           //      }
           //      },
           //
           //      onTap: ()async{
           // var time= await  pickTime();
           // if(time !=null) {
           //   problemTime =time.toString();
           //   mallNameTextEditingController.text=problemTime;
           //      _intervalDetails=IntervalDetails(
           //      intervalNumber:0,
           //      intervalStart:time.toString(),
           //      intervalEnd: time.toString() ,
           //      intervalPeriod: 0
           //      );
           //
           //      }
           //      },
           //   textEditingController: mallNameTextEditingController,
           //      ),




            ],
          ),
        )
        ),
        // bottomSheet: Material(
        //     color: Colors.deepPurpleAccent,
        //     borderRadius: BorderRadius.circular(20),
        //     child: InkWell(
        //           onTap: () async {
        //               final number =Uuid().v1().substring(26);
        //             problemModel=ProblemModel(id: Uuid().v1(),number:number,
        //                 problemBy: uid ,isCompleted: false,
        //             problemDate: problemDate ,problemDetails: problemDetails,problemtime: problemTime,
        //             problemType: problemType, unitNumber: unitNumber, customerName: name );
        //             probelmList.add(problemModel);
        //
        //            if(_formKey.currentState!.validate() == true) {
        //              _saving=true;
        //              _formKey.currentState!.save();
        //              setState(() {
        //
        //              });
        //
        //             await CustomersFirestoreRpository.uploadProblems(uid, probelmList);
        //              await CustomersFirestoreRpository.uploadAllProblems("all_problems", probelmList,true);
        //
        //             Navigator.pushReplacement(context, MaterialPageRoute(builder:
        //             (context) {
        //               return ProblemAddSuccessBooked(doctorId: uid,problemNumber :problemModel.number,
        //                 list8: [],);
        //             }
        //             ));
        //            }
        //           },
        //           child: Container(
        //             height: 60,
        //             width: width*95/100,
        //             child: Center(child:
        //             Text("Save" ,
        //               style: TextStyle(
        //                 fontSize: 20 ,
        //                 fontWeight: FontWeight.bold,
        //                 color: Colors.white,
        //
        //               ),
        //             ),),
        //           ),
        //         )
        //   // Row(
        //   //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   //   children: [
        //   //     InkWell(
        //   //       onTap: (){
        //   //
        //   //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //   //             BookingCard2(doctorModel: widget.doctorModel,)
        //   //         ));
        //   //       },
        //   //       child: Container(
        //   //         height: 60,
        //   //         width: 100,
        //   //         child: Center(child:
        //   //         Text("add Appointment" ,
        //   //           style: TextStyle(
        //   //             fontSize: 20 ,
        //   //             fontWeight: FontWeight.bold,
        //   //             color: Colors.white,
        //   //
        //   //           ),
        //   //         ),),
        //   //       ),
        //   //     ),
        //   //     SizedBox(width: 10,),
        //   //     InkWell(
        //   //       onTap: () async{
        //   //         choosenDateTimesList.add(choosenDayTimeDay);
        //   //         print("choosenDateTimesList ${choosenDateTimesList[0].dayDate}");
        //   //         print("choosenDateTimesList ${choosenDateTimesList[0].intervalList}");
        //   //         print("${choosenDateTimesList.length}");
        //   //
        //   //         list8[selectedDayIndex].intervalList.removeAt(selectedTimeIndex);
        //   //
        //   //         print(list8);
        //   //         Appointment appointment=
        //   //         Appointment(doctorImage:widget.doctorModel.pictureUrl ,
        //   //             doctorName:widget.doctorModel.name ,
        //   //             appointWith: "${widget.doctorModel.id}",
        //   //             appointBy: "${currentUser!.uid}",
        //   //             appointsList: choosenDateTimesList);
        //   //         patientAppointsList.add(appointment);
        //   //         await DoctorsFirestoreRpository.
        //   //         uploadDoctorAppoints(widget.doctorModel.id ,list8 ,
        //   //             isUpdating:  false);
        //   //
        //   //         setState(() {
        //   //
        //   //         });
        //   //         await DoctorsFirestoreRpository.uploadReservedDoctorAppoints(widget.doctorModel.id,
        //   //             patientAppointsList);
        //   //         await PatientFireaseRepository.uploadPatientAppoints(
        //   //             currentUser!.uid, patientAppointsList ,isUpdating: false).
        //   //         then((value) {
        //   //           Navigator.of(context).pushReplacement(
        //   //               MaterialPageRoute(builder: (context) {
        //   //                 return AppointmentView(doctorId: widget.doctorModel.id,);
        //   //               })
        //   //           );
        //   //         });
        //   //
        //   //
        //   //
        //   //         print(list8);
        //   //       },
        //   //       child: Container(
        //   //         height: 60,
        //   //         width: 100,
        //   //         child: Center(child:
        //   //         Text("book Appointment" ,
        //   //           style: TextStyle(
        //   //             fontSize: 20 ,
        //   //             fontWeight: FontWeight.bold,
        //   //             color: Colors.white,
        //   //
        //   //           ),
        //   //         ),),
        //   //       ),
        //   //     )
        //   //   ],
        //   // )
        //
        //
        //
        //   // Row(
        //   //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   //   children: [
        //   //     InkWell(
        //   //       onTap: (){
        //   //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //   //             BookingCard2(doctorModel: widget.doctorModel,)
        //   //         ));
        //   //       },
        //   //       child: Container(
        //   //         height: 60,
        //   //         width: 50,
        //   //         child: Center(child:
        //   //         Text("Book Appointment" ,
        //   //           style: TextStyle(
        //   //             fontSize: 20 ,
        //   //             fontWeight: FontWeight.bold,
        //   //             color: Colors.white,
        //   //
        //   //           ),
        //   //         ),),
        //   //       ),
        //   //     ),
        //   //     ,
        //   //   ],
        //   // ),
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
          final number =Uuid().v1().substring(1,8);


          if(_formKey.currentState!.validate()) {

            print(unitNumber);
            _saving=true;
            _formKey.currentState!.save();
            problemModel=ProblemModel(id: Uuid().v1(),number:number,
                problemBy: uid ,isCompleted: false,
                problemDate: DateTime.now().toString() ,problemDetails: problemDetails,problemtime: problemTime,
                problemType: (widget.problemType.length>1 && problemType.length<1) ? widget.problemType: problemType, unitNumber: unitNumber, customerName: name ,
            isPending: false,requiredEquipment: "",solvedById: "",teamMembers: "",workOrderDetails: "",
                rating: '', mallName: mallName, isAgreeToSolvingDate: false);
            probelmList.add(problemModel);
                print(problemType);
            setState(() {

            });

            await CustomersFirestoreRpository.uploadProblems(uid, probelmList);
            await CustomersFirestoreRpository.uploadAllProblems("all_problems", probelmList,merge: true);

            Navigator.pushReplacement(context, MaterialPageRoute(builder:
                (context) {
              return ProblemAddSuccessBooked(doctorId: uid,problemNumber :problemModel.number,
                list8: [],);
            }
            ));
          }
        } ,
          child: Material( color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(20),

          child: Container(
            height: 70,
           width: 100,
            child: Center(child:
            Text("Save" ,
              style: TextStyle(
                fontSize: 18 ,
                fontWeight: FontWeight.bold,
                color: Colors.white,

              ),
            ),),
          ),),
        ),
      ),
    );
  }

  Widget customDayIntervalsCard(IntervalDetails intervalDetails , ValueKey key){
    return  Container(
      // width: 200,

      padding: EdgeInsets.all(5),
      margin:EdgeInsets.all(5),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor.withOpacity(0.5),

              AppColors.primaryColor.withOpacity(0.9),

            ],
            begin: Alignment.topCenter,
            end:Alignment.bottomCenter,
          )
      ),
      child: Container(
        key:key,
        child: SingleChildScrollView(
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("start" , style: TextStyle(
                      fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.white
                  ),),
                  SizedBox(height: 5,),
                  Text("${intervalDetails.intervalStart!.substring(10,15)}"
                    ,style: TextStyle(color:  Colors.white),) ,
                ],
              ) ,
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("end" , style: TextStyle(
                      fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.white
                  ),),
                  SizedBox(height: 5,),
                  Text("${intervalDetails.intervalEnd!.substring(10,15)}"
                    ,style: TextStyle(color:  Colors.white),) ,
                ],
              ) ,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("period" , style: TextStyle(
                      fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.white
                  ),),
                  SizedBox(height: 5,),
                  Text("${intervalDetails.intervalPeriod}"
                    ,style: TextStyle(color:  Colors.white),) ,
                ],
              ) ,
            ],
          ),
        ),
      ),
    ) ;
  }

  Widget appointsDayCard(DayDetails dayDetails){
    return

      Container(
        padding: EdgeInsets.all(5),
        margin:EdgeInsets.all(5),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor.withOpacity(0.5),

                AppColors.primaryColor.withOpacity(0.9),

              ],
              begin: Alignment.topCenter,
              end:Alignment.bottomCenter,
            )
        ),
        //height: 200,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${dayDetails.dayDate.toString().substring(0,10)}" ,
                style: TextStyle(color: Colors.white , fontSize: 18),),
              SizedBox(height: 10,),
              Container(

                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return  Row(
                        key: ValueKey("${dayDetails.intervalList![index]}") ,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("From",style: TextStyle(color: Colors.white),) ,
                              SizedBox(height: 10,),
                              Text(
                                "${dayDetails.intervalList![index].intervalStart!.substring(10,15)}",
                                style: TextStyle(color: Colors.white),

                              ),
                            ],
                          ),
                          SizedBox(width: 5,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("To",style: TextStyle(color: Colors.white),) ,
                              SizedBox(height: 10,),
                              Text("${dayDetails.intervalList![index].intervalEnd!.substring(10,15)}",
                                style: TextStyle(color: Colors.white),),
                            ],
                          ),
                          SizedBox(width: 5,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("period",style: TextStyle(color: Colors.white),) ,
                              SizedBox(height: 10,),
                              Text("${dayDetails.intervalList![index].intervalPeriod}",
                                style: TextStyle(color: Colors.white),),
                            ],
                          ),
                          SizedBox(width: 5,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 10,),
                              IconButton(onPressed: (){
                                dayDetails.intervalList!.removeAt(index);
                                setState(() {

                                });
                              },
                                  icon: Icon(Icons.delete , color: Colors.amber,)),
                            ],
                          ),
                          SizedBox(width: 5,),
                        ],
                      );
                    }
                    ,
                    itemCount:dayDetails.intervalList!.length ),
              )
            ],
          ),
        ),
      ) ;
  }


  List<DayTimeDetails> calculateDayTimes(List<DayDetails> daysList){
    List<DayTimeDetails> myList=[];
    for(var x=0; x<daysList.length;x++){
      List<String> list =calculateAppointsDetails(daysList[x].intervalList!,daysList[x].dayDate!);
      //new
      List<StringIntervalWithId> newIntervals =list.map((e) => StringIntervalWithId(
          IntervalId: Uuid().v1(),
          intervalTime: e
      )).toList();
      DayTimeDetails dayTimeDetails=DayTimeDetails(id: Uuid().v1(),
          intervalList:list ,dayDate: daysList[x].dayDate! ,
          newIntervals: newIntervals
      );
      myList.add(dayTimeDetails);
      print("newIntervals length${newIntervals.length}");

    }
    return myList;
  }

  List<String> calculateAppointsDetails(List<IntervalDetails> intervalDetails , DateTime day){
    List<String> list1=[];
    var  firstTime =day.toString().substring(11,16) ;
    List<String> intervalTimes=[firstTime];
    List<DateTime>  DatesList=[day];

    List<int> intervalTimeshours=[];
    // var startString=(intervalDetails[0].intervalStart!.substring(10,15));
    // var splited = startString.split(':');
    //
    // int starthour = int.parse(splited[0]);
    // int startminute = int.parse(splited[1]);
    // int starttime=(starthour*60)+(startminute);
    // List<int> intervalTimesDetails=[(starttime/60).toInt()];
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
  Future<TimeOfDay?> pickTime() => showTimePicker(context: context,
      initialTime:  TimeOfDay(hour: 8, minute: 0)
  );
}
