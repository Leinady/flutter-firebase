import 'dart:math';

import 'package:assign/actions/action_auth.dart';
import 'package:assign/provider/ItemProvider.dart';
import 'package:assign/screen/admin/adminscreen.dart';
import 'package:assign/screen/admin/componant/addproduct.dart';
import 'package:assign/screen/admin/componant/invoice.dart';
import 'package:assign/screen/authen/sign_in.dart';
import 'package:assign/screen/home/home.dart';
import 'package:assign/service/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../service/authserv.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  FirebaseStorage firebasestorage = FirebaseStorage.instance;
  // BrandService _brandService = BrandService();
  // CategoryService _categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                            _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Manage'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    final Storage storage = Storage();
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            Consumer<ItemProvider>(builder: (context, provider, child) {
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Basket')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    double total = 0.0;
                    for (int i = 0; i < snapshot.data.size; i++) {
                      total += snapshot.data.docs[i]['Total price'];
                    }

                    print(total);
                    return ListTile(
                      subtitle: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 243, 243, 243))),
                        onPressed: null,
                        icon: Icon(
                          Icons.attach_money,
                          size: 30.0,
                          color: Colors.green,
                        ),
                        label: Text(total.toString(),
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.green)),
                      ),
                      title: Text(
                        'Revenue',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24.0, color: Colors.grey),
                      ),
                    );
                  });
            }),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('user')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return Card(
                            child: Consumer<ItemProvider>(
                                builder: (context, provider, child) {
                              return ListTile(
                                  title: ElevatedButton.icon(
                                      onPressed: null,
                                      icon: Icon(Icons.people_outline),
                                      label: Text("Users")),
                                  subtitle: Text(
                                    '${snapshot.data.size}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: active, fontSize: 60.0),
                                  ));
                            }),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: ElevatedButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.category),
                              label: Text("Categories")),
                          subtitle: Text(
                            '5',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                          title: ElevatedButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.track_changes),
                              label: Text("Producs")),
                          subtitle: Text(
                            '5',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(22.0),
                  //   child: Card(
                  //     child: ListTile(
                  //         title: FlatButton.icon(
                  //             onPressed: null,
                  //             icon: Icon(Icons.tag_faces),
                  //             label: Text("Sold")),
                  //         subtitle: Text(
                  //           '13',
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(color: active, fontSize: 60.0),
                  //         )),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Basket')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Card(
                            child: ListTile(
                                title: ElevatedButton.icon(
                                    onPressed: null,
                                    icon: Icon(Icons.shopping_cart),
                                    label: Text("Orders")),
                                subtitle: Text(
                                  '${snapshot.data.size}',
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(color: active, fontSize: 60.0),
                                )),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        );

        break;

      case Page.manage:
        return ListView(
          children: <Widget>[
            Divider(),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add product"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddproductScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text("Edit users"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminScreen()));
              },
            ),
            Divider(),
            Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Invoices"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InvoiceScreen()));
              },
            ),
            Divider(),
            Divider(),
            ListTile(
              leading: Icon(Icons.remove_red_eye),
              title: Text("User view"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log out"),
              onTap: () async {
                ActionAuth.logout(context);
              },
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _categoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value) {
            if (value.isEmpty) {
              return 'category cannot be empty';
            }
          },
          decoration: InputDecoration(hintText: "add category"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              // if(categoryController.text != null){
              //   _categoryService.createCategory(categoryController.text);
              // }
              Fluttertoast.showToast(msg: 'category created');
              Navigator.pop(context);
            },
            child: Text('ADD')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void _brandAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value) {
            if (value.isEmpty) {
              return 'category cannot be empty';
            }
          },
          decoration: InputDecoration(hintText: "add brand"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              // if(brandController.text != null){
              //   _brandService.createBrand(brandController.text);
              // }
              Fluttertoast.showToast(msg: 'brand added');
              Navigator.pop(context);
            },
            child: Text('ADD')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }
}
