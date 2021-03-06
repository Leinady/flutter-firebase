import 'package:assign/screen/cart/cart_screen.dart';
import 'package:assign/screen/parts/components/body.dart';
import 'package:assign/screen/parts/components/bodyhd.dart';
import 'package:flutter/material.dart';

import '../proflie/profile_screen.dart';

class HeaderScreen extends StatelessWidget {
  const HeaderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyHd(),
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
