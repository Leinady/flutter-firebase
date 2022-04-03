import 'package:assign/LocalPage.dart';
import 'package:assign/actions/action_auth.dart';
import 'package:assign/screen/authen/register.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();




  initAction() async {
    ActionAuth.checkAuth(context);
  }

  @override
  void initState() {
    initAction();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        elevation: 1,
        title: Text('Sign in'),
        actions: <Widget>[
          TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
              },
              icon: Icon(Icons.add_circle_outline),
              label: Text('Register'))
        ],
      ),

      // assets/images/Tuning Garage.png
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image.asset("assets/images/Tuning Garage.png"),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Spacer(
                      flex: 3,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'email empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          filled: true, fillColor: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'pass empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          filled: true, fillColor: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                             await ActionAuth.login(
                               context,
                                email: emailController.text,
                                password: passwordController.text);    
                                
                                
                          }
                        },
                        child: Text("Sign Ins")),
                    Spacer(
                      flex: 10,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
