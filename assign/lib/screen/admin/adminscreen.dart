import 'package:assign/service/authserv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'createusers.dart';
import 'editusers.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController emailController = new TextEditingController();

  String email = " ";
  String uid = " ";
  String role = " ";
  String password = " ";

  bool ableToEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text('Admin page'),
          backgroundColor: Colors.black,
          elevation: 1,
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.data_saver_on),
                color: Colors.white),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome Admin"),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            GestureDetector(
              onTap: () async {
                String userEmail = emailController.text.trim();

                final QuerySnapshot snap = await FirebaseFirestore.instance
                    .collection('user')
                    .where('email', isEqualTo: userEmail)
                    .get();
                setState(() {
                  email = userEmail;
                  uid = snap.docs[0]['uid'];
                  role = snap.docs[0]['role'];
                  password = snap.docs[0]['password'];

                  ableToEdit = true;
                });
              },
              child: Container(
                height: 50,
                width: 100,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "Get User Data",
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            ableToEdit
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditUser(
                                    uid: uid,
                                  )));
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          "Edit User",
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateUser()));
              },
              child: Container(
                height: 50,
                width: 100,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "Create User",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text('User Data :'),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Email : ' + email),
                  Text('UID : ' + uid),
                  Text('Role : ' + role),
                  Text('Password : ' + password),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
