import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth_controller.dart';
import '../shared/menu_bottom.dart';
import '../shared/menu_drawer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String? documentID = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final db = FirebaseFirestore.instance;
  final _userID = FirebaseAuth.instance.currentUser?.uid;
  final email = FirebaseAuth.instance.currentUser?.email;

  bool isLoggingOut = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  Map<String, dynamic> data = {};

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
                    "Your profile",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          bottomNavigationBar: const MenuBottom(),
          drawer: const MenuDrawer(),
          body: Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 35.0),
                    child: Row(
                      children: [
                        Icon(Icons.account_box_outlined,
                            color: Colors.red[400], size: 50.0),
                        const SizedBox(
                          width: 40,
                        ),
                        GestureDetector(
                          onTap: () => openDialog(),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _firstNameController.text != " "
                                        ? "${data['firstName']} "
                                        : "First name",
                                    style: TextStyle(
                                      color: Colors.redAccent[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    _firstNameController.text != " "
                                        ? "${data['lastName']}"
                                        : "Last name",
                                    style: TextStyle(
                                      color: Colors.redAccent[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              Text(
                                email!,
                                style: TextStyle(
                                    color: Colors.redAccent[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                _firstNameController.text != " "
                                    ? "${data['phoneNumber']}"
                                    : "Phone number",
                                style: TextStyle(
                                    color: Colors.redAccent[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/your_entries"),
                    child: Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        children: [
                          Icon(Icons.menu_book,
                              color: Colors.red[400], size: 50.0),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Your Entries",
                            style: TextStyle(
                              color: Colors.redAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/how_to"),
                    child: Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        children: [
                          Icon(Icons.privacy_tip_outlined,
                              color: Colors.red[400], size: 50.0),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Help",
                            style: TextStyle(
                              color: Colors.redAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AuthController.instance.logOut();
                      setState(() {
                        isLoggingOut = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        children: [
                          (isLoggingOut)
                              ? const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                    strokeWidth: 1.5,
                                  ))
                              : Icon(Icons.logout,
                                  color: Colors.red[400], size: 50.0),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.redAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Edit profile"),
          content: SizedBox(
            width: 200,
            height: 150,
            child: Column(
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(hintText: "First name"),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(hintText: "Last name"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("CANCEL"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("SUBMIT"),
              onPressed: () {
                db.collection('users').doc(_userID).update({
                  'firstName': _firstNameController.text,
                  'lastName': _lastNameController.text,
                });
                Navigator.of(context).pop();

                // user.firstName = _firstNameController.text;
                // user.lastName = _lastNameController.text;
              },
            ),
          ],
        ),
      );
}
