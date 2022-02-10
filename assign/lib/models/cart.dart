import 'package:flutter/material.dart';

import 'Product.dart';

class Cart {
  final Product product;
  final int numOfItem;

  Cart({this.product, this.numOfItem});
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: products[0], numOfItem: 2),
  Cart(product: products[1], numOfItem: 1),
  Cart(product: products[3], numOfItem: 1),
];
