import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:parkers_anniversary/shared/menu_drawer.dart';
// import '../shared/main_page.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _userID = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AggregateQuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(_userID!)
            .collection('receipts')
            .where('userId', isEqualTo: _userID.toString())
            .count()
            .get(),
        builder: (BuildContext context,
            AsyncSnapshot<AggregateQuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          int? docCount = snapshot.data?.count ?? 0;

          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                    height: 48,
                  ),
                ],
              ),
              automaticallyImplyLeading: false,
            ),
            body: Center(
                child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2 - 250,
                ),
                const Text(
                  "Total number of receipts is: ",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 100,
                  child: Text(
                    "$docCount",
                    style: const TextStyle(fontSize: 60),
                  ),
                ),
              ],
            )),
          );
        });
  }
}
