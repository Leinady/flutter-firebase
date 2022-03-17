import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'proflieform.dart';

class Bodyprof extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            auth.currentUser.email,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
