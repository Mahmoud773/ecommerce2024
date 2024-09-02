import 'package:amazon/views/patient_appintment_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../models/booking_date_time_converter.dart';
import '../../res/components/custom_button.dart';

class AppointmentSuccessBooked extends StatefulWidget {
  final String doctorId;
  final List<DayTimeDetails> list8;
   AppointmentSuccessBooked({Key? key, required  this.doctorId , required this.list8}) : super(key: key);

  @override
  State<AppointmentSuccessBooked> createState() => _AppointmentSuccessBookedState();
}

class _AppointmentSuccessBookedState extends State<AppointmentSuccessBooked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset('assets/success.json'),
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
            const Spacer(),
            //back to home page
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Button(
                width: double.infinity,
                title: 'Go to Your Appointments',
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AppointmentView(doctorId: widget.doctorId,))
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