import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../shared/menu_bottom.dart';
import '../shared/menu_drawer.dart';

class YourEntries extends StatelessWidget {
  YourEntries({super.key});
  final userId = FirebaseAuth.instance.currentUser?.uid.toString();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("receipts")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Center(
              child: Text(
                "My receipts",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          bottomNavigationBar: const MenuBottom(),
          drawer: const MenuDrawer(),
          body: Container(
            color: Colors.grey[400],
            padding: const EdgeInsets.all(10.0),
            child: ListView(children: getReceipts(snapshot)),
          ),
        );
      },
    );
  }

  getReceipts(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<Widget> placeholder = [];
    final document = snapshot.data?.docs;
    if (document != null) {
      return document
          .map(
            (doc) => SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(doc["receiptNumber"]),
                  subtitle: Text(
                      (doc["uploadTime"] as Timestamp).toDate().toString()),
                  leading: GestureDetector(
                    child: const Icon(
                      Icons.receipt_long,
                      size: 37,
                    ),
                    onTap: () {
                      // ignore: avoid_print
                      print("clicked");
                    },
                  ),
                  iconColor: Colors.red,
                  textColor: Colors.black,
                ),
              ),
            ),
          )
          .toList();
    } else {
      return placeholder;
    }
  }
}
