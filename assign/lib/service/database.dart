import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // final CollectionReference users =
  //     FirebaseFirestore.instance.collection("Users");

  final CollectionReference WheelCollect =
      FirebaseFirestore.instance.collection("Wheel");

  Future updateUserData(String email) async {
    // return await users.add({
    //   'email': email,
    // });
  }
}
