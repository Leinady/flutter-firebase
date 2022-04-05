import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({Key key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('Basket').snapshots();

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Invoice page'),
          backgroundColor: Colors.black,
          elevation: 1,
        ),
        body: Container(
            // padding:
            //     const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            final data = snapshot.requireData;

            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.arrow_forward_ios),
                          title: Text("${data.docs[index]['Username']}"),
                          subtitle:
                              Text("Price: ${data.docs[index]['Total price']}" +
                                  " "
                                      "Product name: ${data.docs[index]['Product name']}"),
                        ),
                      ],
                    ),
                  );
                });
          },
        )));
  }
}
