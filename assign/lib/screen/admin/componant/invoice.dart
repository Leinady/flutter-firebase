import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'invoice_service.dart';

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({Key key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('Basket').snapshots();
CollectionReference basket = FirebaseFirestore.instance.collection('Basket');
CategoryService _categoryService = CategoryService();
TextEditingController categoryController = TextEditingController();
TextEditingController brandController = TextEditingController();
GlobalKey<FormState> _categoryFormKey = GlobalKey();

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
                        Dismissible(
                          key: Key(data.docs[index].toString()),
                          direction: DismissDirection.startToEnd,
                          child: ListTile(
                              leading: Icon(Icons.arrow_forward_ios),
                              title: Text("${data.docs[index]['Username']}"),
                              subtitle: Text(
                                  "Price: ${data.docs[index]['Total price']}" +
                                      "\n" +
                                      "Product: ${data.docs[index]['Product name']}"),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit),
                              )),
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              basket
                                  .doc()
                                  .delete()
                                  .then((value) => print("Invoice Deleted"))
                                  .catchError((error) =>
                                      print("Failed to delete user: $error"));
                            });
                          },
                        ),
                      ],
                    ),
                  );
                });
          },
        )));
  }

  // void _categoryAlert() {
  //   var alert = new AlertDialog(
  //     content: Form(
  //       key: _categoryFormKey,
  //       child: TextFormField(
  //         controller: categoryController,
  //         validator: (value) {
  //           if (value.isEmpty) {
  //             return 'category cannot be empty';
  //           }
  //         },
  //         decoration: InputDecoration(hintText: "Change Price"),
  //       ),
  //     ),
  //     actions: <Widget>[
  //       ElevatedButton(
  //           onPressed: () {
  //             if (categoryController.text != null) {
  //               _categoryService.createCategory(categoryController.text);
  //             }
  //             Fluttertoast.showToast(msg: 'edit change');
  //             Navigator.pop(context);
  //           },
  //           child: Text('ADD')),
  //       ElevatedButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: Text('CANCEL')),
  //     ],
  //   );

  //   showDialog(context: context, builder: (_) => alert);
  // }
}
