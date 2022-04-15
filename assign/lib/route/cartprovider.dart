import 'package:assign/models/Product.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Productmod> items = [];

  addItem(Productmod item) {
    // provider.add( Product(name , price , qty ) )
    final int idx =
        items.indexWhere((elem) => item.productName == elem.productName);
    print(idx);
    if (idx >= 0) {
      print("product is already have in cart");
    } else {
      items.add(item);
    }

    notifyListeners();
  }

  removeItem(Productmod item) {
    final int idx =
        items.indexWhere((elem) => item == elem); // elem ==> Product in item
    items.removeAt(idx);
    notifyListeners();
  }

  int checkstock() {
    int stock = 0;
    items.forEach((element) {
      stock = element.qtyindb - element.qty;
    });
    notifyListeners();
    return stock;
  }

  double getTotalPrice() {
    double total = 0;
    items.forEach((elem) {
      total += (elem.price * elem.qty);
    });
    notifyListeners();
    return total;
  }

  int getItemCount() {
    notifyListeners();
    return items.length;
  }

  int getAllItemCount() {
    int count = 0;
    items.forEach((item) {
      item.qty += count;
    });
    notifyListeners();
    return count;
  }
}

class Productmod {
  // model
  final String productName;
  final int price;
  final Object cubic;
  int qtyindb;
  int qty;

  Productmod(this.productName, this.qtyindb, this.price, this.qty,
      {this.cubic});

  @override
  String toString() {
    // TODO: implement toString
    return "${this.productName} ${this.price} ${this.qty}";
  }
}
