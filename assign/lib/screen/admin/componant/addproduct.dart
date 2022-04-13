import 'package:assign/service/firebase_api.dart';
import 'package:assign/service/firebasefile.dart';
import 'package:assign/service/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:model_viewer/model_viewer.dart';

class AddproductScreen extends StatefulWidget {
  AddproductScreen({Key key}) : super(key: key);

  @override
  State<AddproductScreen> createState() => _AddproductScreenState();
}

class _AddproductScreenState extends State<AddproductScreen> {
  Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureFiles = FirebaseApi.listAll('Product/');
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: Text('Addproduct page'),
        backgroundColor: Colors.black,
        elevation: 1,
      ),
      body: Container(
        child: Column(children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Product in Exhaust',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
          FutureBuilder(
              future: storage.listFileExhaust(),
              builder: (BuildContext context,
                  AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      color: Colors.amber,
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data.items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(snapshot.data.items[index].name),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container();
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Product in Wheel',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
          FutureBuilder(
              future: storage.listFileWheel(),
              builder: (BuildContext context,
                  AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      color: Colors.amber,
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data.items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(snapshot.data.items[index].name),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container();
              }),
          Container(
            height: 200,
            width: 200,
            child: FutureBuilder<List<FirebaseFile>>(
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
                                return buildFile(context, file);
                              },
                            ),
                          ),
                        );
                      }
                  }
                }),
          )
        ]),
      ),
      bottomNavigationBar: bottomUpload(),
    );
  }

  Container bottomUpload() {
    final Storage storage = Storage();
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 28, 29, 28),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ]),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SafeArea(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 190,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['gltf', 'png']);
                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No file')),
                      );
                      return null;
                    }
                    final path = result.files.single.path;
                    final fileName = result.files.single.name;

                    storage
                        .uploadFile(path, fileName)
                        .then((value) => print('Done'));
                  },
                  child: Text('Upload file'),
                ),
              ),
            ],
          ))),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) {
    return Container(
        height: 160,
        width: 140,
        child: Image.network(
          file.url,
          width: 52,
          height: 52,
          fit: BoxFit.cover,
        )
        //     ModelViewer(
        //   src: file.url,
        //   backgroundColor: Color.fromARGB(255, 0, 0, 0),
        //   ar: false,
        //   autoRotate: false,
        //   cameraControls: true,
        // ),
        );
  }
}
