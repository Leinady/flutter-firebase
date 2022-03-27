import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier {
  int itemCount = 0;

  ItemProvider();

  increaseItem() {
    this.itemCount++;
    notifyListeners();
  }

  decreaseItem() {
    this.itemCount--;
    notifyListeners();
  }

  itemReset() {
    this.itemCount = 0;
    notifyListeners();
  }
}
