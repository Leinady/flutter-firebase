import 'package:assign/models/Product.dart';
import 'package:assign/models/cart.dart';
import 'package:assign/route/cartprovider.dart';
import 'package:assign/screen/home/components/body.dart';
import 'package:assign/screen/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'componant/body.dart';
import 'componant/cart_checkout.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  final Product product;
  final Cart cart;
  const CartScreen({Key key, this.product, this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: newMethod(context),
        body: BodyC(),

        // ListView.builder(
        //   ///////////////////////////////
        //   shrinkWrap: true,
        //   itemCount: value.items.length,
        //   itemBuilder: (context, index) {
        //     return Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        //       child: Row(
        //         children: [
        //           Text('${value.items[index].productName}'),
        //           Spacer(),
        //           Text('\$ ${value.items[index].price}'),
        //           Spacer(),
        //           Text('${value.items[index].qty}')
        //         ],
        //       ),
        //     );
        //   },
        // ),
        bottomNavigationBar: CheckOut(),
      );
    });
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
          Consumer<CartProvider>(builder: (context, provider, child) {
            return Text(
              "${provider.getItemCount()} item ",
              style: Theme.of(context).textTheme.caption,
            );
          }),
        ],
      ),
    );
  }
}
