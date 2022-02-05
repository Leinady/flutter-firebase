import 'package:assign/models/cart.dart';
import "package:flutter/material.dart";

class Cartitem extends StatelessWidget {
  const Cartitem({
    Key key,
    this.cart,
  }) : super(key: key);

  final Cart cart;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 150,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Image.asset("assets/images/wheel1.jpg"),
              ),
            )),
        SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                cart.product.title,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 5),
              Text.rich(TextSpan(
                  text: "\$${cart.product.price}",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                        text: " x${cart.numOfItem}",
                        style: TextStyle(color: Colors.red))
                  ]))
            ],
          ),
        )
      ],
    );
  }
}
