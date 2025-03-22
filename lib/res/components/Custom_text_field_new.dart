

import 'package:amazon/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class MyCustomTextField extends StatelessWidget {
  int linesNumber;
  TextInputType textInputType;
  final String hint;
  final IconData icon;
  Color iconColor;
   Function()? onTap;
   TextEditingController? textEditingController ;
  final Function(String?)? onSave;
  final String? Function(String?)? validator;
  bool obsecureText;
  String? _errorMessage(String str) {
    switch (hint) {
      case 'Enter your name':
        return 'Name is empty !';
      case 'Enter your email':
        return 'un valid Email !';
      case 'Enter your password':
        return 'password must not be more than 6 characters or numbers !';
    }
  }

  MyCustomTextField(
      { this.textInputType=TextInputType.text,required this.onSave, required this.icon, required this.hint, required this.validator ,
      this.obsecureText=false , this.onTap , this.textEditingController , this.iconColor=Colors.white
      ,this.linesNumber=1} );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        keyboardType: textInputType,
        controller: textEditingController,
        validator: validator,
        onTap:onTap ,
        maxLines: 1,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return _errorMessage(hint);
        //     // ignore: missing_return
        //   }
        // },
        onSaved: onSave,
        obscureText: obsecureText,
        cursorColor: Colors.deepPurpleAccent,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          filled: true,
          fillColor: Colors.grey[400],
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}