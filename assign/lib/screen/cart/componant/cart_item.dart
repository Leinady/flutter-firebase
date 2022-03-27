import 'package:assign/models/Product.dart';
import 'package:assign/models/cart.dart';
import 'package:assign/route/cartprovider.dart';
import "package:flutter/material.dart";
import 'package:model_viewer/model_viewer.dart';

class Cartitem extends StatelessWidget {
  const Cartitem({
    Key key,
    this.cart,
    this.product,
  }) : super(key: key);

  final Productmod product;
  final dynamic cart;

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
                // child: Image.asset("assets/images/wheel1.jpg"),
                child: ModelViewer(
                  src: product.cubic,
                  backgroundColor: Colors.white,
                  ar: false,
                  autoRotate: true,
                  cameraControls: true,
                ),
              ),
            )),
        SizedBox(
          width: 15,
        ),
        SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                // cart.product.title,
                product.productName,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(
                height: 5,
              ),
              Text.rich(TextSpan(
                  // text: "\$${cart.product.price}",
                  text: "\$${product.price}",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                        // text: " x${cart.numOfItem}",
                        text: " x${product.qty}",
                        style: TextStyle(color: Colors.red))
                  ])),
            ],
          ),
        )
      ],
    );
  }
}
