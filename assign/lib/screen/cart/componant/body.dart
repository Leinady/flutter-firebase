import 'package:assign/models/Product.dart';
import 'package:assign/models/cart.dart';
import 'package:assign/route/cartprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
    return Consumer<CartProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: provider.items.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
                key: Key(provider.items[0].productName.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg")
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    provider.items.removeAt(index);
                    // demoCarts.removeAt(index);
                  });
                },
                child: Cartitem(
                  cart: "",
                  product: provider.items[index],
                )),
          ),
        ),
      );
    });
  }
}
