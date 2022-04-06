import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier {
  ItemProvider();

  totalprice() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var a = (doc["first_name"]);
      });
    });

    notifyListeners();
  }
}
