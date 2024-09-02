
 import 'package:firebase_messaging/firebase_messaging.dart';


class FirebaseApi  {

   static String deviceToken="";
   final _firebaseMessaging=FirebaseMessaging.instance;

    Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fcmToken=await _firebaseMessaging.getToken();
    deviceToken = fcmToken!;
    print(fcmToken);
    print(deviceToken);
   }
 }