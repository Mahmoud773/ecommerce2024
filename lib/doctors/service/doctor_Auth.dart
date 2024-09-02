

import 'package:amazon/doctors/models/doctor_model.dart';
import 'package:amazon/models/booking_date_time_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DoctorAuth {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp({required String email, required String password , required String fullName ,
    required String Category , required String experience ,
    required File imageFile ,bool isDoctor=false  , String deviceToken=""}) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if(authResult !=null) {

      //uploadImage to firbase storage
    final storageRef=  FirebaseStorage.instance.ref().child("allusers_images").
    child("${authResult.user!.uid}.jpg");
    await storageRef.putFile(imageFile);
         final imageUrl =await storageRef.getDownloadURL();

      final doctorModel =DoctorModel(id: authResult.user!.uid, email: email ,name: fullName,Category: Category ,
          experience: experience,pictureUrl: imageUrl ,
          appointsDays: [] , isFavorite: false ,isDoctor: isDoctor ,deviceToken: deviceToken);
      await storeUserData(Category:doctorModel.Category ,fullName: doctorModel.name,
        email:doctorModel.email ,experience:doctorModel.experience ,pictureUrl: doctorModel.pictureUrl,
        uid: doctorModel.id , appointsDays: doctorModel.appointsDays!,isFavorite: doctorModel.isFavorite,
        isDoctor: isDoctor,deviceToken: deviceToken
      );

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

  storeUserData({required String uid , required String fullName , required String email ,
    required String Category , required String experience ,
      required String pictureUrl , required List<DayDetails> appointsDays , bool isFavorite=false
  ,bool isDoctor=false , String deviceToken=""}) async {
    var store =FirebaseFirestore.instance.collection("doctors").doc(uid);
    final doctorModel =DoctorModel(id: uid, email: email ,name: fullName,Category: Category ,
    experience: experience,pictureUrl: pictureUrl , appointsDays: appointsDays , isFavorite:isFavorite,
    isDoctor: isDoctor ,deviceToken:deviceToken );
    final user=userModel(id: uid, name: fullName, isDoctor: isDoctor, pictureUrl: pictureUrl, email: email);

    await  store.set(doctorModel.toJson());
    await FirebaseFirestore.instance.collection("users").doc(uid).set(user.toJson());
    // await store.set({"fullName" : fullName , "email" : email });
  }

}