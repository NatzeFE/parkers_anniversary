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
                    "Your entries",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
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
  // ListView(children: getReceipts(snapshot));

  getReceipts(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs
        .map(
          (doc) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            margin: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Row(
                children: [
                  Text(doc["receiptNumber"]),
                ],
              ),
              subtitle:
                  Text((doc["uploadTime"] as Timestamp).toDate().toString()),
              leading: const Icon(
                Icons.receipt_long,
                size: 30,
              ),
              iconColor: Colors.red,
              textColor: Colors.black,
              tileColor: Colors.black,
            ),
          ),
        )
        .toList();
  }
}
