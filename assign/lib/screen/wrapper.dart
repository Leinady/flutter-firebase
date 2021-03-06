import 'package:assign/models/user.dart';
import 'package:assign/screen/admin/adminscreen.dart';
import 'package:assign/screen/admin/dashbord.dart';
import 'package:assign/screen/admin/splashscreen.dart';
import 'package:assign/screen/authen/authenticate.dart';
import 'package:assign/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomClassName>(context);
    if (user == null) {
      return Authenticate();
    } else if (user.uid == 'vkUov6GLXoSe2HmWicQShB5mRmH3') {
      // return AdminScreen();
      return Admin();
    } else {
      return Home();
    }
  }
}
