import 'package:assign/models/Product.dart';
import 'package:assign/screen/detail/components/Description.dart';
import 'package:assign/screen/detail/components/productTitle_3d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  padding: EdgeInsets.only(
                      top: size.height * 0.05, left: 20, right: 20),
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(text: "Size\n"),
                                  TextSpan(
                                      text: "${product.size} inch",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ],
                      ),
                      Description(product: product),
                      CartCounter(),
                    ],
                  ),
                ),
                ProductTitlewith3d(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CartCounter extends StatefulWidget {
  CartCounter({Key key}) : super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numofItem = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numofItem >= 1) {
              setState(() {
                numofItem--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(numofItem.toString().padLeft(2, "0"),
              style: Theme.of(context).textTheme.headline6),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numofItem++;
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
