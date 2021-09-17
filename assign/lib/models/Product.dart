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
      size: 12,
      description: 'dummyText',
      cubic: 'assets/cude/wheel3d.obj',
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "CE-28",
      price: 1400,
      size: 8,
      description: 'dummyText',
      cubic: 'assets/cude/wheel3d.obj',
      color: Color(0xFFD3A984)),
  Product(
      id: 2,
      title: "Belt Bag",
      price: 1200,
      size: 8,
      description: 'dummyText',
      cubic: 'assets/cude/wheel3d.obj',
      color: Color(0xFFD3A984)),
  Product(
      id: 2,
      title: "Belt Bag",
      price: 1200,
      size: 8,
      description: 'dummyText',
      cubic: 'assets/cude/wheel3d.obj',
      color: Color(0xFFD3A984)),
  Product(
      id: 2,
      title: "Belt Bag",
      price: 1200,
      size: 8,
      description: 'dummyText',
      cubic: 'assets/cude/wheel3d.obj',
      color: Color(0xFFD3A984)),
  Product(
      id: 2,
      title: "Belt Bag",
      price: 1200,
      size: 8,
      description: 'dummyText',
      cubic: 'assets/cude/wheel3d.obj',
      color: Color(0xFFD3A984)),
];
