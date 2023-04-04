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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Total Receipts",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            Text(
                              "$docCount",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 42,
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          border: Border.all(color: Colors.redAccent),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text(
                              "Logins",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            Text(
                              "5",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 42),
                            ),
                          ]),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          border: Border.all(color: Colors.purpleAccent),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text(
                              "Types of receipts",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            Text(
                              "1",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 42),
                            ),
                          ]),
                    ),
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          border: Border.all(color: Colors.greenAccent),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text(
                              "Expired Receipts",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            Text(
                              "12",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 42),
                            ),
                          ]),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(color: Colors.greenAccent),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text(
                              "Failed Uploads",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            Text(
                              "18",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 42),
                            ),
                          ]),
                    ),
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text(
                              "Deleted Receipts",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            Text(
                              "7",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 42),
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            )),
          );
        });
  }
}
