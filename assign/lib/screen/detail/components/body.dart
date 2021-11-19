import 'package:assign/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:assign/screen/detail/detail_screen.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:model_viewer/model_viewer.dart';

class Bodys extends StatelessWidget {
  final Product product;

  const Bodys({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.4),
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Wheel W-Work",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: <Widget>[
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(text: "price\n"),
                            TextSpan(
                                text: "\$${product.price}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                          ])),
                          Expanded(
                            //child: Image.asset('assets/images/wheel1.jpg'),
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
                              ), /*Cube(onSceneCreated: (Scene scene) {
                                scene.world.add(Object(
                                    fileName: product.cubic,
                                    rotation: Vector3(0, -90, 0)));
                                scene.camera.zoom = 12;
                                scene.world.updateTransform();
                              }),*/
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
