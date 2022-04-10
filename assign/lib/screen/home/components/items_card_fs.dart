import 'package:assign/models/Product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_cube/flutter_cube.dart';
import 'package:model_viewer/model_viewer.dart';

import '../../../service/storage_service.dart';

class ItemCardFirestorage extends StatelessWidget {
  final Product product;
  final Function press;
  final Storage storage = Storage();
  ItemCardFirestorage({
    Key key,
    this.product,
    this.press,
    gridDelegate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 160,
            width: 140,
            decoration: BoxDecoration(
                color: product.color, borderRadius: BorderRadius.circular(20)),
            child: ModelViewer(
              src: product.cubic,
              backgroundColor: product.color,
              ar: false,
              autoRotate: true,
              cameraControls: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              product.title,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Text(
              '${product.price} \$',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
