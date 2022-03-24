import 'package:assign/models/Product.dart';
import 'package:assign/models/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckOut extends StatelessWidget {
  final Product product;
  final Cart cart;
  final formKey = GlobalKey<FormState>();

  CheckOut({
    Key key,
    this.product,
    this.cart,
  }) : super(key: key);

  CollectionReference _basketCollection =
      FirebaseFirestore.instance.collection("Basket");

  @override
  Widget build(BuildContext context) {
    return Container(
      key: formKey,
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
                          // onEnter: (Product product) {
                          //   myCart.product = product;
                          // };
                          text: "\$ 200",
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
                        onPressed: () async {
                          // formKey.currentState.save();
                          // await _basketCollection.add({
                          //   "product": cart.product,
                          //   "Number of item": cart.numOfItem,
                          // });
                          print('${cart}');
                        },
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
