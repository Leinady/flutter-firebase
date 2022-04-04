import 'package:assign/models/cart.dart';
import 'package:assign/route/cartprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatelessWidget {
  final Cart cart;
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  CheckOut({
    Key key,
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
              Consumer<CartProvider>(builder: (context, provider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(text: "Total:\n", children: [
                        TextSpan(
                            // onEnter: (Product product) {
                            //   myCart.product = product;
                            // };
                            text: "\$ ${provider.getTotalPrice()}",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ]),
                    ),
                    Consumer<CartProvider>(builder: (context, provider, child) {
                      return SizedBox(
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
                              showDialog(
                                  context: context,
                                  // barrierDismissible: false,
                                  builder: (context) => Dialog(
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Icon(Icons.check),
                                              Text('Success'),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                      ));
                              List proN = [];
                              provider.items.forEach((element) async {
                                proN.add(element.productName);
                                final res = await _basketCollection.add({
                                  "Username": auth.currentUser.email,
                                  "Total price": provider.getTotalPrice(),
                                  "Product name": proN
                                });
                                if (res != null) {
                                  Navigator.pop(context);
                                } else {
                                  print(res);
                                }
                              });

                              print(proN);
                            },
                            child: Text("Check out"),
                          ));
                    }),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
