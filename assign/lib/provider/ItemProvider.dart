import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier {
  int itemCount = 0;

  ItemProvider();

  final a = FirebaseFirestore.instance
      .collection('user')
      .doc('email')
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Text('${documentSnapshot.data()}');
    }
  });

  alluser() {
    a.toString();
    notifyListeners();
  }
}
