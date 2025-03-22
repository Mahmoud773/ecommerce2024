import 'package:amazon/Facility_Manager/facility_home_screen.dart';
import 'package:amazon/views/patient_appintment_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../models/booking_date_time_converter.dart';
import '../../res/components/custom_button.dart';
import 'Home_with_bottomBar_Screenr.dart';
import 'My_Problems_screen.dart';
import 'my_problems222222.dart';

class ProblemAddSuccessBooked extends StatefulWidget {
  final String doctorId;
   String problemNumber;
  final List<DayTimeDetails> list8;
  ProblemAddSuccessBooked({Key? key, required  this.doctorId , required this.list8,
    required this.problemNumber}) : super(key: key);

  @override
  State<ProblemAddSuccessBooked> createState() => _ProblemAddSuccessBookedState();
}

class _ProblemAddSuccessBookedState extends State<ProblemAddSuccessBooked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset('assets/success.json', ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Successfully Booked',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'problem number to follow by it \n ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child:  Text(
                '${widget.problemNumber}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            //back to home page
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Button(
                width: double.infinity,
                title: 'Go to orders page',
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyProblemsScreen2222222222222(doctorId: widget.doctorId,))
                ),
                disable: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}