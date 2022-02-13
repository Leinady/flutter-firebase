import 'package:flutter/material.dart';

class Cartprovider with ChangeNotifier {
  int _productcartnumber = 1;

  int get productcartnumber => _productcartnumber;

  void addnumber() {
    _productcartnumber++;
    notifyListeners();
  }

  void minusnumber() {
    _productcartnumber--;
    notifyListeners();
  }
}
