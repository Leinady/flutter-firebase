import 'package:assign/models/Product.dart';
import 'package:assign/models/cart.dart';
import 'package:assign/screen/home/components/items_card.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer/model_viewer.dart';
import 'package:flutter_svg/svg.dart';

import 'cart_item.dart';

class BodyC extends StatefulWidget {
  final Product product;
  const BodyC({Key key, this.product}) : super(key: key);

  @override
  State<BodyC> createState() => _BodyCState();
}

class _BodyCState extends State<BodyC> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: demoCarts.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
              key: Key(demoCarts[0].product.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/images/Trash.svg")
                  ],
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  demoCarts.removeAt(index);
                });
              },
              child: Cartitem(cart: demoCarts[index])),
        ),
      ),
    );
  }
}
