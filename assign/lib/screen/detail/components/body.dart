import 'dart:convert';
import 'package:assign/models/Product.dart';
import 'package:assign/models/cart.dart';
import 'package:assign/provider/ItemProvider.dart';
import 'package:assign/route/cartprovider.dart';
import 'package:assign/screen/cart/cart_screen.dart';
import 'package:assign/screen/detail/components/Description.dart';
import 'package:assign/screen/detail/components/productTitle_3d.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
  Map<String, dynamic> paymentIntentData;

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
                                  onPressed: () async {
                                    await makePayment();

                                    // Map<String, dynamic> body = {
                                    //   'amount': '10000',
                                    //   'currency': 'THB',
                                    // };
                                    // print(body);
                                    // var response = await http.post(
                                    //     Uri.parse(
                                    //         'https://api.stripe.com/v1/payment_intents'),
                                    //     body: body,
                                    //     headers: {
                                    //       'Authorization':
                                    //           'Bearer sk_test_51KmBZIDp0AbO0nPgVTDGgQXtJTxoomUyRw5PKyI8Arxmmw63Pkg7MhvAcTWaf49OEAcGRXxpJizae5anZ9kCpW2400P7vgKyVd',
                                    //       'Content-Type':
                                    //           'application/x-www-form-urlencoded'
                                    //     });
                                    // print(
                                    //     'Create Intent reponse ===> ${response.body.toString()}');

                                    // var jsonBody = jsonDecode(response.body);

                                    // Map<String, dynamic> paymentIntentData;

                                    // paymentIntentData = jsonBody;
                                    // if (paymentIntentData["paymentIntent"] !=
                                    //         "" &&
                                    //     paymentIntentData["paymentIntent"] !=
                                    //         null) {
                                    //   String _intent =
                                    //       paymentIntentData["paymentIntent"];
                                    //   await Stripe.instance.initPaymentSheet(
                                    //     paymentSheetParameters:
                                    //         SetupPaymentSheetParameters(
                                    //       paymentIntentClientSecret: _intent,
                                    //       applePay: false,
                                    //       googlePay: false,
                                    //       merchantCountryCode: "TH",
                                    //       merchantDisplayName: "Test",
                                    //       testEnv: false,
                                    //       customerId:
                                    //           paymentIntentData['customer'],
                                    //       customerEphemeralKeySecret:
                                    //           paymentIntentData['ephemeralKey'],
                                    //     ),
                                    //   );

                                    //   await Stripe.instance
                                    //       .presentPaymentSheet();
                                    // }
                                  },
                                  child: Text(
                                    "Buy".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
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

  Future<void> makePayment() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      paymentIntentData =
          await createPaymentIntent(widget.product.price.toString(), 'THB');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData["client_secret"],
              applePay: true,
              googlePay: true,
              testEnv: false,
              style: ThemeMode.dark,
              merchantCountryCode: 'TH',
              merchantDisplayName: auth.currentUser.email));

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData['client_secret'],
        confirmPayment: true,
      ));

      BuildContext context;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("paid successfully")));

      paymentIntentData = null;
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      var context;
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

//  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KmBZIDp0AbO0nPgVTDGgQXtJTxoomUyRw5PKyI8Arxmmw63Pkg7MhvAcTWaf49OEAcGRXxpJizae5anZ9kCpW2400P7vgKyVd',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      //  print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body.toString());
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
