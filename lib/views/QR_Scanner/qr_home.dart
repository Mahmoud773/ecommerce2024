

import 'package:flutter/material.dart';

import 'QR_Scanner_screen.dart';

class QrHome extends StatefulWidget {
  const QrHome({super.key});

  @override
  State<QrHome> createState() => _QrHomeState();
}

class _QrHomeState extends State<QrHome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(child: InkWell(
        child: Text(
          "scan for app"
        ,style: TextStyle(fontSize: 25 , color: Colors.deepPurple),
        ),
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder:
              (context){
            return QrScannerScreen();
          }
          ));
        },
      ),),
    );
  }
}
