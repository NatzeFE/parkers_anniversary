// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// "([a-zA-Z]{3,30}\s*)+" za first name
// "[a-zA-Z]{3,30}" za last name bez whitespace
// ([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30} sa whitespace

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // ignore: unused_field
  File? _image;
  final String? documentID = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final db = FirebaseFirestore.instance;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String imageUrl = "";
  final _firstNameKey = GlobalKey<FormFieldState>();
  final _lastNameKey = GlobalKey<FormFieldState>();
  Map<String, dynamic> data = {};

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentID).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          //Data is output to the user
          if (snapshot.connectionState == ConnectionState.done) {
            data = snapshot.data!.data() as Map<String, dynamic>;
          }
          _firstNameController.text = "${data['firstName']}";
          _lastNameController.text = "${data['lastName']}";
          if (data.containsKey("profileImgUrl")) {
            imageUrl = "${data['profileImgUrl']}";
          }

          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              // title: const Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       "My Profile",
              //       style:
              //           TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              //     )),
              automaticallyImplyLeading: false,
              elevation: 1,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Container(
              margin: const EdgeInsets.only(left: 16, top: 25, right: 16),
              child: ListView(
                children: [
                  const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4,
                              color: Colors.red,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: _image == null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: data["profileImgUrl"] != null
                                        ? NetworkImage(
                                            "${data["profileImgUrl"]}")
                                        : const AssetImage(
                                                "assets/images/placeholder.png")
                                            as ImageProvider,
                                  )
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(_image!)),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Colors.red,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                _showPicker(context);
                              },
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    key: _firstNameKey,
                    controller: _firstNameController,
                    validator: (value) {
                      if (value == " " || value!.isEmpty) {
                        return 'Field must not be empty';
                      } else if (!RegExp(
                              r"([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}")
                          .hasMatch(value)) {
                        return "First name must be at least 2 letters long and must only contain ' , . -";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      errorMaxLines: 2,
                      contentPadding: EdgeInsets.only(bottom: -5),
                      labelText: "First name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    key: _lastNameKey,
                    controller: _lastNameController,
                    validator: (value) {
                      if (value == " " || value!.isEmpty) {
                        return 'Field must not be empty';
                      } else if (!RegExp(
                              r"([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}")
                          .hasMatch(value)) {
                        return "Last name must be at least 2 letters long and must only contain ' , . -";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      errorMaxLines: 2,
                      contentPadding: EdgeInsets.only(bottom: -5),
                      labelText: "Last name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: (_firstNameController.text.isEmpty ||
                                  _lastNameController.text.isEmpty)
                              ? null
                              : () {
                                  if (_firstNameKey.currentState!.validate() &&
                                      _lastNameKey.currentState!.validate()) {
                                    db
                                        .collection('users')
                                        .doc(documentID)
                                        .update({
                                      'firstName': _firstNameController.text,
                                      'lastName': _lastNameController.text,
                                    });
                                    const snackBar = SnackBar(
                                      content: Text(
                                        "Changes saved successfully",
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
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    uploadProfile();
                                  } else {
                                    return;
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 40)),
                          child: const Text(
                            'Save',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 40)),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void uploadProfile() async {
    if (_image == null) return;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDir = referenceRoot.child("files");
    Reference referenceUser = referenceDir.child("USER-$documentID");
    Reference referenceImg = referenceUser.child("profile_img.jpg");

    await referenceImg.putFile(File(_image!.path));

    imageUrl = await referenceImg.getDownloadURL();

    db.collection('users').doc(documentID).update({
      "profileImgUrl": imageUrl,
    });
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
}
