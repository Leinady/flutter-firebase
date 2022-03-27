import 'package:assign/models/Product.dart';
import 'package:assign/models/cart.dart';
import 'package:assign/provider/ItemProvider.dart';
import 'package:assign/route/cartprovider.dart';
import 'package:assign/screen/cart/cart_screen.dart';
import 'package:assign/screen/detail/components/Description.dart';
import 'package:assign/screen/detail/components/productTitle_3d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bodys extends StatefulWidget {
  final Product product;
  final int numofItem;
  final Cart cart;

  const Bodys({Key key, this.product, this.numofItem, this.cart})
      : super(key: key);

  @override
  State<Bodys> createState() => _BodysState();
}

class _BodysState extends State<Bodys> {
  int itemCount = 1;
  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }

  Consumer CartCounter() {
    return Consumer<CartProvider>(
      builder: (context, cartprovider, child) => Row(
        children: <Widget>[
          buildOutlineButton(
            icon: Icons.remove,
            press: () {
              if (itemCount >= 1) {
                setState(() {
                  itemCount--;
                });
              }
            },
          ),
          Consumer<ItemProvider>(builder: (context, itemProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(itemCount.toString().padLeft(2, "0"),
                  style: Theme.of(context).textTheme.headline6),
            );
          }),
          buildOutlineButton(
              icon: Icons.add,
              press: () {
                setState(() {
                  itemCount++;
                });
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Cartprovider provider;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.4),
                  padding: EdgeInsets.only(
                      top: size.height * 0.05, left: 20, right: 20),
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(text: "Size\n"),
                                  TextSpan(
                                      text: "${widget.product.size} inch",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ],
                      ),
                      Description(product: widget.product),
                      CartCounter(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 50,
                              width: 58,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: widget.product.color),
                                  borderRadius: BorderRadius.circular(18)),
                              child: Consumer<CartProvider>(
                                builder: (context, cartprovider, child) =>
                                    IconButton(
                                        onPressed: () {
                                          //demoCarts.add(Cart(product, 2));

                                          print(widget.product.cubic);
                                          cartprovider.addItem(Productmod(
                                              widget.product.title,
                                              widget.product.price,
                                              itemCount,
                                              cubic: widget.product.cubic));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CartScreen()));
                                        },
                                        icon:
                                            Icon(Icons.shopping_cart_outlined)),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  color: widget.product.color,
                                  onPressed: () {},
                                  child: Text(
                                    "Buy".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ProductTitlewith3d(product: widget.product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
