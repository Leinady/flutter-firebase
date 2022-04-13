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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'All User in data',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.size,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        final QuerySnapshot snap =
                            await FirebaseFirestore.instance
                                .collection('user')
                                // .where('email')
                                .get();
                        setState(() {
                          email = snap.docs[index]['email'];
                          uid = snap.docs[index]['uid'];
                          // role = snap.docs[index]['role'];
                          // password = snap.docs[index]['password'];

                          ableToEdit = true;
                        });
                      },
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text("${snapshot.data.docs[index]['email']}"),
                        subtitle: Text("${snapshot.data.docs[index]['uid']}"),
                      ),
                    );
                  },
                );
              },
            ),
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
                : SizedBox(
                    height: 10,
                  ),
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                height: 10,
              ),
              Text('Email : ' + email),
              // Text('UID : ' + uid),
              // Text('Role : ' + role),
              // Text('Password : ' + password),
            ]),
          ],
        ),
      ),
    );
  }
}
