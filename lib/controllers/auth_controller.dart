
import 'package:amazon/views/home.dart';
import 'package:amazon/views/login_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  var fullnameControler = TextEditingController();
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();


  UserCredential? userCredential;

  //current user
  User? get currentUser=> FirebaseAuth.instance.currentUser ;
  Stream<User?> authStateChanges() => FirebaseAuth.instance.authStateChanges();

  isUserAlreadyLoggedIn() async {
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user!=null){
        Get.offAll(() => Home());
      }else {
        Get.offAll(() => LoginView());
      }
    });
  }

 // login
  login() async{
    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailControler.text,
        password: passwordControler.text);
  }
  signupUser() async{
    userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailControler.text,
        password: passwordControler.text);

    if(userCredential !=null) {
      await storeUserData(userCredential!.user!.uid ,fullnameControler.text , emailControler.text);
    }
  }

  storeUserData(String uid , String fullname , String email) async{
    var store = FirebaseFirestore.instance.collection('users').doc(uid);
    await store.set({
      "fullname":fullname ,
      "email":email,

    });
  }
  signOut() async{
    await FirebaseAuth.instance.signOut();
  }
}