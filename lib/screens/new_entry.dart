import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart';

import '../shared/menu_bottom.dart';
import '../shared/menu_drawer.dart';

class NewEntry extends StatefulWidget {
  const NewEntry({super.key});

  @override
  State<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  File? _image;

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;
      final imageTemporary = File(image.path);
      // final imagePermanent = await saveFilePermanently(image.path);

      setState(() {
        // ignore: unnecessary_this
        this._image = imageTemporary;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Failed to pick image: $e");
    }
  }
  // How to save an image to a directory
  // Future<File> saveFilePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${directory.path}/$name');

  //   return File(imagePath).copy(image.path);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Row(
            children: [
              Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.contain,
                height: 48,
              ),
              const SizedBox(
                width: 40,
              ),
              const Text(
                "New Entry",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          )),
      bottomNavigationBar: const MenuBottom(),
      drawer: const MenuDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 70,
              ),
              _image != null
                  ? Image.file(
                      _image!,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "https://archive.org/download/placeholder-image/placeholder-image.jpg"),
              const SizedBox(
                height: 100,
              ),
              customButton(
                title: "Pick from Gallery",
                icon: Icons.image_outlined,
                onClick: () => getImage(ImageSource.gallery),
              ),
              customButton(
                title: "Pick from Camera",
                icon: Icons.camera,
                onClick: () => getImage(ImageSource.camera),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return SizedBox(
    width: 280,
    child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 40,
            ),
            Text(title),
          ],
        )),
  );
}
