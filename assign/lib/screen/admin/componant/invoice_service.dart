import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  CollectionReference users = FirebaseFirestore.instance.collection('Basket');
  void createCategory(dynamic price) {
    String documentId = '';

    users
        .doc()
        .update({'Total price': price})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
