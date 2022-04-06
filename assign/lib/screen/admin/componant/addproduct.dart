import 'package:assign/service/storage_service.dart';
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
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: Text('Addproduct page'),
        backgroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(children: [
        Center(
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

              storage.uploadFile(path, fileName).then((value) => print('Done'));
            },
            child: Text('Upload file'),
          ),
        ),
        FutureBuilder(
            future: storage.listFile(),
            builder: (BuildContext context,
                AsyncSnapshot<firebase_storage.ListResult> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
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
        FutureBuilder(
            future: storage.downloadURL('wheel1.jpg'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                    width: 300,
                    height: 250,
                    child: Image.network(
                      snapshot.data,
                      fit: BoxFit.cover,
                    )
                    // ModelViewer(
                    //   src: snapshot.data,
                    // ),
                    );
              }
              if (snapshot.connectionState == ConnectionState.waiting &&
                  !snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Container();
            })
      ]),
    );
  }
}
