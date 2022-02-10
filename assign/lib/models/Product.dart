import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
  final Color color;
  Object cubic;
  Product(
      {this.id,
      this.image,
      this.title,
      this.price,
      this.description,
      this.size,
      this.color,
      this.cubic});
}

List<Product> products = [
  Product(
      id: 1,
      title: "TE-37",
      price: 1500,
      size: 18,
      description: dummyText,
      cubic: 'assets/cude/wheel3d.gltf',
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "CE-28",
      price: 1400,
      size: 8,
      description: dummyText,
      cubic: 'assets/cude/Volk.gltf',
      color: Colors.red[100]),
  Product(
      id: 2,
      title: "Belt Bag",
      price: 1200,
      size: 8,
      description: dummyText,
      cubic: 'assets/cude/Volk.gltf',
      color: Colors.orange[100]),
  Product(
      id: 2,
      title: "Belt Bag",
      price: 1200,
      size: 8,
      description: dummyText,
      cubic: 'assets/cude/wheel3d.gltf',
      color: Color(0xFFD3A984)),
  Product(
      id: 2,
      title: "Belt Bag",
      price: 1200,
      size: 8,
      description: dummyText,
      cubic: 'assets/cude/wheel3d.gltf',
      color: Color(0xFFD3A984)),
  Product(
      id: 2,
      title: "Belt Bag",
      price: 1200,
      size: 8,
      description: dummyText,
      cubic: 'assets/cude/wheel3d.gltf',
      color: Color(0xFFD3A984)),
];

String dummyText =
    "The first model was a 15 inch with a startling 3.7kg, thus TE37. This model would be known decades later as the origin of forged sports wheel and is considered one of the masterpieces from Volkracing. Excellent stress variance with a calculated 6 spoke design offering various ranges in sizes and model variations";
