import 'package:assign/models/Product.dart';
import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier {
  List<Product> items = [];

  addproduct(Product item) {
    final int idx = items.indexWhere((elem) => item.title == elem.title);
    print(idx);
    if (idx >= 0) {
      print("product is stock");
    } else {
      items.add(item);
    }
    notifyListeners();
  }
}
