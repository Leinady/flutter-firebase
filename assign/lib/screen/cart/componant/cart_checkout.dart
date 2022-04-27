import 'dart:convert';
import 'package:assign/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:assign/models/cart.dart';
import 'package:assign/route/cartprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatelessWidget {
  final Product product;
  final Productmod productmod;
  final Cart cart;
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> paymentIntentData;

  BuildContext context;
  CheckOut({
    Key key,
    this.cart,
    this.product,
    this.productmod,
  }) : super(key: key);

  CollectionReference _basketCollection =
      FirebaseFirestore.instance.collection("Basket");

  @override
  Widget build(BuildContext context) {
    return Container(
      key: formKey,
      //height: 174,
      //  color: Colors.blue,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              Consumer<CartProvider>(builder: (context, provider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(text: "Total:\n", children: [
                        TextSpan(
                            // onEnter: (Product product) {
                            //   myCart.product = product;
                            // };
                            text: "\$ ${provider.getTotalPrice()}",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ]),
                    ),
                    Consumer<CartProvider>(builder: (context, provider, child) {
                      return SizedBox(
                          width: 190,
                          height: 50,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              primary: Colors.white,
                              backgroundColor: Colors.orange,
                            ),
                            onPressed: () async {
                              List proN = [];
                              provider.items.forEach((element) async {
                                // proN.add(element.productName);
                                proN.addAll([element.productName, element.qty]);
                              });

                              try {
                                // final res = await _basketCollection
                                //     .doc('basket${provider.documentindex()}')
                                //     .set(
                                //   {
                                //     "Username": auth.currentUser.email,
                                //     "Total price": provider.getTotalPrice(),
                                //     "Product name": proN,
                                //   },
                                //   SetOptions(merge: true),
                                // );

                                // await makePayment(provider.getTotalPrice());

                                print(proN);
                                print(provider.checkstock());

                                Navigator.pop(context);
                              } catch (err) {
                                print('!!!!' + err);
                              }
                            },
                            child: Text("Check out"),
                          ));
                    }),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment(double totalprice) async {
    FirebaseAuth authm = FirebaseAuth.instance;
    try {
      var price = totalprice.toString();
      paymentIntentData = await createPaymentIntent(price, 'THB');
      print('???/' + paymentIntentData.toString());
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData["client_secret"],
              applePay: true,
              googlePay: true,
              testEnv: false,
              style: ThemeMode.dark,
              merchantCountryCode: 'TH',
              merchantDisplayName: '${authm.currentUser.email}'));

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
    String amt = double.parse(amount).toInt().toString();
    print('MMMMMMMMMM' + amt);
    print('MMMMMMMMMM' + currency);
    FirebaseAuth authen = FirebaseAuth.instance;
    String emailuser = authen.currentUser.email.toString();

    try {
      var headersList = {
        'Accept': '*/*',
        'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
        'Authorization':
            'Bearer sk_test_51KmBZIDp0AbO0nPgVTDGgQXtJTxoomUyRw5PKyI8Arxmmw63Pkg7MhvAcTWaf49OEAcGRXxpJizae5anZ9kCpW2400P7vgKyVd',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var url = Uri.parse('https://api.stripe.com/v1/payment_intents');

      var body = {
        'amount': calculateAmount(amt),
        'currency': currency,
        'payment_method_types[]': 'card',
        'description': emailuser
      };
      var req = http.Request('POST', url);
      req.headers.addAll(headersList);
      req.bodyFields = body;

      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(resBody);
        return jsonDecode(resBody);
      } else {
        print(res.reasonPhrase);
      }
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  String calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
