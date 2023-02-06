import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth_controller.dart';
import '../shared/menu_bottom.dart';
// import '../shared/menu_drawer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String? documentID = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final db = FirebaseFirestore.instance;
  // final _userID = FirebaseAuth.instance.currentUser?.uid;
  final email = FirebaseAuth.instance.currentUser?.email;

  bool isLoggingOut = false;
  // final TextEditingController _firstNameController = TextEditingController();
  // final TextEditingController _lastNameController = TextEditingController();
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
            title: const Center(
              child: Text(
                "Profile",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          bottomNavigationBar: const MenuBottom(),
          body: Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/edit_profile"),
                    child: Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        children: [
                          Icon(Icons.account_box_outlined,
                              color: Colors.red[400], size: 50.0),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Edit profile",
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
                      openDialog();
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
          title: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              child: const Text("NO"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("YES"),
              onPressed: () {
                AuthController.instance.logOut();
                setState(() {
                  isLoggingOut = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
}
