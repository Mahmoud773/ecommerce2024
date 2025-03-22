
import 'package:amazon/Facility_Manager/models/Problem_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:paymob_payment/paymob_payment.dart';

import '../customer_repository/customer_firestore_repository.dart';
import '../my_problems222222.dart';


class PaymentView extends StatefulWidget {
  final customerId;
  final List<ProblemModel> currentCustomerProblemList;
  final List<ProblemModel> problemsList;
  final ProblemModel problemModel;
  final String price;
  const PaymentView({super.key, required this.price, required this.problemModel,
    required this.problemsList, required this.currentCustomerProblemList, required this.customerId});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  PaymobResponse? response;

  uploadsuccessPaid() async{
     {
       widget.problemModel.isAgreeToSolvingDate=true;
       widget.problemModel.waitingForCustomerToAgreeForSolvingDate=false;
       widget.problemModel.isCustomerRespondedtoSolvingDate=true;

       //widget.problemsList.removeWhere((item)=>item.id==widget.problemModel.id);
      widget.problemModel.isPaid=true;
      widget.problemModel.isPending=true;
      widget.problemModel.waitTechnicianToSolveAfterPending="yes";
       final currentIndex=widget.problemsList.indexWhere((item)=>item.id==widget.problemModel.id);
       widget.problemsList[currentIndex]=widget.problemModel;
    //  widget.problemsList.add(widget.problemModel);
      await CustomersFirestoreRpository.uploadProblems(widget.customerId,

          widget.currentCustomerProblemList ,merge: false);
      await CustomersFirestoreRpository.uploadAllProblems("", widget.problemsList, merge: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(response!=null){
      if(response!.success)
      { uploadsuccessPaid();}

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paymob'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/FMimages/paymobLogo.png'),
              const SizedBox(height: 24),
              if (response != null)
               response!.success ?

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Successfully paid", style: TextStyle(fontSize: 25),),
                    const SizedBox(height: 8),
                    Text("Transaction ID ==> ${response?.transactionID}",style: TextStyle(fontSize: 25),),
                    const SizedBox(height: 8),
                    // Text("Message ==> ${response?.message}"),
                    // const SizedBox(height: 8),
                    // Text("Response Code ==> ${response?.responseCode}"),
                    const SizedBox(height: 16),
                  ],
                )
                :
               Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                   Text("failed"),
                   const SizedBox(height: 8),
                  // Text("Transaction ID ==> ${response?.transactionID}"),
                   const SizedBox(height: 8),
                   Text("Message ==> ${response?.message}"),
                   const SizedBox(height: 8),
                   // Text("Response Code ==> ${response?.responseCode}"),
                   // const SizedBox(height: 16),
                 ],
               )

              ,
              if (response != null)
                response!.success ?
                ElevatedButton(
                  child:  Text('Go to Orders Page'),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
                    (c){return MyProblemsScreen2222222222222(doctorId:widget.customerId,);}
                    ));
                  },
                )
                    :
              ElevatedButton(
                child:  Text('Pay for ${widget.price} EGP'),
                onPressed: () {
                  PaymobPayment.instance.pay(
                    context: context,
                    currency: "EGP",
                    amountInCents: "${(int.parse(widget.price))*100}",
                    onPayment: (response) => setState(() => this.response = response),
                  );
                },
              ),
              if (response == null)
                ElevatedButton(
                  child:  Text('Pay for ${widget.price} EGP'),
                  onPressed: () {
                    PaymobPayment.instance.pay(
                      context: context,
                      currency: "EGP",
                      amountInCents: "${(int.parse(widget.price))*100}",
                      onPayment: (response) => setState(() => this.response = response),
                    );
                  },
                )


            ],
          ),
        ),
      ),
    );
  }
}