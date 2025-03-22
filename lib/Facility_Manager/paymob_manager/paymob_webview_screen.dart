
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymobWebviewScreen extends StatefulWidget {
  final String paymentToken;
  const PaymobWebviewScreen({super.key , required this.paymentToken});

  @override
  State<PaymobWebviewScreen> createState() => _PaymobWebviewScreenState();
}

class _PaymobWebviewScreenState extends State<PaymobWebviewScreen> {

  InAppWebViewController? inAppWebViewController;
  void startPayment(){
    inAppWebViewController!.loadUrl(urlRequest:
    URLRequest(url: WebUri("https://accept.paymob.com/api/acceptance/iframes/832300?payment_token"
        "=${widget.paymentToken}"
        )
    )
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: false,
          )
        ),
        onWebViewCreated: (controller){
          inAppWebViewController=controller;

        },
        onLoadStop:(controller , url){
      if(url !=null && url.queryParameters.containsKey("success") && url.queryParameters["success"]=="true"){
          print("payment success");
      }else if(url !=null && url.queryParameters.containsKey("success") && url.queryParameters["success"]=="false"){
        print("payment failed");
      }
        } ,
      ),
    );
  }
}
