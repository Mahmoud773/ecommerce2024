//
//
// import 'package:amazon/models/booking_date_time_converter.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import '../../consts/colors.dart';
// import '../../res/components/custom_book_card.dart';
//
// class BookingScreen extends StatefulWidget {
//   const BookingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<BookingScreen> createState() => _BookingScreenState();
// }
//
// class _BookingScreenState extends State<BookingScreen> {
//   int nuOfIntervals=0;
//   List  workDaysList=[];
//   List intervals=[];
//   List<IntervalDetails> intervalDetailsList=[];
//   IntervalDetails _firstIntervalDetails=IntervalDetails();
//   CalendarFormat _format = CalendarFormat.month;
//   DateTime _lastDay=DateTime(DateTime.now().day+30) ;
//   final now=DateTime.now();
//   DateTime _focusDay = DateTime.now();
//   DateTime _currentDay = DateTime.now();
//   int? _currentIndex;
//   bool _isWeekend = false;
//   bool _dateSelected = false;
//   bool _timeSelected = false;
//   String? token;
//   int Hours= 00;
//   int minutes= 00;
//   int Hours1= 00;
//   int minutes1= 00;
//   int Hours2= 00;
//   int minutes2= 00;
//   int dropDownvalue=15;
//   int intervalPeriod=0;
//
//   Map<String ,dynamic> timesMap={};
//
//   TextEditingController firstDayController = TextEditingController();
//   DateTime? firstDay;
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(),
//        body: SingleChildScrollView(
//          child: BookingCard(),
//          // Column(
//          //   children: [
//          //     // Padding(padding: EdgeInsets.all(8) ,
//          //     // child: _tableCalendar(),) ,
//          //     Row(
//          //       children: [
//          //         Container(
//          //           width: 200,
//          //           child: TextFormField(
//          //             controller: firstDayController,
//          //             decoration: InputDecoration(
//          //               border: OutlineInputBorder(
//          //                 borderRadius: BorderRadius.circular(10),
//          //               ),
//          //                hintText: "choose date"
//          //             ),
//          //             onTap: () async{
//          //               var date = await  showDatePicker(
//          //                 context: context,
//          //                 initialDate: DateTime.now(),
//          //                 firstDate:DateTime.now() ,
//          //                 lastDate: DateTime(now.year, now.month , now.day+7),
//          //               );
//          //
//          //               if(date !=null) {
//          //                 String formattedDate =DateFormat("yyyy-MM-dd").format(date);
//          //                 firstDayController.text =formattedDate;
//          //                 firstDay=date;
//          //                 workDaysList.add(firstDay);
//          //               }
//          //             }
//          //             ,
//          //           ),
//          //         ),
//          //        // MaterialButton(
//          //        //   onPressed: () {
//          //        //    showDatePicker(
//          //        //       context: context,
//          //        //       initialDate: DateTime.now(),
//          //        //       firstDate:DateTime.now() ,
//          //        //       lastDate: DateTime(now.year, now.month , now.day+7),
//          //        //   );
//          //        // }  ,
//          //        //  child: Text('choose Date'),
//          //        // ) ,
//          //        //  Text('choosen Date'),
//          //     ],),
//          //     Row(
//          //       children: [
//          //         MaterialButton(onPressed:
//          //             (){
//          //
//          //           setState(() {
//          //             nuOfIntervals+= 1;
//          //             intervalDetailsList.add(IntervalDetails());
//          //           });
//          //
//          //         }
//          //         , child:  Text("Add Interval" , style: TextStyle(
//          //                 fontSize: 20 , fontWeight: FontWeight.bold , color: AppColors.primaryColor
//          //             ),)
//          //           ,),
//          //         Text("First Interval" , style: TextStyle(
//          //           fontSize: 20 , fontWeight: FontWeight.bold , color: AppColors.primaryColor
//          //         ),
//          //         ),
//          //       ],
//          //     ),
//          //       nuOfIntervals>0 ?
//          //           Column(
//          //             children: List.generate(intervalDetailsList.length,
//          //                     (index) =>
//          //                         Row(
//          //                       children: [
//          //                         Column(
//          //                           children: [
//          //                             Text("start time" , style: TextStyle(
//          //                                 fontSize: 20 , fontWeight: FontWeight.bold , color: AppColors.primaryColor
//          //                             ),),
//          //                             SizedBox(height: 5,),
//          //                             ElevatedButton(onPressed: () async {
//          //                               final time  =await pickTime();
//          //                               if(time == null) return;
//          //                               setState(() {
//          //                                 Hours= time.hour;
//          //                                 minutes=time.minute;
//          //                                 // _firstIntervalDetails=IntervalDetails(intervalNumber:
//          //                                 // workDaysList.indexOf(_currentDay)+1, intervalStart:
//          //                                 // time, );
//          //                                 // intervalDetailsList.first= IntervalDetails(intervalNumber:
//          //                                 // workDaysList.indexOf(_currentDay)+1, intervalStart:
//          //                                 // time, );
//          //                                 intervalDetailsList[index]=IntervalDetails(intervalNumber:
//          //                                 index+1, intervalStart:
//          //                                 time,intervalPeriod: 15 );
//          //                               });
//          //
//          //                             },
//          //                               child: Text(intervalDetailsList[index].intervalStart== null ?"00:00"
//          //                                   :" ${intervalDetailsList[index].intervalStart!.hour} :"
//          //                               " ${intervalDetailsList[index].intervalStart!.minute} ") ,
//          //
//          //                             ) ,
//          //                           ],
//          //                         ) ,
//          //                         Column(
//          //                           children: [
//          //                             Text("End time" , style: TextStyle(
//          //                                 fontSize: 20 , fontWeight: FontWeight.bold , color: AppColors.primaryColor
//          //                             ),),
//          //                             SizedBox(height: 5,),
//          //                             ElevatedButton(onPressed: () async {
//          //                               final time  =await pickTime();
//          //                               if(time == null) return;
//          //                               setState(() {
//          //                                 Hours1= time.hour;
//          //                                 minutes1=time.minute;
//          //                                 // _firstIntervalDetails=IntervalDetails(intervalNumber:
//          //                                 // nuOfIntervals, intervalEnd:
//          //                                 // time,intervalStart:  _firstIntervalDetails.intervalStart ,
//          //                                 //     intervalPeriod:_firstIntervalDetails.intervalPeriod );
//          //                                 intervalDetailsList[index]=IntervalDetails(intervalNumber:
//          //                                 index+1, intervalEnd:
//          //                                 time,intervalStart:  intervalDetailsList[index].intervalStart ,
//          //                                     intervalPeriod:intervalDetailsList[index].intervalPeriod );
//          //                               });
//          //
//          //                             }, child: Text(intervalDetailsList[index].intervalEnd== null ?"00:00"
//          //                                 :
//          //                                 "${intervalDetailsList[index].intervalEnd!.hour} :"
//          //                                 " ${intervalDetailsList[index].intervalEnd!.minute} ") ,
//          //
//          //                             ) ,
//          //                           ],
//          //                         ),
//          //                         Column(
//          //                           children: [
//          //                             Text("Consultant period" , style: TextStyle(
//          //                                 fontSize: 20 , fontWeight: FontWeight.bold , color: AppColors.primaryColor
//          //                             ),),
//          //                             SizedBox(height: 5,),
//          //                             DropdownButton<int>(
//          //                               style: TextStyle(
//          //                                   fontSize: 15 , fontWeight: FontWeight.bold , color: AppColors.primaryColor
//          //                               ),
//          //                               padding: EdgeInsets.all(5),
//          //                               hint: Text('نوع الفاتورة', style: TextStyle(color: Colors.black
//          //                                   ,fontWeight: FontWeight.bold
//          //                               ),),
//          //                               icon: Icon(Icons.arrow_drop_down_outlined),
//          //                               value: dropDownvalue,
//          //                               items: [
//          //                                 DropdownMenuItem(value: 15,
//          //                                   child: Text('15 minutes' ,
//          //                                     style: TextStyle(color: AppColors.primaryColor
//          //                                         ,fontWeight: FontWeight.bold),)
//          //                                   ,)
//          //                                 ,
//          //                                 DropdownMenuItem(value: 30,
//          //                                   child: Text('30 minutes' ,
//          //                                     style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold),) ,),
//          //                               ],
//          //                               onChanged: (int? value) {
//          //                                 dropDownvalue = value!;
//          //                                 intervalPeriod =value;
//          //
//          //                                 setState(() {
//          //                                   // _firstIntervalDetails=IntervalDetails(intervalNumber:
//          //                                   // workDaysList.indexOf(_currentDay)+1,intervalPeriod:value,
//          //                                   //   intervalEnd:_firstIntervalDetails.intervalEnd
//          //                                   //   ,intervalStart:  _firstIntervalDetails.intervalStart ,);
//          //
//          //                                   intervalDetailsList[index]=IntervalDetails(intervalNumber:
//          //                                   index+1, intervalEnd:
//          //                                   intervalDetailsList[index].intervalEnd,intervalStart:
//          //                                   intervalDetailsList[index].intervalStart ,
//          //                                       intervalPeriod:value );
//          //
//          //                                   // intervalDetailsList.insert( workDaysList.indexOf(_currentDay),(IntervalDetails(intervalNumber:
//          //                                   // workDaysList.indexOf(_currentDay)+1, intervalPeriod:value )));
//          //                                 });
//          //                               },
//          //
//          //                             ),
//          //                           ],
//          //                         ),
//          //
//          //                       ],
//          //                     )
//          //             ),
//          //           ) :
//          //           Container()
//          //     ,
//          //     Material(
//          //       color: AppColors.primaryColor,
//          //       borderRadius: BorderRadius.circular(10),
//          //       child: InkWell(
//          //         onTap: (){
//          //           timesMap["$firstDay"]=intervalDetailsList;
//          //          print("${intervalDetailsList.length} ${intervalDetailsList} "
//          //              "${intervalDetailsList[0].intervalEnd} "
//          //              "${intervalDetailsList[0].intervalNumber} "
//          //              "${intervalDetailsList[0].intervalStart}"
//          //              " ${intervalDetailsList[0].intervalPeriod}");
//          //
//          //           print("${intervalDetailsList.length} ${intervalDetailsList} "
//          //               "${intervalDetailsList[1].intervalEnd} "
//          //               "${intervalDetailsList[1].intervalNumber} "
//          //               "${intervalDetailsList[1].intervalStart}"
//          //               " ${intervalDetailsList[1].intervalPeriod}");
//          //          print("${timesMap.entries.toList()}");
//          //         },
//          //         child: Container(
//          //           height: 60,
//          //           width: width,
//          //           child: Center(child:
//          //           Text("Book Appointment" ,
//          //             style: TextStyle(
//          //               fontSize: 20 ,
//          //               fontWeight: FontWeight.bold,
//          //               color: Colors.white,
//          //
//          //             ),
//          //           ),),
//          //         ),
//          //       ),
//          //     )
//          //   ],
//          // ),
//        ),
//     );
//   }
//
//   Widget _tableCalendar() {
//     return TableCalendar(
//       focusedDay: _focusDay,
//       firstDay: DateTime.now(),
//       lastDay: DateTime(now.year, now.month , now.day+7),
//       calendarFormat: _format,
//       currentDay: _currentDay,
//       rowHeight: 48,
//       calendarStyle:  CalendarStyle(
//         todayDecoration:
//         BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
//       ),
//       availableCalendarFormats: const {
//         CalendarFormat.month: 'Month',
//       },
//       onFormatChanged: (format) {
//         setState(() {
//           _format = format;
//         });
//       },
//       onDaySelected: ((selectedDay, focusedDay) {
//         setState(() {
//           _currentDay = selectedDay;
//           _focusDay = focusedDay;
//           _dateSelected = true;
//           workDaysList.add(_currentDay);
//           // intervalDetailsList.add(IntervalDetails());
//
//           //check if weekend is selected
//           // if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
//           //   _isWeekend = true;
//           //   _timeSelected = false;
//           //   _currentIndex = 0;
//           // } else {
//           //   _isWeekend = false;
//           // }
//         });
//       }),
//
//     );
//   }
//   // Future<DateTime?> datePicker(){
//   //   return sh
//   // }
//
//   Future<TimeOfDay?> pickTime() => showTimePicker(context: context,
//       initialTime:  TimeOfDay(hour: 8, minute: 0)
//   );
// }
