

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../consts/colors.dart';
import '../../doctors/firestore_Repository/firetore_repository.dart';
import '../../doctors/models/doctor_model.dart';
import '../../models/booking_date_time_converter.dart';
import 'Custom_text_field_new.dart';

class BookingCard2 extends StatefulWidget {
  final DoctorModel doctorModel;
  const BookingCard2({Key? key , required this.doctorModel}) : super(key: key);

  @override
  State<BookingCard2> createState() => _BookingCard2State();
}

class _BookingCard2State extends State<BookingCard2> {
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
                                                  padding: EdgeInsets.all(8),
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
                                                  padding: EdgeInsets.all(8),
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
                                                  padding: EdgeInsets.all(8),
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
              itemBuilder: (context,index)=> Stack(
                alignment: Alignment.topRight,
                children: [
                appointsDayCard(daysDetails[index]),
                  IconButton(onPressed: (){
                    daysDetails.removeAt(index);
                    setState(() {

                    });
                  },
                      icon: Icon(Icons.delete , color: Colors.amber,))
              ],
                  ))
          :
      Container(),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width,
          color: Color(0xFFD9E4EE),
          child: Material(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(onTap: () async{
              try {
                await DoctorsFirestoreRpository.uploadAppoints(widget.doctorModel.id ,daysDetails);
                await DoctorsFirestoreRpository.
                uploadDoctorAppoints(widget.doctorModel.id ,calculateDayTimes(daysDetails)
                    ,isUpdating:true );
                // print("${daysList}");
               Navigator.pop(context);
              }
              catch(e){
                log(e.toString());
                rethrow;
              }
            }, child: Container(
              height: 60,
              // width: width,
              child: Center(child:
              Text("Save" ,
                style: TextStyle(
                  fontSize: 20 ,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,

                ),
              ),),
            )
            ),
          ),
        ),
      ),
    );
  }
  Future<TimeOfDay?> pickTime() => showTimePicker(context: context,
      initialTime:  TimeOfDay(hour: 8, minute: 0)
  );

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

}
