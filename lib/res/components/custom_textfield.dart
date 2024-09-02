
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController? textController;
  final Color textColor;
  final Color borderColor;

  const CustomTextField({Key? key  , required this.hint ,  this.textController ,
     this.textColor = Colors.black , this.borderColor =Colors.black} )
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      cursorColor: Colors.blue,
          controller: widget.textController,
      decoration: InputDecoration(
        isDense: true,
        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor
          )
        ) ,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor
            )
        ) ,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor
          )
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: widget.textColor
        )
      ),
    );
  }
}


class MyTextField extends StatefulWidget {
  final String hint;
  const MyTextField({Key? key, required this.hint}) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hint
      ),
    );
  }
}

