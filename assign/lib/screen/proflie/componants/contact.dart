import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextStyle _txtField =
      new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);
  TextEditingController addnameController = TextEditingController();
  TextEditingController addemailController = TextEditingController();
  TextEditingController addsubjectController = TextEditingController();
  TextEditingController addmessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String name = addnameController.text;
    String email = addemailController.text;
    String subject = addsubjectController.text;
    String message = addmessageController.text;
    return Scaffold(
        appBar: AppBar(
          title: Text('Contact us'),
          backgroundColor: Color.fromARGB(255, 252, 142, 69),
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Email",
                              style: this._txtField,
                            )),
                        TextField(
                          controller: addemailController,
                          decoration: InputDecoration(
                              hintText: "Your email",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "First Name",
                              style: this._txtField,
                            )),
                        TextField(
                          controller: addnameController,
                          decoration: InputDecoration(
                              hintText: "Your first name",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Subject",
                              style: this._txtField,
                            )),
                        TextField(
                          controller: addsubjectController,
                          decoration: InputDecoration(
                              hintText: "Your subject",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Message",
                              style: this._txtField,
                            )),
                        TextField(
                          controller: addmessageController,
                          minLines: 10,
                          maxLines: 100,
                          decoration: InputDecoration(
                              hintText: "Write something...",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ],
                    )),
                ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    sendEmail(
                        name: name,
                        email: email,
                        subject: subject,
                        message: message);
                    Fluttertoast.showToast(msg: 'success');
                  },
                )
              ],
            ),
          ),
        ));
  }

  Future sendEmail({
    String name,
    String email,
    String subject,
    String message,
  }) async {
    final serviceId = 'service_evlzmtp';
    final templateId = 'template_u3a4zy1';
    final userId = 'yZSwP351W1u5ESfls';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_subject': subject,
            'user_message': message,
          }
        }));
    print(response);
  }
}
