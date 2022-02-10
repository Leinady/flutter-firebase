import 'package:assign/models/Product.dart';
import 'package:assign/screen/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:assign/screen/home/components/body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:assign/screen/detail/components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: product.color,
      appBar: buildAppBar(context),
      body: Bodys(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    var index;
    return AppBar(
      backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back),
        color: Colors.black,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
          color: Colors.black,
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
