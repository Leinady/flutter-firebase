import 'package:assign/models/Product.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_cube/flutter_cube.dart';
import 'package:model_viewer/model_viewer.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
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
              // alt: "A 3D model of an astronaut",
              ar: false,
              autoRotate: true,
              cameraControls: true,
            ), /*Cube(onSceneCreated: (Scene scene) {
              scene.world.add(Object(
                  fileName: product.cubic, rotation: Vector3(0, -90, 0)));
              scene.camera.zoom = 12;
              scene.world.updateTransform();
            }),*/
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
