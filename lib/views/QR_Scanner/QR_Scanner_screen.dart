
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:typed_data';

import '../new_home_screen.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: MobileScanner(
        controller: MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates  ,
        returnImage: true),
        onDetect: (capture){
    final List<Barcode> barcodes=capture.barcodes;
    final Uint8List? image=capture.image;
    for(final barcode in barcodes){
      print("Qr code ${barcode.url}");
      print("Qr code ${barcode.displayValue}");
      print("Qr code ${barcode.rawValue}");
    }
    if(image !=null){
       print("image ${image.toString()}");
      Navigator.pushReplacement(context, MaterialPageRoute(builder:
      (context){
        return NewHomeScreen();
      }
      ));
    }
      },),
    );
  }
}
