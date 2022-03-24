//import 'dart:html';
import 'package:assign/screen/authen/sign_in.dart';
import 'package:assign/screen/cart/cart_screen.dart';
import 'package:assign/screen/proflie/profile_screen.dart';
import 'package:assign/service/authserv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assign/screen/home/components/body.dart';

class Home extends StatelessWidget {
  //const home({Key key}) : super(key: key);

  final Authservice _auth = Authservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Body(),
        appBar: AppBar(
          title: Text('Home page'),
          backgroundColor: Colors.white,
          elevation: 1,
          actions: <Widget>[
            IconButton(
                onPressed: () async {
                  await _auth.signOut();
                  // .then((value) {
                  //   Navigator.pushReplacement(context,
                  //       MaterialPageRoute(builder: (context) {
                  //     return SignIn();
                  //   }));
                  // });
                },
                icon: Icon(Icons.backspace_rounded),
                color: Colors.black),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              icon: Icon(Icons.add_shopping_cart),
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompleteProfileScreen()),
                );
              },
              icon: Icon(Icons.person_outline),
              color: Colors.black,
            ),
            SizedBox()
          ],
        ));
  }
}
