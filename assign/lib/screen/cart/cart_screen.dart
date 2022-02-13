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
      body: BodyC(product: product),
      bottomNavigationBar: CheckOut(),
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

class CheckOut extends StatelessWidget {
  const CheckOut({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 174,
      //  color: Colors.blue,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(text: "Total:\n", children: [
                      TextSpan(
                          text: "\$200",
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    ]),
                  ),
                  SizedBox(
                      width: 190,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          primary: Colors.white,
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () {},
                        child: Text("Check out"),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
