import 'package:flutter/material.dart';
import 'package:model_viewer/model_viewer.dart';
import 'package:assign/models/Product.dart';

class ProductTitlewith3d extends StatelessWidget {
  const ProductTitlewith3d({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Wheel RAYS",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            product.title,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: <Widget>[
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: "price\n"),
                TextSpan(
                    text: "\$${product.price}",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ])),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: 160,
                  width: 140,
                  decoration: BoxDecoration(
                      color: product.color,
                      borderRadius: BorderRadius.circular(20)),
                  child: ModelViewer(
                    src: product.cubic,
                    backgroundColor: product.color,
                    // alt: "A 3D model of an astronaut",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
