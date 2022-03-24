import 'package:assign/screen/authen/sign_in.dart';
import 'package:assign/service/authserv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  //Register({Key key}) : super(key: key);

  final Function toggle;
  Register({this.toggle});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  String role = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        elevation: 0.0,
        title: Text('Sign up to my project'),
        actions: <Widget>[
          TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () {
                widget.toggle();
              },
              icon: Icon(Icons.add_circle_outline),
              label: Text('Sign In'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            SizedBox(
              height: 20,
            ),
            TextFieldContainer(
              child: TextFormField(
                decoration: InputDecoration(border: InputBorder.none),
                validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldContainer(
              child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(border: InputBorder.none),
                  validator: (val) =>
                      val.length < 6 ? 'Enter a password 6+' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pink[200],
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  dynamic result = await _auth.registerWithEmailAndPassword(
                      email, password, role);
                  // User user = FirebaseAuth.instance.currentUser;

                  // await FirebaseFirestore.instance
                  //     .collection("users")
                  //     .doc(user.uid)
                  //     .set({
                  //   'uid': user.uid,
                  //   'email': email,
                  //   'password': password,
                  //   'role': 'user',
                  // });
                  if (result == null) {
                    setState(() => error = 'please put email');
                  }
                }
              },
              child: Text('Sign up'),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 15),
            )
          ]),
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(29)),
      child: child,
    );
  }
}
