// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../shared/menu_bottom.dart';
// import '../shared/menu_drawer.dart';

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
  var rcpNmbr;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    if (_image == null) {
      return;
    }

    final fileName = basename(_image!.path);
    final destination = 'files/USER-$_userID/receipts/$fileName';

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
        title: const Center(
          child: Text(
            "New Entry",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const MenuBottom(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: Center(
          child: Column(
            children: [
              Container(
                height: 50,
              ),
              _image == null
                  ? Stack(children: [
                      Image.asset(
                        "assets/images/placeholder.png",
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          right: -9,
                          bottom: -9,
                          child: GestureDetector(
                              child: const Icon(
                                Icons.add_box,
                                color: Colors.redAccent,
                                size: 60,
                              ),
                              onTap: () {
                                _showPicker(context);
                              })),
                    ])
                  : Stack(children: [
                      Image.file(
                        _image!,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                              child: const Icon(
                                Icons.highlight_remove_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                              onTap: () {
                                setState(() {
                                  _image = null;
                                });
                              })),
                    ]),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    maxLength: 13,
                    controller: _receiptNumber,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        backgroundColor: Colors.white),
                    onChanged: (value) {
                      _formKey.currentState?.validate();
                      setState(() {
                        rcpNmbr = _receiptNumber.text.trim();
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a valid receipt";
                      } else if (value.length < 13) {
                        return "Receipt should be 13 characters long";
                      } else if (value.contains(" ")) {
                        return "Cannot contain any whitespace";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Receipt number",
                      prefixIcon: const Icon(Icons.receipt_long),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Colors.redAccent, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              customButton(
                  color: Colors.red,
                  title: "Submit",
                  icon: Icons.arrow_upward,
                  onClick: (_image == null || rcpNmbr.toString().length < 13)
                      ? null
                      : () {
                          uploadFile();
                          // setState(() {
                          //   _image = null;
                          // });

                          const snackBar = SnackBar(
                            content: Text(
                              "Image uploaded successfully",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            backgroundColor: Colors.greenAccent,
                            duration: Duration(seconds: 3),
                            padding: EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            behavior: SnackBarBehavior.fixed,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/new_entry");
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
  VoidCallback? onClick,
  required Color color,
}) {
  return SizedBox(
    width: 250,
    child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color)),
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(
              width: 45,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        )),
  );
}
