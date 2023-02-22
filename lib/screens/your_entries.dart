import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../shared/main_page.dart';
import '../shared/menu_drawer.dart';

class YourEntries extends StatefulWidget {
  const YourEntries({super.key});

  @override
  State<YourEntries> createState() => _YourEntriesState();
}

class _YourEntriesState extends State<YourEntries> {
  final userId = FirebaseAuth.instance.currentUser?.uid.toString();

  Future<QuerySnapshot>? receiptList;
  String receipt = "";
  String? recNmbr;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: receipt == ""
          ? FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .collection("receipts")
              .snapshots()
          : FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .collection("receipts")
              .where("receiptNumber",
                  isGreaterThanOrEqualTo: receipt,
                  isLessThan: receipt.substring(0, receipt.length - 1) +
                      String.fromCharCode(
                          receipt.codeUnitAt(receipt.length - 1) + 1))
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  receipt = value;
                });
              },
              decoration: InputDecoration(
                  hintText: "Search receipt",
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  )),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Container(
            color: Colors.grey[400],
            padding: const EdgeInsets.all(10.0),
            child: ListView(children: getReceipts(snapshot, context)),
          ),
        );
      },
    );
  }

  getReceipts(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
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
                  title: Text("Receipt: ${doc["receiptNumber"]}"),
                  subtitle: Text(
                      "Time: ${(doc["uploadTime"] as Timestamp).toDate()}"),
                  leading: GestureDetector(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.network(doc["receiptUrl"]),
                    ),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => Container(
                        margin: const EdgeInsets.all(40),
                        child: AlertDialog(
                          content: Image.network(doc["receiptUrl"]),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
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
