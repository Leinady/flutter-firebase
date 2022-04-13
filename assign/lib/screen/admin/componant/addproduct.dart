import 'package:assign/service/firebase_api.dart';
import 'package:assign/service/firebasefile.dart';
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
      body: Column(children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Product in database',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
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

                    return Container(
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];

                            return buildFile(context, file);
                          },
                        ),
                      ),
                    );
                  }
              }
            })
      ]),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) {}
  // => ListTile(
  //       leading: Image.network(
  //         file.url,
  //         width: 52,
  //         height: 52,
  //         fit: BoxFit.cover,
  //       ),

  //               ModelViewer(
  //         src: file.url,
  //         backgroundColor: Colors.white,
  //         ar: false,
  //         autoRotate: false,
  //         cameraControls: true,
  //       )
  //     );

}
