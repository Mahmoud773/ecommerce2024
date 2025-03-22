
import 'package:amazon/Facility_Manager/paymob_manager/paymob_manager.dart';
import 'package:flutter/material.dart';

import '../paymob_webview_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(
        child: IconButton(icon: Icon(Icons.payment),
        onPressed: () async{
          PayMobManager().paywithPaymob(amount: 250).then(
              (paymentKey){
               Navigator.push(context,
               MaterialPageRoute(builder: (context){return PaymobWebviewScreen(paymentToken:paymentKey ,);

               })
               );
              }
          );
        },
        ),
      ),
    );
  }
}
