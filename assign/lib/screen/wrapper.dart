import 'package:assign/screen/authen/authenticate.dart';
import 'package:assign/screen/authen/sign_in.dart';
import 'package:assign/screen/home/home.dart';
import 'package:flutter/material.dart';

class wrapper extends StatelessWidget {
  const wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
