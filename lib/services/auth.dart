
import 'package:amazon/views/patient/models/PatientModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../models/booking_date_time_converter.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password , String fullName,
      String deviceToken ,bool isDoctor , {required File imageFile}) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if(authResult !=null) {
      final storageRef=  FirebaseStorage.instance.ref().child("allusers_images").
      child("${authResult.user!.uid}.jpg");
      await storageRef.putFile(imageFile);
      final imageUrl =await storageRef.getDownloadURL();
      await storeUserData(authResult.user!.uid, fullName, authResult.user!.email!,
          deviceToken ,isDoctor ,imageUrl);

    }
    return authResult;
  }

  Future<UserCredential> signIn(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future<User?> getUser() async {
    return await _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  storeUserData(String uid , String fullName , String email ,String deviceToken ,bool isDoctor
       , String ImageUrl) async {
    var store =FirebaseFirestore.instance.collection("patients").doc(uid);
    final patienntModel=PatientModel(id: uid, email: email ,deviceToken:deviceToken ,isDoctor: isDoctor
    , name: fullName ,pictureUrl: ImageUrl);
    final user=userModel(id: uid, name: fullName, isDoctor: isDoctor, pictureUrl: ImageUrl, email: email);

    await store.set(patienntModel.toJson());
    await FirebaseFirestore.instance.collection("users").doc(uid).set(user.toJson());
  }
}