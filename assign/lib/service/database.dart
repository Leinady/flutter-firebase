import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference devilCollect =
      FirebaseFirestore.instance.collection("Devil");

  final CollectionReference WheelCollect = 
      FirebaseFirestore.instance.collection("Wheel");

  Future updateUserData(String name, int number) async {
    return await devilCollect.doc(uid).set({
      'names': name,
      'number': number,
    });
  }
}
