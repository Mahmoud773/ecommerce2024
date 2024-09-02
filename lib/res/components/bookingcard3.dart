

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../consts/colors.dart';
import '../../doctors/firestore_Repository/firetore_repository.dart';
import '../../doctors/models/doctor_model.dart';
import '../../models/booking_date_time_converter.dart';
import 'Custom_text_field_new.dart';

class BookingCard3 extends StatefulWidget {
  final DoctorModel doctorModel;
  const BookingCard3({Key? key , required this.doctorModel}) : super(key: key);

  @override
  State<BookingCard3> createState() => _BookingCard3State();
}

class _BookingCard3State extends State<BookingCard3> {
  final now=DateTime.now();
  List  textContollersList=[];
  List<DayDetails> daysDetails=[];
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
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
                child: Icon(Icons.add ,
                  color:AppColors.primaryColor,
                  size: 28,),

              ),



            ),
            onTap: () async{
              await showDialog(context: context, builder: (context) {
                TextEditingController textController =TextEditingController();
                List<IntervalDetails> dayIntervalDetails1 =[];
                DateTime dayDate=DateTime.now();

                return StatefulBuilder(builder:
                    (BuildContext context,
                    setState) {
                  int addTime=0;

                  return Container(
                    width: width,
                    height: height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AlertDialog(
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(

                                  child: MyCustomTextField(

                                    validator: (value) {} ,
                                    hint: "choose Date",
                                    icon: Icons.date_range_outlined,
                                    onSave: (value) {},
                                    obsecureText: false,
                                    onTap: () async{
                                      var date = await  showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate:DateTime.now() ,
                                        lastDate: DateTime(now.year, now.month , now.day+7),
                                      );
                                      if(date != null) {
                                        dayDate=date;
                                        String formattedDate =DateFormat("yyyy-MM-dd").format(date);
                                        textController.text =formattedDate;
                                        textContollersList.add(TextEditingController(text:formattedDate ));

                                      }
                                    },
                                    textEditingController:textController,
                                  ),
                                  width: width,
                                ) ,
                                dayIntervalDetails1.length>0 ?
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(dayIntervalDetails1.length, (index) {
                                    return customDayIntervalsCard(dayIntervalDetails1[index] ,
                                        ValueKey('${dayIntervalDetails1}')
                                    );
                                  }),
                                )
                                    :
                                Container(),
                                TextButton(
                                    onPressed: ()  async{
                                      await showDialog(context: context, builder:
                                          (context) {
                                        TextEditingController startController =TextEditingController();
                                        TextEditingController endController =TextEditingController();
                                        TextEditingController periodController =TextEditingController();

                                        IntervalDetails _intervalDetails= IntervalDetails();
                                        return AlertDialog(
                                          content:SingleChildScrollView(
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        hintText: "start Time",
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        )
                                                    ),
                                                    onTap:() async{
                                                      var time= await  pickTime();
                                                      if(time !=null) {
                                                        startController.text =time.toString();
                                                        _intervalDetails=IntervalDetails(
                                                            intervalNumber:(dayIntervalDetails1.isNotEmpty && dayIntervalDetails1.length>0)
                                                                ?dayIntervalDetails1.length : 0,
                                                            intervalStart:time.toString(),
                                                            intervalEnd: time.toString() ,
                                                            intervalPeriod: 0
                                                        );

                                                      }
                                                    },
                                                    controller: startController,
                                                  ),
                                                  width: width,
                                                ),
                                                Container(
                                                  child: TextFormField(

                                                    decoration: InputDecoration(
                                                        hintText: "End Time",
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        )
                                                    ),
                                                    onTap:() async{
                                                      var time= await  pickTime();
                                                      if(time !=null) {
                                                        endController.text =time.toString();
                                                        _intervalDetails=IntervalDetails(
                                                            intervalNumber:(dayIntervalDetails1.isNotEmpty && dayIntervalDetails1.length>0)
                                                                ?dayIntervalDetails1.length : 0,
                                                            intervalStart:_intervalDetails.intervalStart,
                                                            intervalEnd: time.toString() ,
                                                            intervalPeriod: 0
                                                        );
                                                      }
                                                    },
                                                    controller: endController,
                                                  ),
                                                  width: width,
                                                ),
                                                Container(
                                                  width: width,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        hintText: "consult Period",
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        )
                                                    ),

                                                    onChanged: (value) {
                                                      if(value !=null ){
                                                        _intervalDetails=IntervalDetails(
                                                            intervalNumber: (dayIntervalDetails1.isNotEmpty && dayIntervalDetails1.length>0)
                                                                ?dayIntervalDetails1.length : 0,
                                                            intervalStart:
                                                            _intervalDetails.intervalStart ,
                                                            intervalEnd: _intervalDetails.intervalEnd ,
                                                            intervalPeriod:int.parse(value)

                                                        );

                                                      }
                                                    },
                                                    controller: periodController,
                                                    keyboardType: TextInputType.number,
                                                  ),
                                                ),

                                              ],
                                            ),

                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed:() {


                                                }, child:
                                            Text('Cancel' ,
                                              style: TextStyle(fontSize: 20),)),
                                            TextButton(
                                                onPressed:() {
                                                  // dayIntervalDetails1.add(_intervalDetails);
                                                  setState( () =>
                                                      dayIntervalDetails1.add(_intervalDetails)
                                                  );
                                                  print("${dayIntervalDetails1.length}");
                                                  Navigator.of(context).pop();
                                                }, child:
                                            Text('Save' ,
                                              style: TextStyle(fontSize: 20),)),
                                          ],
                                        );
                                      }
                                      );
                                      addTime+1 ;
                                      setState;
                                    },
                                    child: Text("add TIMES")),
                              ],
                            ),
                            actions: [
                              TextButton(onPressed: (){
                                daysDetails.add(DayDetails(dayNumber: 0 ,dayDate:dayDate ,
                                    intervalList: dayIntervalDetails1 ,
                                    dayName: dayDate.day.toString() ));
                                this.setState(() {

                                });
                                Navigator.of(context).pop();
                              },
                                  child: Text("save")),
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                              },
                                  child: Text("cancel"))
                            ],
                          ),

                        ],
                      ),
                    ),
                  );

                }
                );
              });
            },
          ),
        ],
      ),

      body: daysDetails.length>0 ?
      ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount:daysDetails.length ,
          itemBuilder: (context,index)=> appointsDayCard(daysDetails[index]))
          :
      Container(),
      bottomSheet: TextButton(onPressed: () async{
        try {
          await DoctorsFirestoreRpository.uploadAppoints(widget.doctorModel.id ,daysDetails);
          // print("${daysList}");
          Navigator.pop(context);
        }
        catch(e){
          log(e.toString());
          rethrow;
        }
      }, child: Text("Save")),
    );
  }
  Future<TimeOfDay?> pickTime() => showTimePicker(context: context,
      initialTime:  TimeOfDay(hour: 8, minute: 0)
  );

  Widget customDayIntervalsCard(IntervalDetails intervalDetails , ValueKey key){
    return  Container(
      width: 200,
      // padding: EdgeInsets.all(20),
      // margin:EdgeInsets.all(5),
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
        key:key,
        child: SingleChildScrollView(
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
                      onPressed: () {},
                      color: AppColors.primaryColor,

                      child:
                      // Text('${timesMap["$firstDay"]![index].intervalStart}') ,

                      Text("${intervalDetails.intervalStart}"
                        ,style: TextStyle(color:  Colors.white),) ,

                    ),
                  ) ,
                ],
              ) ,
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("end" , style: TextStyle(
                      fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.white
                  ),),
                  SizedBox(height: 5,),
                  Align(alignment: Alignment.centerLeft,
                    child: MaterialButton(
                      onPressed: () {},
                      color: AppColors.primaryColor,

                      child:
                      // Text('${timesMap["$firstDay"]![index].intervalStart}') ,

                      Text("${intervalDetails.intervalEnd}"
                        ,style: TextStyle(color:  Colors.white),) ,

                    ),
                  ) ,
                ],
              ) ,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("period" , style: TextStyle(
                      fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.white
                  ),),
                  SizedBox(height: 5,),
                  Align(alignment: Alignment.centerLeft,
                    child: MaterialButton(
                      onPressed: () {},
                      color: AppColors.primaryColor,

                      child:
                      // Text('${timesMap["$firstDay"]![index].intervalStart}') ,

                      Text("${intervalDetails.intervalPeriod}"
                        ,style: TextStyle(color:  Colors.white),) ,

                    ),
                  ) ,
                ],
              ) ,
            ],
          ),
        ),
      ),
    ) ;
  }

  Widget appointsDayCard(DayDetails dayDetails){
    return  Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${dayDetails.dayDate.toString()}"),
            SizedBox(height: 10,),
            Container(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return  Row(
                      key: ValueKey("${dayDetails.intervalList![index]}") ,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("From") ,
                            SizedBox(height: 5,),
                            Text("${dayDetails.intervalList![index].intervalStart}"),
                          ],
                        ),
                        SizedBox(width: 5,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("To") ,
                            SizedBox(height: 5,),
                            Text("${dayDetails.intervalList![index].intervalEnd}"),
                          ],
                        ),
                        SizedBox(width: 5,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("period") ,
                            SizedBox(height: 5,),
                            Text("${dayDetails.intervalList![index].intervalPeriod}"),
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
                                icon: Icon(Icons.delete)),
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
}
