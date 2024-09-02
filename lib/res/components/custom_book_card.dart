
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../consts/colors.dart';
import '../../doctors/firestore_Repository/firetore_repository.dart';
import '../../doctors/models/doctor_model.dart';
import '../../models/booking_date_time_converter.dart';
import '../../views/Doctor_new_Details.dart';
import 'custom_button.dart';
class BookingCard extends StatefulWidget {
  final DoctorModel doctorModel;


   BookingCard({Key? key, required this.doctorModel}) : super(key: key);

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {

  int dayNumber=1;
  Map<String ,List<IntervalDetails>> timesMap={
    "firstDay":[],
    "secondDay":[],
    "thirdDay":[],
  };
  List firstDayIntervals=[];
  TextEditingController firstDayController =TextEditingController();
  TextEditingController secondDayController =TextEditingController();
  TextEditingController ThirdDayController =TextEditingController();
  final now=DateTime.now();
  DateTime? firstDay;
  List workDaysList=[];
  int nuOfIntervals=0;
  List intervals=[];
  List<IntervalDetails> intervalDetailsList=[];

  int dropDownvalue=15;
  int intervalPeriod=0;
  int newNumberOfIntervals=0;
  List<TextEditingController> controllerList=[TextEditingController()];

  List<DayDetails> daysList=[DayDetails
    (dayNumber: 1 , intervalList: [],dayName: "satur" ,dayDate: DateTime.now())];
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    // controllerList=[firstDayController,secondDayController,ThirdDayController];
    return Scaffold(
      appBar: AppBar(
        title: TextButton(child: Text("Add Appointments" ,style: TextStyle(
          color: Colors.white
        ),),onPressed: () async{
       try {
         await DoctorsFirestoreRpository.uploadAppoints(widget.doctorModel.id ,daysList);
         print("${daysList}");

       }
           catch(e){
             log(e.toString());
             rethrow;
           }
        }
        ),

        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back)),
      ),
      floatingActionButton: IconButton(
          onPressed: (){
            controllerList.add(TextEditingController());
            dayNumber +=1;
            daysList.add(DayDetails(dayNumber: dayNumber , intervalList: [] , dayName: "satur",dayDate: DateTime.now()));
            timesMap.addAll({"secondDay": []});

            setState(() {

            });
            }
          , icon: Icon(Icons.add)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:List.generate(daysList.length,
                  (index) =>
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: width,
                  child: TextFormField(
                    controller: controllerList[index],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "choose date"
                    ),
                    onTap: () async{
                      var date = await  showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:DateTime.now() ,
                        lastDate: DateTime(now.year, now.month , now.day+7),
                      );

                      if(date !=null) {
                        String formattedDate =DateFormat("yyyy-MM-dd").format(date);
                        // firstDayController.text =formattedDate;
                        controllerList[index].text=formattedDate;
                        firstDay=date;
                        workDaysList.add(firstDay);
                        timesMap.addAll({"secondDay": []});
                        daysList[index].dayDate=date;
                        // daysList.add(DayDetails(
                        //   dayNumber:  dayNumber+1,
                        //   dayDate: date ,
                        //
                        // ));

                      }
                    }
                    ,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      MaterialButton(onPressed:
                          () async{

                        await  showDialog(context: context,
                          builder: (context)
                          {
                            return StatefulBuilder(
                              builder: (BuildContext context,
                                  void Function(void Function()) setState) {
                                TextEditingController startController =TextEditingController();
                                TextEditingController endController =TextEditingController();
                                TextEditingController periodController =TextEditingController();
                                List<IntervalDetails> intervaldetails1 =[];
                                IntervalDetails _intervalDetails= IntervalDetails();
                                return SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AlertDialog(
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [

                                              Container(

                                                child: TextFormField(

                                                  decoration: InputDecoration(
                                                      hintText: "Start Time",
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                      )
                                                  ),
                                                  onTap: () async {
                                                    final time = await pickTime();
                                                    if(time != null){
                                                      startController.text =time.toString();
                                                      _intervalDetails=IntervalDetails( intervalNumber:
                                                      newNumberOfIntervals,intervalStart: time.toString());
                                                      intervaldetails1.add(_intervalDetails);

                                                    }
                                                  },
                                                  controller: startController,
                                                ),
                                                width: width,

                                              ),
                                              SizedBox(height: 10,),
                                              Container(

                                                child: TextFormField(

                                                  decoration: InputDecoration(
                                                      hintText: "End Time",
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                      )
                                                  ),
                                                  onTap: () async {
                                                    final time = await pickTime();
                                                    if(time != null){

                                                      endController.text =time.toString();
                                                      _intervalDetails=IntervalDetails(
                                                          intervalNumber: _intervalDetails.intervalNumber,
                                                          intervalStart:
                                                          _intervalDetails.intervalStart ,
                                                          intervalEnd: time.toString() ,intervalPeriod: 15
                                                      );
                                                      intervaldetails1[0] =_intervalDetails;
                                                      // timesMap["$firstDay"]=[];


                                                    }
                                                  },
                                                  controller: endController,
                                                ),
                                                width: width,
                                                // height: 30,
                                              ),
                                              SizedBox(height: 10,),
                                              Container(

                                                child: TextFormField(

                                                  decoration: InputDecoration(
                                                      hintText: "Consult period",
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                      )
                                                  ),
                                                  controller: periodController,
                                                  keyboardType:TextInputType.number ,
                                                  onChanged: (value){
                                                    if(value !=null ){
                                                      _intervalDetails=IntervalDetails(
                                                          intervalNumber: _intervalDetails.intervalNumber,
                                                          intervalStart:
                                                          _intervalDetails.intervalStart ,
                                                          intervalEnd: _intervalDetails.intervalEnd ,
                                                          intervalPeriod:int.parse(value)

                                                      );
                                                      dropDownvalue=int.parse(value);
                                                      intervaldetails1[0] =_intervalDetails;
                                                    }
                                                  },
                                                ),
                                                width: width,
                                                // height: 30,
                                              ),
                                              // Container(
                                              //
                                              //   child: Row(
                                              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              //     children: [
                                              //       Container(
                                              //
                                              //         child: TextFormField(
                                              //
                                              //           decoration: InputDecoration(
                                              //               hintText: "Start Time",
                                              //               border: OutlineInputBorder(
                                              //                 borderRadius: BorderRadius.all(Radius.circular(20)),
                                              //               )
                                              //           ),
                                              //           onTap: () async {
                                              //             final time = await pickTime();
                                              //             if(time != null){
                                              //               startController.text =time.toString();
                                              //               _intervalDetails=IntervalDetails( intervalNumber:
                                              //               newNumberOfIntervals,intervalStart: time);
                                              //               intervaldetails1.add(_intervalDetails);
                                              //
                                              //             }
                                              //           },
                                              //           controller: startController,
                                              //         ),
                                              //         width: 100,
                                              //         height: 30,
                                              //       ),
                                              //       SizedBox(width: 20,),
                                              //       Container(
                                              //
                                              //         child: TextFormField(
                                              //
                                              //           decoration: InputDecoration(
                                              //               hintText: "End Time",
                                              //               border: OutlineInputBorder(
                                              //                 borderRadius: BorderRadius.all(Radius.circular(20)),
                                              //               )
                                              //           ),
                                              //           onTap: () async {
                                              //             final time = await pickTime();
                                              //             if(time != null){
                                              //
                                              //               endController.text =time.toString();
                                              //               _intervalDetails=IntervalDetails(
                                              //                   intervalNumber: _intervalDetails.intervalNumber,
                                              //                   intervalStart:
                                              //                   _intervalDetails.intervalStart ,
                                              //                   intervalEnd: time ,intervalPeriod: 15
                                              //               );
                                              //               intervaldetails1[0] =_intervalDetails;
                                              //               // timesMap["$firstDay"]=[];
                                              //
                                              //
                                              //             }
                                              //           },
                                              //           controller: endController,
                                              //         ),
                                              //         width: 100,
                                              //         height: 30,
                                              //       ),
                                              //       SizedBox(width: 20,),
                                              //       Container(
                                              //
                                              //         child: TextFormField(
                                              //
                                              //           decoration: InputDecoration(
                                              //               hintText: "Consult period",
                                              //               border: OutlineInputBorder(
                                              //                 borderRadius: BorderRadius.all(Radius.circular(20)),
                                              //               )
                                              //           ),
                                              //           controller: periodController,
                                              //           onChanged: (value){
                                              //             if(value !=null ){
                                              //               _intervalDetails=IntervalDetails(
                                              //                   intervalNumber: _intervalDetails.intervalNumber,
                                              //                   intervalStart:
                                              //                   _intervalDetails.intervalStart ,
                                              //                   intervalEnd: _intervalDetails.intervalEnd ,
                                              //                   intervalPeriod:int.parse(value)
                                              //
                                              //               );
                                              //               intervaldetails1[0] =_intervalDetails;
                                              //             }
                                              //           },
                                              //         ),
                                              //         width: 100,
                                              //         height: 30,
                                              //       ),
                                              //
                                              //
                                              //     ],
                                              //   ),
                                              // ),
                                              SizedBox(height: 20,),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(onPressed: (){
                                            newNumberOfIntervals +=1 ;
                                            nuOfIntervals+= 1;
                                            intervalDetailsList.add(_intervalDetails);
                                            timesMap["$firstDay"]=  intervalDetailsList;
                                            daysList[index].intervalList!.add(_intervalDetails);
                                            print("${daysList[0].intervalList![0].intervalStart}");
                                            widget.doctorModel.appointsDays =daysList;
                                            this.setState(() {

                                            });

                                            Navigator.of(context).pop();

                                          },
                                              child: Text('Save'
                                              )) ,

                                          TextButton(
                                              onPressed:() {
                                                Navigator.of(context).pop();

                                              }, child:
                                          Text('Cancel' ,
                                            style: TextStyle(fontSize: 20),)),
                                        ],
                                      ),

                                    ],
                                  ),
                                );
                              },

                            );
                          } ,
                        );
                        // setState(() {
                        //   nuOfIntervals+= 1;
                        //   intervalDetailsList.add(IntervalDetails());
                        // });

                      }
                        , child:  Text("Add Working Times" , style: TextStyle(
                            fontSize: 20 , fontWeight: FontWeight.bold , color: AppColors.primaryColor
                        ),)
                        ,),
                      SizedBox(height: 10,),
                      // nuOfIntervals>0
                      (daysList[index].intervalList!.length>0 &&daysList[index].intervalList !=null)
                          ?
                      // Text('${timesMap["$firstDay"]![0].intervalStart}')
                      Column(
                        children: List.generate(daysList[index].intervalList!.length,
                                (ind) =>
                                Container(
                                  padding: EdgeInsets.all(20),
                                  margin:EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryColor.withOpacity(0.4),

                                          AppColors.primaryColor.withOpacity(0.8),

                                        ],
                                        begin: Alignment.topCenter,
                                        end:Alignment.bottomCenter,
                                      )
                                  ),
                                  child: Container(
                                    key:ValueKey('${daysList[index].intervalList![ind]}'),
                                    child: Row(

                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("start" , style: TextStyle(
                                                fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.white
                                            ),),
                                            SizedBox(height: 5,),
                                            Align(alignment: Alignment.centerLeft,
                                              child: MaterialButton(
                                                color: AppColors.primaryColor,
                                                onPressed: () async {
                                                  final time  =await pickTime();
                                                  if(time == null) return;
                                                  setState(() {
                                                    // Hours= time.hour;
                                                    // minutes=time.minute;
                                                    // _firstIntervalDetails=IntervalDetails(intervalNumber:
                                                    // workDaysList.indexOf(_currentDay)+1, intervalStart:
                                                    // time, );
                                                    // intervalDetailsList.first= IntervalDetails(intervalNumber:
                                                    // workDaysList.indexOf(_currentDay)+1, intervalStart:
                                                    // time, );
                                                    daysList[index].intervalList![ind]=IntervalDetails(intervalNumber:
                                                    daysList[index].intervalList![ind].intervalNumber, intervalStart:
                                                    time.toString(),intervalPeriod: daysList[index].intervalList![ind].intervalPeriod,
                                                        intervalEnd: daysList[index].intervalList![ind].intervalEnd);
                                                  });

                                                },
                                                child:
                                                // Text('${timesMap["$firstDay"]![index].intervalStart}') ,

                                                Text(daysList[index].intervalList![ind].intervalStart== null ?"00:00"
                                                    :" ${daysList[index].intervalList![ind].intervalStart!} :"
                                                    " ${daysList[index].intervalList![ind].intervalStart!} "
                                                  ,style: TextStyle(color:  Colors.white),) ,

                                              ),
                                            ) ,
                                          ],
                                        ) ,
                                        SizedBox(width: 10,),
                                        // Column(
                                        //
                                        //   mainAxisAlignment: MainAxisAlignment.start,
                                        //   children: [
                                        //     Text("End" , style: TextStyle(
                                        //         fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.white
                                        //     ),),
                                        //     SizedBox(height: 5,),
                                        //     MaterialButton(
                                        //       color: AppColors.primaryColor,
                                        //       onPressed: () async {
                                        //         final time  =await pickTime();
                                        //         if(time == null) return;
                                        //         setState(() {
                                        //           // Hours1= time.hour;
                                        //           // minutes1=time.minute;
                                        //           // _firstIntervalDetails=IntervalDetails(intervalNumber:
                                        //           // nuOfIntervals, intervalEnd:
                                        //           // time,intervalStart:  _firstIntervalDetails.intervalStart ,
                                        //           //     intervalPeriod:_firstIntervalDetails.intervalPeriod );
                                        //           intervalDetailsList[ind]=IntervalDetails(intervalNumber:
                                        //           intervalDetailsList[ind].intervalNumber, intervalEnd:
                                        //           time,intervalStart:  intervalDetailsList[ind].intervalStart ,
                                        //               intervalPeriod:intervalDetailsList[ind].intervalPeriod );
                                        //         });
                                        //
                                        //       },
                                        //
                                        //       child: Text(intervalDetailsList[ind].intervalEnd== null ?"00:00"
                                        //           :
                                        //       "${intervalDetailsList[ind].intervalEnd!.hour} :"
                                        //           " ${intervalDetailsList[ind].intervalEnd!.minute} " ,
                                        //         style: TextStyle(
                                        //             fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.white
                                        //         ),) ,
                                        //
                                        //     ) ,
                                        //   ],
                                        // ),
                                        // SizedBox(width: 10,),
                                        // Column(
                                        //   // crossAxisAlignment: CrossAxisAlignment.start,
                                        //   mainAxisAlignment: MainAxisAlignment.start,
                                        //   children: [
                                        //     Text("period" , style: TextStyle(
                                        //         fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.white
                                        //     ),
                                        //     ),
                                        //     SizedBox(height: 10,),
                                        //     Align(
                                        //       alignment: Alignment.centerLeft,
                                        //       child: Container(
                                        //         padding: EdgeInsets.only(left: 15),
                                        //         // margin: EdgeInsets.only(left: 30),
                                        //         color: AppColors.primaryColor,
                                        //         width: 50,
                                        //         height: 40,
                                        //         child: TextFormField(
                                        //           style: TextStyle(
                                        //             fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.white ,
                                        //           ),
                                        //           initialValue:intervalDetailsList[ind].intervalPeriod.toString() ,
                                        //           decoration: InputDecoration(
                                        //             // label: Text("Perioid" , ),
                                        //           ),
                                        //           keyboardType:TextInputType.number ,
                                        //           onChanged: (value){
                                        //             intervalDetailsList[ind]=IntervalDetails(intervalNumber:
                                        //             intervalDetailsList[ind].intervalNumber, intervalStart:
                                        //             intervalDetailsList[ind].intervalStart,intervalPeriod: int.parse(value),
                                        //                 intervalEnd: intervalDetailsList[ind].intervalEnd);
                                        //           },
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     // DropdownButton<int>(
                                        //     //   style: TextStyle(
                                        //     //       fontSize: 15 , fontWeight: FontWeight.bold , color: AppColors.primaryColor
                                        //     //   ),
                                        //     //   // padding: EdgeInsets.all(5),
                                        //     //   // hint: Text('نوع الفاتورة', style: TextStyle(color: Colors.black
                                        //     //   //     ,fontWeight: FontWeight.bold
                                        //     //   // ),),
                                        //     //   icon: Icon(Icons.arrow_drop_down_outlined),
                                        //     //   value: dropDownvalue,
                                        //     //   items: [
                                        //     //     DropdownMenuItem(value: dropDownvalue,
                                        //     //       child: Text('$dropDownvalue' ,
                                        //     //         style: TextStyle(color: AppColors.primaryColor
                                        //     //             ,fontWeight: FontWeight.bold),)
                                        //     //       ,)
                                        //     //     ,
                                        //     //     DropdownMenuItem(value: 30,
                                        //     //       child: Text('30 minutes' ,
                                        //     //         style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold),) ,),
                                        //     //   ],
                                        //     //   onChanged: (int? value) {
                                        //     //     dropDownvalue = value!;
                                        //     //     intervalPeriod =value;
                                        //     //
                                        //     //     setState(() {
                                        //     //       // _firstIntervalDetails=IntervalDetails(intervalNumber:
                                        //     //       // workDaysList.indexOf(_currentDay)+1,intervalPeriod:value,
                                        //     //       //   intervalEnd:_firstIntervalDetails.intervalEnd
                                        //     //       //   ,intervalStart:  _firstIntervalDetails.intervalStart ,);
                                        //     //
                                        //     //       intervalDetailsList[index]=IntervalDetails(intervalNumber:
                                        //     //       index+1, intervalEnd:
                                        //     //       intervalDetailsList[index].intervalEnd,intervalStart:
                                        //     //       intervalDetailsList[index].intervalStart ,
                                        //     //           intervalPeriod:value );
                                        //     //
                                        //     //       // intervalDetailsList.insert( workDaysList.indexOf(_currentDay),(IntervalDetails(intervalNumber:
                                        //     //       // workDaysList.indexOf(_currentDay)+1, intervalPeriod:value )));
                                        //     //     });
                                        //     //   },
                                        //     //
                                        //     // ),
                                        //
                                        //   ],
                                        // ),
                                        IconButton(onPressed: (){
                                          showMyDialog(daysList[index].intervalList!, ind);
                                        }

                                            ,

                                            icon: Icon(Icons.delete  , color: Colors.yellow,)),


                                      ],
                                    ),
                                  ),
                                )
                        ),
                      )
                          :
                      Container(),
                    ],
                  ),
                ),
              ],
            ),
          )
          ),


        ),
      ),
    );
  }

  Future<TimeOfDay?> pickTime() => showTimePicker(context: context,
      initialTime:  TimeOfDay(hour: 8, minute: 0)
  );

  showMyDialog(List<IntervalDetails> list , int index){
    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (BuildContext context,
          void Function(void Function()) setState){
        return AlertDialog(
          title: Text('Do you want delete this period'),
          actions: [
            TextButton(onPressed: (){
              list.removeAt(index);
              this.setState(() {

              });
              Navigator.of(context).pop();
            }, child: Text('Yes')),
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('No')),
          ],
        );
      });
    });
  }
}
