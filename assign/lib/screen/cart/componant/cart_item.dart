import 'package:assign/models/Product.dart';
import 'package:assign/models/cart.dart';
import "package:flutter/material.dart";
import 'package:model_viewer/model_viewer.dart';

class Cartitem extends StatelessWidget {
  const Cartitem({
    Key key,
    this.cart,
    this.product,
  }) : super(key: key);

  final Product product;
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
                // child: Image.asset("assets/images/wheel1.jpg"),
                child: ModelViewer(
                  src: product.cubic,
                  backgroundColor: product.color,
                  ar: false,
                  autoRotate: true,
                  cameraControls: true,
                ),
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
                        text: " x${cart.numofItem}",
                        style: TextStyle(color: Colors.red))
                  ]))
            ],
          ),
        )
      ],
    );
  }
}
