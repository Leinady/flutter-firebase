import 'package:assign/models/Product.dart';
import 'package:assign/service/firebase_api.dart';
import 'package:assign/service/firebasefile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_cube/flutter_cube.dart';
import 'package:model_viewer/model_viewer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../service/storage_service.dart';

class ItemCardFirestorage extends StatefulWidget {
  final Product product;
  final Function press;

  ItemCardFirestorage({
    Key key,
    this.product,
    this.press,
    gridDelegate,
  }) : super(key: key);

  @override
  State<ItemCardFirestorage> createState() => _ItemCardFirestorageState();
}

class _ItemCardFirestorageState extends State<ItemCardFirestorage> {
  final Storage storage = Storage();
  bool ableToEdit = false;
  Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureFiles = FirebaseApi.listAll('Product/Exhaust/');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder<List<FirebaseFile>>(
              future: futureFiles,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());

                  default:
                    if (snapshot.hasError) {
                      return Center(child: Text('Some error occurred!'));
                    } else {
                      final files = snapshot.data;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.amber,
                          height: 50,
                          child: ListView.builder(
                            itemCount: files.length,
                            itemBuilder: (context, index) {
                              final file = files[index];
                              print(file.ref.fullPath);

                              var headersList = {
                                'Accept': '*/*',
                                'User-Agent':
                                    'Thunder Client (https://www.thunderclient.com)',
                                "source": "**/*.@(jpg|jpeg|gif|png|gltf)",
                                "key": "Access-Control-Allow-Origin",
                                "value": "*"
                              };
                              var url = Uri.parse(
                                  'https://firebasestorage.googleapis.com/v0/b/flutter-firebase-49d31.appspot.com/o/Product%2FExhaust%2Ftoba.gltf?alt=media&token=8d48a71e-b2db-497c-8228-1d5f2d52154b');

                              var req = http.Request('POST', url);
                              req.headers.addAll(headersList);

                              // var res = await req.send();
                              // final resBody = await res.stream.bytesToString();

                              // if (res.statusCode >= 200 && res.statusCode < 300) {
                              //   print(resBody);
                              // }
                              // else {
                              //   print(res.reasonPhrase);
                              // }
                              return Container(
                                height: 160,
                                width: 140,
                                decoration: BoxDecoration(
                                    color: widget.product.color,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ModelViewer(
                                  src: file.url,
                                  backgroundColor: widget.product.color,
                                  ar: false,
                                  autoRotate: true,
                                  cameraControls: true,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                }
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              widget.product.title,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Text(
              '${widget.product.price} \$',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
