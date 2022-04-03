import 'package:assign/actions/action_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPage extends StatefulWidget {
  LocalPage({Key key}) : super(key: key);

  @override
  State<LocalPage> createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {


  getLocal() async {
   SharedPreferences localStorage = await SharedPreferences.getInstance();
   print(localStorage.getString('email'));
  }
  @override
  void initState() {
    // TODO: implement initState
    getLocal();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(children: [
        ElevatedButton(onPressed: (){
          ActionAuth.logout(context);
          
        }, child: Text('Logout'))
      ],),
    );
  }
}