import 'package:assign/actions/action_auth.dart';
import 'package:assign/screen/admin/editusers.dart';
import 'package:assign/screen/proflie/componants/contact.dart';
import 'package:assign/screen/proflie/componants/profile_picture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../service/authserv.dart';
import 'proflieform.dart';

class Bodyprof extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final Authservice _auth = Authservice();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: auth.currentUser.email,
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => EditUser()))
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactScreen()))
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              ActionAuth.logout(context);
            },
          ),
        ],
      ),
    );
  }
}
