import 'package:assign/models/Product.dart';
import 'package:assign/provider/ItemProvider.dart';
import 'package:assign/route/cartprovider.dart';
import 'package:assign/screen/home/components/body.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_cube/flutter_cube.dart';
import 'package:model_viewer/model_viewer.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatefulWidget {
  final Product product;
  final Productmod productmod;
  final Function press;
  const ItemCard({
    Key key,
    this.press,
    gridDelegate,
    this.product,
    this.productmod,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  TextEditingController editnameController = TextEditingController();
  TextEditingController editpriceController = TextEditingController();
  TextEditingController editdbsController = TextEditingController();
  bool abletoedit = false;

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser.uid == 'vkUov6GLXoSe2HmWicQShB5mRmH3') {
      abletoedit = true;
    }
    return GestureDetector(
      onTap: widget.press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 150,
            width: 140,
            decoration: BoxDecoration(
                color: widget.product.color,
                borderRadius: BorderRadius.circular(20)),
            child: ModelViewer(
              src: widget.product.cubic,
              backgroundColor: widget.product.color,
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
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Text(
                  widget.product.title,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${widget.product.price} \$',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          abletoedit
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        iconSize: 20.0,
                        splashRadius: 20,
                        onPressed: () {
                          editproduct(widget.product);
                        },
                        icon: Icon(Icons.edit)),
                    Consumer<Product>(builder: (context, provider, child) {
                      return IconButton(
                          iconSize: 20.0,
                          splashRadius: 20,
                          onPressed: () {
                            provider.removeItem(widget.product);
                          },
                          icon: Icon(Icons.delete));
                    }),
                    Consumer<CartProvider>(builder: (context, provider, child) {
                      return Text(
                        '${widget.product.dbs} no.',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      );
                    }),
                  ],
                )
              : SizedBox(
                  height: 1,
                ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          //   child: Text(
          //     '${widget.product.price} \$',
          //     style:
          //         TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          //   ),
          // ),
        ],
      ),
    );
  }

  Future editproduct(Product product) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Edit Product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: editnameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'category cannot be empty';
                      }
                    },
                    decoration:
                        InputDecoration(hintText: 'Change product name'),
                  ),
                  TextFormField(
                    controller: editpriceController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'category cannot be empty';
                      }
                    },
                    decoration: InputDecoration(hintText: 'Change price'),
                  ),
                  TextFormField(
                    controller: editdbsController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'category cannot be empty';
                      }
                    },
                    decoration:
                        InputDecoration(hintText: 'Change product in stock'),
                  ),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      if (editnameController.text != null) {
                        product.title = editnameController.text;
                        product.price = int.parse(editpriceController.text);
                        product.dbs = int.parse(editdbsController.text);
                      }
                      Fluttertoast.showToast(msg: 'category created');
                      Navigator.pop(context);
                    },
                    child: Text('CHANGE')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('CANCEL')),
              ],
            ));
  }
}
