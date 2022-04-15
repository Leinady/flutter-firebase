import 'package:assign/models/Product.dart';
import 'package:assign/models/user.dart';
import 'package:assign/provider/ItemProvider.dart';
import 'package:assign/route/cartprovider.dart';
import 'package:assign/screen/authen/sign_in.dart';
import 'package:assign/service/authserv.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51KmBZIDp0AbO0nPgCi4Tlz3XVNGkVWfELSOnjDkZC7XThuI5XIQobUL8QXQpav0wg5fiuoQaniPYUIrzw0Zh4JqR00kBf9buFS';
  //Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomClassName>.value(
      value: Authservice().user,
      initialData: null,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CartProvider(),
          ),
          ChangeNotifierProvider(create: (_) => ItemProvider()),
          ChangeNotifierProvider(create: (_) => Product())
        ],
        child: MaterialApp(
          home: SignIn(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
