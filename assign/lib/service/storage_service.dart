import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    try {
      await storage.ref('Product/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFileExhaust() async {
    firebase_storage.ListResult result =
        await storage.ref('Product/Exhaust/').listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });
    return result;
  }

  Future<firebase_storage.ListResult> listFileWing() async {
    firebase_storage.ListResult result =
        await storage.ref('Product/Wing/').listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });
    return result;
  }

  Future<firebase_storage.ListResult> listFileWheel() async {
    firebase_storage.ListResult result =
        await storage.ref('Product/Wheel/').listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });
    return result;
  }

  Future<String> downloadURLexhaust(String Name) async {
    String downloadURL =
        await storage.ref('Product/Exhaust/$Name').getDownloadURL();

    return downloadURL;
  }

  Future<String> downloadURL(String Name) async {
    String downloadURL = await storage.ref('Product/$Name').getDownloadURL();

    return downloadURL;
  }
}
