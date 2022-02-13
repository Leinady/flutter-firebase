import 'package:assign/screen/cart/cart_screen.dart';
import 'package:assign/screen/parts/components/body.dart';
import 'package:flutter/material.dart';

class Shockupscreen extends StatelessWidget {
  const Shockupscreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyS(),
        appBar: AppBar(
          // title: Text('Home page'),
          backgroundColor: Colors.white,
          elevation: 1,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
            ),
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
            SizedBox()
          ],
        ));
  }
}
