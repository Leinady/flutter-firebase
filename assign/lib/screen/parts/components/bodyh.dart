import 'dart:io';
import 'package:assign/models/Product.dart';
import 'package:assign/screen/detail/detail_screen.dart';
import 'package:assign/screen/home/components/categories.dart';
import 'package:assign/screen/home/components/items_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../provider/ItemProvider.dart';

class BodyH extends StatefulWidget {
  final Product product;
  File newFiles;

  BodyH({Key key, this.product}) : super(key: key);
  @override
  State<BodyH> createState() => _BodyHState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _BodyHState extends State<BodyH> {
  bool abletoedit = false;
  Color color = Colors.amber;
  TextEditingController addtitleController = TextEditingController();
  TextEditingController addpriceController = TextEditingController();
  TextEditingController adddesController = TextEditingController();
  TextEditingController addsizeController = TextEditingController();
  TextEditingController adddbsController = TextEditingController();
  TextEditingController addcolorController = TextEditingController();
  TextEditingController addidController = TextEditingController();
  final add = TextEditingValue();
  @override
  Widget build(BuildContext context) {
    if (auth.currentUser.uid == 'vkUov6GLXoSe2HmWicQShB5mRmH3') {
      abletoedit = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Garage Tuning",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            abletoedit
                ? Consumer<ItemProvider>(builder: (context, provider, child) {
                    return IconButton(
                      onPressed: () {
                        editproduct(widget.product);
                        // provider.addproduct(widget.product);
                      },
                      icon: Icon(Icons.add_box),
                      color: Colors.black,
                    );
                  })
                : SizedBox(),
          ],
        ),
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: GridView.builder(
              itemCount: productex.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20),
              itemBuilder: (context, index) => ItemCard(
                product: productex[index],
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                              product: productex[index],
                            ))),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget builcolor() => ColorPicker(
      pickerColor: color,
      enableAlpha: false,
      onColorChanged: (color) => setState(() => this.color = color));

  Future editproduct(Product product) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Color.fromARGB(255, 187, 251, 240),
              title: Text('Add Product'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: addidController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'category cannot be empty';
                        }
                      },
                      decoration: InputDecoration(hintText: 'Product id'),
                    ),
                    TextFormField(
                      controller: addtitleController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'category cannot be empty';
                        }
                      },
                      decoration: InputDecoration(hintText: 'Product name'),
                    ),
                    TextFormField(
                      controller: addpriceController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'category cannot be empty';
                        }
                      },
                      decoration: InputDecoration(hintText: 'Product price'),
                    ),
                    TextFormField(
                      controller: adddbsController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'category cannot be empty';
                        }
                      },
                      decoration: InputDecoration(hintText: 'Product in stock'),
                    ),
                    TextFormField(
                      controller: addsizeController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'category cannot be empty';
                        }
                      },
                      decoration: InputDecoration(hintText: 'Product size'),
                    ),
                    TextFormField(
                      controller: adddesController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'category cannot be empty';
                        }
                      },
                      decoration:
                          InputDecoration(hintText: 'Product desrciption'),
                    ),
                    builcolor(),
                  ],
                ),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();
                    if (result == null) {
                      print(result);
                    }
                    final file = result.files.first;
                    print('Name:${file.name}');
                    print('Path:${file.path}');

                    widget.newFiles = await savefilePermanantly(file);
                    print('Form Path: ${file.path}');
                    print('To Path: ${widget.newFiles.path}');
                  },
                  icon: Icon(Icons.file_download),
                ),
                Consumer<Product>(builder: (context, provider, child) {
                  return ElevatedButton(
                      onPressed: () {
                        print(adddesController.text);
                        print(addidController.text);
                        try {
                          print(addtitleController.text);
                          String title = addtitleController.text;
                          String description = adddesController.text;
                          int id = int.parse(addidController.text);
                          var price = int.parse(addpriceController.text);
                          var dbs = int.parse(adddbsController.text);
                          var size = int.parse(addsizeController.text);
                          color = color;
                          //Object cubic = widget.newFiles.path;
                          provider.addproductwheel(Product(
                              id: id,
                              dbs: dbs,
                              title: title,
                              price: price,
                              description: description,
                              size: size,
                              color: color,
                              cubic: 'assets/cude/wheel4.gltf'));
                        } on FormatException {
                          print('Format err');
                        }

                        Fluttertoast.showToast(msg: 'product created');
                        Navigator.pop(context);
                      },
                      child: Text('ADD'));
                }),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('CANCEL')),
              ],
            ));
  }

  Future<File> savefilePermanantly(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path).copy(newFile.path);
  }
}
