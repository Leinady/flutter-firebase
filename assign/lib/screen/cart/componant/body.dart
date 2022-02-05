import 'package:assign/models/Product.dart';
import 'package:assign/models/cart.dart';
import 'package:assign/screen/home/components/items_card.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer/model_viewer.dart';

import 'cart_item.dart';

class BodyC extends StatelessWidget {
  final Product product;
  const BodyC({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Cartitem(cart: demoCarts[0]),
      ],
    );
  }
}
