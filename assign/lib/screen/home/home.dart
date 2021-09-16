//import 'dart:html';
import 'package:assign/service/authserv.dart';
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
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.black),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_shopping_cart),
              color: Colors.black,
            ),
            SizedBox()
          ],
        ));
  }
}
