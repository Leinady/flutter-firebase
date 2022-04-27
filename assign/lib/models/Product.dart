import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  String description;
  String title;
  int price, dbs;
  int size, id;
  Color color;
  Object cubic;
  Product(
      {this.id,
      this.dbs,
      this.title,
      this.price,
      this.description,
      this.size,
      this.color,
      this.cubic});

  addproductwheel(Product item) {
    final int idx = products.indexWhere((elem) => item.title == elem.title);
    print(idx);
    if (idx >= 0) {
      print("product is stock");
    } else {
      products.add(item);
    }
    notifyListeners();
  }

  removeItem(Product item) {
    final int idx = products.indexWhere((elem) => item == elem);
    print(idx);
    products.removeAt(idx);
    notifyListeners();
  }
}

List<Product> products = [
  Product(
      id: 1,
      title: "TE-37",
      price: 1500,
      dbs: 20,
      size: 18,
      description: dummyText,
      cubic: 'assets/cude/wheel3d.gltf',
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "CE-28",
      price: 1400,
      dbs: 20,
      size: 8,
      description: dummyText,
      cubic: 'assets/cude/Volk.gltf',
      color: Colors.red[100]),
  Product(
      id: 3,
      title: "Wheel 4",
      price: 1800,
      dbs: 15,
      size: 9,
      description: dummyText,
      cubic: 'assets/cude/wheel4.gltf',
      color: Color.fromARGB(255, 41, 219, 250)),
];

List<Product> productsh = [
  Product(
      id: 1,
      title: "Shock up 1",
      price: 500,
      size: 5,
      dbs: 20,
      description: dummyText,
      cubic: 'assets/cude/pistao_hidraulico.gltf',
      color: Colors.red[100]),
];

List<Product> productex = [
  Product(
      id: 1,
      title: "Exhaust 1",
      price: 2500,
      size: 2,
      dbs: 20,
      description: dummyText,
      cubic: 'assets/cude/toba.gltf',
      color: Colors.lime[100]),
];
List<Product> productw = [
  Product(
      id: 1,
      title: "Wing 1",
      price: 4800,
      size: 10,
      dbs: 30,
      description: dummyText,
      cubic: 'assets/cude/spoiler.gltf',
      color: Colors.brown[100]),
];
List<Product> producthd = [
  Product(
      id: 1,
      title: "Brake 1",
      price: 8950,
      size: 5,
      dbs: 30,
      description: dummyText,
      cubic: 'assets/cude/Brake1.gltf',
      color: Color.fromARGB(255, 231, 131, 240)),
  Product(
      id: 2,
      title: "Brake 2",
      price: 15000,
      size: 5,
      dbs: 30,
      description: dummyText,
      cubic: 'assets/cude/Brake2.gltf',
      color: Color.fromARGB(255, 245, 133, 133)),
];

String dummyText =
    "The first model was a 15 inch with a startling 3.7kg, thus TE37. This model would be known decades later as the origin of forged sports wheel and is considered one of the masterpieces from Volkracing. Excellent stress variance with a calculated 6 spoke design offering various ranges in sizes and model variations";
