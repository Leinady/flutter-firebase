import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePic extends StatelessWidget {
  File newFiles;
  ProfilePic({
    Key key,
    this.newFiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            //  backgroundImage: AssetImage(newFiles.path),
            backgroundColor: Color.fromARGB(255, 255, 152, 68),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Colors.white),
                    ),
                    primary: Colors.white,
                    backgroundColor: Color(0xFFF5F6F9),
                  ),
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();
                    if (result == null) {
                      print(result);
                    }
                    final file = result.files.first;
                    print('Name:${file.name}');
                    print('Path:${file.path}');

                    newFiles = await savefilePermanantly(file);
                    print('Form Path: ${file.path}');
                    print('To Path: ${newFiles.path}');
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  )),
            ),
          )
        ],
      ),
    );
  }

  Future<File> savefilePermanantly(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path).copy(newFile.path);
  }
}
