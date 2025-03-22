
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowcaseWidget extends StatelessWidget {
  final Widget child;
  final String description;
  final GlobalKey globalKey;

  const CustomShowcaseWidget({
 required this.description,
    required this.child,
    required this.globalKey,
  });

  @override
  Widget build(BuildContext context) => Showcase(
    key: globalKey,
    tooltipBackgroundColor: Colors.pink.shade400,
    descriptionPadding: EdgeInsets.all(12),
    showArrow: false,
    //disableAnimation: true,
    // title: 'Hello',
    // titleTextStyle: TextStyle(color: Colors.white, fontSize: 32),
    description: description,
    descTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    // overlayColor: Colors.white,
    // overlayOpacity: 0.7,
    child: child,
  );
}