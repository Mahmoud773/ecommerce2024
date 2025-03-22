
import 'package:amazon/res/components/Custom_text_field_new.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Problem_model.dart';

class MaintenanceCard extends StatefulWidget {
  String pendingOrSolved;
  Function() onPress;
  final ProblemModel problemModel;
  bool isOperator;
   MaintenanceCard({super.key , required this.pendingOrSolved , required this.problemModel ,
     required this.onPress , required this.isOperator });

  @override
  State<MaintenanceCard> createState() => _MaintenanceCardState();
}

class _MaintenanceCardState extends State<MaintenanceCard> {
  final now=DateTime.now();
  String solveDate='';
  String technicianName='';
  String orderPrice='';
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    final height =MediaQuery.of(context).size.height;
    TextEditingController solveDateController=TextEditingController();
    TextEditingController TechnecianNameController=TextEditingController();
    TextEditingController priceController=TextEditingController();
    return  Form(
      child: Container(
        width:width ,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.9)
          // image: DecorationImage(
          //     image: AssetImage('assets/images/one.jpg'),
          //     fit: BoxFit.cover
          // )
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(child: MyCustomTextField(onSave: (value){
                  solveDate=value!;
                }, icon: Icons.date_range_outlined,
                  hint: "Solve Date",
                    validator: (value) {
                      if(value == null ||value.isEmpty || value.length <3){
                        return "please choose date";
                      }
                    },
                textEditingController: solveDateController,
                onTap:  () async{
                  var date = await  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:DateTime.now() ,
                    lastDate: DateTime(now.year, now.month , now.day+7),
                  );
                  if(date != null) {

                    String formattedDate =DateFormat("yyyy-MM-dd").format(date);
                    solveDate=formattedDate;

                    solveDateController.text=formattedDate;

                  }
                } ,)),
                Container(child: MyCustomTextField(onSave: (value){
                  TechnecianNameController.text=value!;
                  technicianName=value!;
                }, icon: Icons.person, hint:
                "Technician Name",
                    validator: (value){
                      if(value == null ||value.isEmpty || value.length <3){
                        return "Technician name";
                      }
                    } ,
                textEditingController: TechnecianNameController,)),
                Container(child: MyCustomTextField(onSave: (value){
                 priceController.text=value!;
                 orderPrice=value!;
                }, icon: Icons.price_check,
                  hint: "price",
                    validator: (value){},
                  textEditingController: priceController,
                )),
              ],
            ),
            CircleAvatar(backgroundImage:  AssetImage(getImagePath(widget.problemModel)),
              radius: 30,
            ),
            Column(
              children: [
                // Row(
                //   children: [
                //     Container(child: MyCustomTextField(onSave: , icon: icon, hint: hint, validator: validator)),
                //     SizedBox(height: 5,),
                //     Container(child: MyCustomTextField(onSave: onSave, icon: icon, hint: hint, validator: validator)),
                //     Container(child: MyCustomTextField(onSave: onSave, icon: icon, hint: hint, validator: validator)),
                //   ],
                // ),
                SizedBox(height: 10,),
                Text("order No: ${widget.problemModel.number}", style: TextStyle(
                    color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 5,),
                Text("Order date: ${widget.problemModel.problemDate}",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: 5,),
                Text("Mall name: ${widget.problemModel.mallName}",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: 5,),
                Text("Unit No: ${widget.problemModel.unitNumber}",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold
                  ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String getImagePath(ProblemModel p){
  if(p.problemType=="تكييف AC"){
    return "assets/FMimages/aircondition.jpg";
  }
  if(p.problemType=="مدنى Civil"){
    return 'assets/FMimages/civil.jpg';
  }
  if(p.problemType=="كهرباء Electricity"){
    return 'assets/FMimages/electricity1.jpg';
  }
  if(p.problemType=="تكنولوجيا المعلومات It"){
    return'assets/FMimages/it.jpg' ;
  }
  if(p.problemType=="L.C"){
    return 'assets/FMimages/lc1.jpg';
  }
  if(p.problemType=="سباكة Plumbing"){
    return  'assets/FMimages/plumbing.jpg';
  }
  else return 'assets/FMimages/HK.JPG' ;
}
