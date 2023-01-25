// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../shared/menu_bottom.dart';
import '../shared/menu_drawer.dart';

class NewEntry extends StatefulWidget {
  const NewEntry({super.key});

  @override
  State<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final _userID = FirebaseAuth.instance.currentUser?.uid;

  File? _image;
  final ImagePicker _picker = ImagePicker();
  final _receiptNumber = TextEditingController();
  int counter = 0;

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_image == null) return;
    final fileName = basename(_image!.path);
    final destination = 'files/USER-$_userID/$fileName';

    final imageName = basename(_image!.path).toString();
    final receiptNumber = _receiptNumber.text.toString().trim();
    final uploadTime = DateTime.now();

    try {
      Map<String, Object> receipt = {
        'imageName': imageName,
        'receiptNumber': receiptNumber,
        'uploadTime': uploadTime,
      };
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      final db = FirebaseFirestore.instance;
      await db.collection('users').doc(_userID).collection("receipts").add(
            receipt,
          );
      await ref.putFile(_image!);
    } catch (e) {
      print('error occured');
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

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
                height: 50,
              ),
              _image == null
                  ? Image.asset(
                      "assets/images/placeholder.png",
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      _image!,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: const Offset(1, 1),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ]),
                child: TextField(
                  controller: _receiptNumber,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: "Receipt number",
                    prefixIcon: const Icon(Icons.receipt_long),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  customButton(
                    title: "Pick an image",
                    icon: Icons.image_outlined,
                    onClick: () => _showPicker(context),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  customButton(
                    title: "Clear image",
                    icon: Icons.clear,
                    onClick: () => setState(() {
                      _image = null;
                      print(_image);
                    }),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              customButton(
                  title: "Submit",
                  icon: Icons.arrow_upward,
                  onClick: () {
                    uploadFile();
                    setState(() {
                      counter++;
                    });
                  }),
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
  return Container(
    margin: const EdgeInsets.only(left: 10),
    width: 170,
    child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 10,
            ),
            Text(title),
          ],
        )),
  );
}
