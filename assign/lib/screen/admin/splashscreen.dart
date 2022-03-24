import 'dart:async';
import 'package:assign/screen/home/components/body.dart';
import 'package:assign/screen/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'adminscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String role = 'user';

  @override
  void initState() {
    super.initState();
    _checkRole();
  }

  void _checkRole() async {
    User user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

    setState(() {
      role = snap['role'];
    });

    if (role == 'user') {
      navigateNext(Home());
    } else if (role == 'admin') {
      navigateNext(AdminScreen());
    }
  }

  void navigateNext(Widget route) {
    Timer(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => route));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome'),
          ],
        ),
      ),
    );
  }
}
