import 'package:assign/models/user.dart';
import 'package:assign/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //User obj
  CustomClassName _userFromFirebase(User user) {
    return user != null ? CustomClassName(uid: user.uid) : null;
  }

  //auth chage user stream
  Stream<CustomClassName> get user {
    return _auth.authStateChanges().map((User user) => _userFromFirebase(user));
  }

  //sign on anonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register in with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String role) async {
    try {
      UserCredential result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          // ignore: missing_return
          .then((value) {
        User user = FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance.collection('user').doc(user.uid).set({
          'uid': user.uid,
          "email": email,
          'password': password,
          'role': role,
        });
      });
      User user = result.user;

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
