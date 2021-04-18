import 'package:assign/service/authserv.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //SignIn({Key key}) : super(key: key);

  final Function toggle;
  SignIn({this.toggle});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in'),
        actions: <Widget>[
          TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.black),
              onPressed: () {
                widget.toggle();
              },
              icon: Icon(Icons.add_circle_outline),
              label: Text('Register'))
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
            TextFormField(
              validator: (val) => val.isEmpty ? 'Enter an Email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                obscureText: true,
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+' : null,
                onChanged: (val) {
                  setState(() => password = val);
                }),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pink[200],
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() => error = 'please put email');
                  }
                }
              },
              child: Text('Sign In'),
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
