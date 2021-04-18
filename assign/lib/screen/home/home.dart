import 'package:assign/service/authserv.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  //const home({Key key}) : super(key: key);

  final Authservice _auth = Authservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text('Home page'),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('log out'))
          ],
        ));
  }
}
