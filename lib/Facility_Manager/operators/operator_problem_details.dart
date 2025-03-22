

import 'package:amazon/Facility_Manager/customer_repository/customer_firestore_repository.dart';
import 'package:amazon/Facility_Manager/models/Problem_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../consts/colors.dart';
import '../../res/components/Custom_text_field_new.dart';

class OperatorProblemDetails extends StatefulWidget {
  ProblemModel problemModel;
  List<ProblemModel> problemsList;
   OperatorProblemDetails({super.key , required this.problemModel , required this.problemsList});

  @override
  State<OperatorProblemDetails> createState() => _OperatorProblemDetailsState();
}

class _OperatorProblemDetailsState extends State<OperatorProblemDetails> {
  final  user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String OrderDetails="";
  String orderequipment="";
  String workTeam="";

  TextEditingController orderDescriptionTextEditingController =TextEditingController();
  TextEditingController orderequipmentEditingController =TextEditingController();
  TextEditingController workTeamTextEditingController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    final uid = user!.uid;
    final width=MediaQuery.of(context).size.width;
    return  Scaffold(
        appBar: AppBar(title: Text("Order No ${widget.problemModel.number} "),),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("${widget.problemModel.problemType}"),
              SizedBox(height: 10,),
              MyCustomTextField(
                obsecureText: false,
                hint: "Enter work order details details",
                textEditingController: orderDescriptionTextEditingController,
                onSave: (String? value){
                  OrderDetails=orderDescriptionTextEditingController.text ;
                  OrderDetails =value!;
                  widget.problemModel.workOrderDetails=OrderDetails;
                },
                validator: (String? value){
                  if(value == null ||value.isEmpty || value.length <20){
                    return "problem details must be not less than 20 characters";
                  }else OrderDetails=orderDescriptionTextEditingController.text ;
                },
                icon: Icons.report_problem_outlined,

              ),
              SizedBox(height: 20,),
              MyCustomTextField(
                obsecureText: false,
                hint: "Enter Your name",
                textEditingController: orderequipmentEditingController,
                onSave: (String? value){
                  orderequipment=  orderequipmentEditingController.text ;
                  orderequipment =value!;
                  widget.problemModel.requiredEquipment=orderequipment;
                },
                validator: (String? value){
                  if(value == null ||value.isEmpty || value.length <20){
                    return "name must be not less than 3 characters";
                  }else orderequipment=orderequipmentEditingController.text ;
                },
                icon: Icons.person,

              ),
              SizedBox(height: 20,),
              MyCustomTextField(
                obsecureText: false,
                hint: "Enter unit Number",
                textEditingController: workTeamTextEditingController,
                onSave: (String? value){
                  workTeam =   workTeamTextEditingController.text;
                  workTeam =value!;
                  widget.problemModel.teamMembers=workTeam;
                },
                validator: (String? value){
                  if(value == null ||value.isEmpty || value.length <20){
                    return "problem details must be not less than 20 characters";
                  }else  workTeam =   workTeamTextEditingController.text;
                },
                icon: Icons.report_problem_outlined,

              ),

              SizedBox(height: 20,),
              // StreamBuilder(stream: stream, builder: (context,snapshot)
              // {
              //   return ;
              // }
              // ),

            ],
          ),
        ),
      ),
      bottomSheet:Padding(
        padding: const EdgeInsets.only(bottom: 5 ,right: 8,left: 8),
        child: Container(
          color: Color(0xFFD9E4EE),
          child: Material(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
              child:InkWell(
                onTap: () async {
                   if(_formKey.currentState!.validate()){
                     _formKey.currentState!.save();
                     widget.problemsList.removeWhere((item) => item.id==widget.problemModel.id);
                     //widget.problemModel.isCompleted=true;
                     widget.problemModel.isPending=true;
                     widget.problemModel.solvedById=uid;
                     widget.problemsList.add(widget.problemModel);
                     await CustomersFirestoreRpository.uploadAllProblems("", widget.problemsList, merge: false);
                     await CustomersFirestoreRpository.uploadProblems(widget.problemModel.problemBy,

                         widget.problemsList ,merge: false).then(
                             (value){
                           // showDialog(context: context, builder:
                           // (context) {
                           //   return Column(
                           //     children: [
                           //       Text("please let customer ensure solving"),
                           //
                           //     ],
                           //   );
                           // }
                           // );

                           AwesomeDialog(context: context
                               ,title: "Solved" ,
                               desc: "please let customer ensure solving" ,
                               dismissOnTouchOutside: true,
                               btnCancelOnPress: (){return ;},
                               btnOkOnPress: (){
                                 return ;
                               }
                           ).show();
                         }
                     );
                   }

                },
                child: Container(
                  height: 60,
                  width: width,
                  child: Center(child:
                  Text("Save Order" ,
                    style: TextStyle(
                      fontSize: 20 ,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),
                  ),),
                ),
              )

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     InkWell(
            //       onTap: (){
            //
            //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
            //             BookingCard2(doctorModel: widget.doctorModel,)
            //         ));
            //       },
            //       child: Container(
            //         height: 60,
            //         width: 100,
            //         child: Center(child:
            //         Text("add Appointment" ,
            //           style: TextStyle(
            //             fontSize: 20 ,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white,
            //
            //           ),
            //         ),),
            //       ),
            //     ),
            //     SizedBox(width: 10,),
            //     InkWell(
            //       onTap: () async{
            //         choosenDateTimesList.add(choosenDayTimeDay);
            //         print("choosenDateTimesList ${choosenDateTimesList[0].dayDate}");
            //         print("choosenDateTimesList ${choosenDateTimesList[0].intervalList}");
            //         print("${choosenDateTimesList.length}");
            //
            //         list8[selectedDayIndex].intervalList.removeAt(selectedTimeIndex);
            //
            //         print(list8);
            //         Appointment appointment=
            //         Appointment(doctorImage:widget.doctorModel.pictureUrl ,
            //             doctorName:widget.doctorModel.name ,
            //             appointWith: "${widget.doctorModel.id}",
            //             appointBy: "${currentUser!.uid}",
            //             appointsList: choosenDateTimesList);
            //         patientAppointsList.add(appointment);
            //         await DoctorsFirestoreRpository.
            //         uploadDoctorAppoints(widget.doctorModel.id ,list8 ,
            //             isUpdating:  false);
            //
            //         setState(() {
            //
            //         });
            //         await DoctorsFirestoreRpository.uploadReservedDoctorAppoints(widget.doctorModel.id,
            //             patientAppointsList);
            //         await PatientFireaseRepository.uploadPatientAppoints(
            //             currentUser!.uid, patientAppointsList ,isUpdating: false).
            //         then((value) {
            //           Navigator.of(context).pushReplacement(
            //               MaterialPageRoute(builder: (context) {
            //                 return AppointmentView(doctorId: widget.doctorModel.id,);
            //               })
            //           );
            //         });
            //
            //
            //
            //         print(list8);
            //       },
            //       child: Container(
            //         height: 60,
            //         width: 100,
            //         child: Center(child:
            //         Text("book Appointment" ,
            //           style: TextStyle(
            //             fontSize: 20 ,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white,
            //
            //           ),
            //         ),),
            //       ),
            //     )
            //   ],
            // )



            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     InkWell(
            //       onTap: (){
            //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
            //             BookingCard2(doctorModel: widget.doctorModel,)
            //         ));
            //       },
            //       child: Container(
            //         height: 60,
            //         width: 50,
            //         child: Center(child:
            //         Text("Book Appointment" ,
            //           style: TextStyle(
            //             fontSize: 20 ,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white,
            //
            //           ),
            //         ),),
            //       ),
            //     ),
            //     ,
            //   ],
            // ),
          ),
        ),
      ) ,
    );
  }
}
