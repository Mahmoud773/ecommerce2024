
import 'package:amazon/consts/colors.dart';
import 'package:flutter/material.dart';

import '../../consts/strings.dart';

class MYButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color backGroundColor;
  final Function ontap;
  const MYButton({Key? key, required this.text,
    required this.textColor, required this.backGroundColor,
    required this.ontap}) : super(key: key);

  @override
  State<MYButton> createState() => _MYButtonState();
}

class _MYButtonState extends State<MYButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.ontap() ,
      child: Text(widget.text , style: TextStyle(
          color: widget.textColor
      ),),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      color: widget.backGroundColor,
    );
  }
}


class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const CustomButton({Key? key , required this.onTap ,required this.buttonText ,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
          ),
          onPressed: onTap, child: Text(buttonText),));
  }
}



class Button extends StatelessWidget {
   Button(
      {Key? key,
        required this.width,
        required this.title,
        required this.onPressed,
        required this.disable,
      this.height=50})
      : super(key: key);
  double height;
  final double width;
  final String title;
  final bool disable; //this is used to disable button
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
        ),
        onPressed: disable ? null : onPressed,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
