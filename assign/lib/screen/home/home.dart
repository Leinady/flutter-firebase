//import 'dart:html';
import 'package:assign/provider/ItemProvider.dart';
import 'package:assign/screen/authen/sign_in.dart';
import 'package:assign/screen/cart/cart_screen.dart';
import 'package:assign/screen/proflie/profile_screen.dart';
import 'package:assign/service/authserv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assign/screen/home/components/body.dart';
import 'package:provider/provider.dart';

import '../../models/Product.dart';

class Home extends StatelessWidget {
  //const home({Key key}) : super(key: key);
  final Product product;

  Home({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Body(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          actions: <Widget>[
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
