import 'package:assign/screen/home/components/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Garage Tuning",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Categories(),
        Container(
          height: 160,
          width: 140,
          decoration: BoxDecoration(
              color: Colors.blue[100], borderRadius: BorderRadius.circular(20)),
          child: Cube(onSceneCreated: (Scene scene) {
            scene.world.add(Object(
                fileName: 'assets/cude/wheel3d.obj',
                rotation: Vector3(0, -90, 0)));
            scene.camera.zoom = 12;
            scene.world.updateTransform();
          }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: Text(
            'TE-37',
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    );
  }
}
