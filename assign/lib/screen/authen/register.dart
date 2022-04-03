import 'package:assign/actions/action_auth.dart';
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
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        elevation: 0.0,
        title: Text('Sign up to my project'),
      ),
      body: Column(
        children: [
          Container(
            child: Text('Register'),
          ),
          Flexible(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Error';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Error';
                        }
                        if (value.length < 6) {
                          return 'password must 1-6 char';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Error';
                        }
                        if (value != _passwordController.text) {
                          return 'password not match';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 20),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => Dialog(
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          child: Column(
                                            children: [
                                              Spacer(),
                                              CircularProgressIndicator(),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text('Loading'),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                      ));

                              final res =
                                  await ActionAuth.registerWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      role: 'user');
                              if (res == true) {
                                Navigator.pop(context); // pop dialog
                                Navigator.pop(context); // pop register page
                              } else {
                                print(res);
                              }
                            }
                          },
                          child: Text('Register')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
