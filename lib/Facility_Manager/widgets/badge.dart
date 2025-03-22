
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
class MyBadge extends StatefulWidget {
  bool update;
  int listLenght;
  int number;
  int increaseNumber;
   MyBadge({super.key , required this.number ,required this.increaseNumber ,
     required this.listLenght , required this.update});

  @override
  State<MyBadge> createState() => _MyBadgeState();
}
void  changeNumber(){

}
class _MyBadgeState extends State<MyBadge> {

  void  changeNumber(){
   setState(() {
     widget.number +=widget.listLenght ;
   });
  }
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
       if(widget.update==true)
         setState(()=> widget.number +=widget.listLenght);
    return badges.Badge(
      badgeContent: Text('${widget.number}'),
      child: Icon(Icons.pending),
      position: badges.BadgePosition.topEnd(top: -10, end: -12),
      showBadge:widget.number>0 ?false : true ,
    );

    },);
  }
}
