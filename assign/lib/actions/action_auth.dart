import 'package:assign/screen/admin/dashbord.dart';
import 'package:assign/screen/authen/sign_in.dart';
import 'package:assign/screen/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActionAuth {
  static registerWithEmailAndPassword(
      {String email, String password, String role}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection('user')
          .doc(userCredential.user.uid)
          .set({
        'uid': userCredential.user.uid,
        "email": email,
        'role': role,
      });
      print("[FirebaseAuth] : Register Done!");
      return true;
    } on FirebaseAuthException catch (err) {
      print("[FirebaseAuth] : Register Failed! $err");
      return false;
    }
  }

  static login(BuildContext context, {String email, String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      final response = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("res" + response.toString());

      if (response.user.displayName != null) {
        localStorage.setString('displayName', response.user.displayName);
      }
      if (response.user.email != null) {
        localStorage.setString('email', response.user.email);
      }
      if (response.user.uid != null) {
        localStorage.setString('uid', response.user.uid);
      }

      print("[FirebaseAuth] : Login Done!");

      if (localStorage.getString('uid') != null &&
          localStorage.getString('uid') == 'vkUov6GLXoSe2HmWicQShB5mRmH3') {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Admin(),
            ));
      } else {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ));
      }
    } on FirebaseAuthException catch (err) {
      print("[FirebaseAuthException] : $err");
      return false;
    }
  }

  static logout(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    await auth.signOut();
    print("[FirebaseAuth] : Logout Done!");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => SignIn()), (route) => false);
  }

  static checkAuth(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (localStorage.getString('uid') != null &&
        localStorage.getString('uid') == 'vkUov6GLXoSe2HmWicQShB5mRmH3') {
      return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Admin(),
          ));
    }

    if (localStorage.getString('uid') != null) {
      return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    }
  }
}
