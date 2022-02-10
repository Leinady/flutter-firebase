import 'package:assign/models/Product.dart';
import 'package:assign/screen/home/components/body.dart';
import 'package:assign/screen/home/home.dart';
import 'package:flutter/material.dart';

import 'componant/body.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  final Product product;

  const CartScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newMethod(context),
      body: BodyC(),
    );
  }

  AppBar newMethod(BuildContext context) {
    return AppBar(
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
      ],
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${products.length} item ",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
