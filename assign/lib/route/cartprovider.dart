import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Productmod> items = [];

  addItem(Productmod item) {
    // provider.add( Product(name , price , qty ) )
    items.add(item);
    notifyListeners();
  }

  removeItem(Productmod item) {
    final int idx =
        items.indexWhere((elem) => item == elem); // elem ==> Product in item
    items.removeAt(idx);
    notifyListeners();
  }

  checkout() {
    //
  }

  double getTotalPrice() {
    double total = 0;
    items.forEach((elem) {
      total += elem.price;
    });
    return total;
  }

  int getItemCount() {
    return items.length;
  }
}

class Productmod {
  // model
  final String productName;
  final int price;
  final int qty;

  Productmod(this.productName, this.price, this.qty);

  @override
  String toString() {
    // TODO: implement toString
    return "${this.productName} ${this.price} ${this.qty}";
  }
}
