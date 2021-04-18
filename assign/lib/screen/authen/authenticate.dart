import 'package:assign/screen/authen/register.dart';
import 'package:assign/screen/authen/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignIn = true;
  void toggleview() {
    setState(() => showsignIn = !showsignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showsignIn) {
      return SignIn(toggle: toggleview);
    } else {
      return Register(toggle: toggleview);
    }
  }
}
