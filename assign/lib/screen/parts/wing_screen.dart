import 'package:assign/screen/cart/cart_screen.dart';
import 'package:assign/screen/parts/components/body.dart';
import 'package:assign/screen/parts/components/bodyw.dart';
import 'package:flutter/material.dart';

import '../proflie/profile_screen.dart';

class WingScreen extends StatelessWidget {
  const WingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyW(),
        appBar: AppBar(
          // title: Text('Home page'),
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
