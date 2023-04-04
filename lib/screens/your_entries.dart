import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timer_snackbar/timer_snackbar.dart';

// import '../shared/main_page.dart';
// import '../shared/menu_drawer.dart';
class YourEntries extends StatefulWidget {
  const YourEntries({super.key});

  @override
  State<YourEntries> createState() => _YourEntriesState();
}

class _YourEntriesState extends State<YourEntries> {
  final userId = FirebaseAuth.instance.currentUser?.uid.toString();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<QuerySnapshot>? receiptList;

  String receipt = "";
  String? recNmbr;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _receipts = [];
  List _searchReceiptList = [];

  bool _loadingReceipts = true;
  bool _gettingMoreReceipts = false;
  bool _moreReceiptsAvailable = true;
  bool _search = false;
  final int _perPage = 10;
  DocumentSnapshot? _lastDocument;
  final _scrollController = ScrollController();

  _getReceipts() async {
    Query q = _firestore
        .collection("users")
        .doc(userId)
        .collection("receipts")
        .orderBy("receiptNumber")
        .limit(_perPage);
    setState(() {
      _loadingReceipts = true;
    });
    _loadingReceipts = true;
    QuerySnapshot querySnapshot = await q.get();
    setState(() {
      _receipts = querySnapshot.docs;
    });
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    setState(() {
      _loadingReceipts = false;
    });
  }

  _getMoreReceipts() async {
    if (_moreReceiptsAvailable == false) {
      return;
    }

    if (_gettingMoreReceipts == true) {
      return;
    }

    _gettingMoreReceipts = true;

    Query q = _firestore
        .collection("users")
        .doc(userId)
        .collection("receipts")
        .orderBy("receiptNumber")
        .startAfter([_lastDocument!.get("receiptNumber")]).limit(_perPage);

    QuerySnapshot querySnapshot = await q.get();
    if (querySnapshot.docs.length < _perPage) {
      _moreReceiptsAvailable = false;
    }
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    _receipts.addAll(querySnapshot.docs);
    setState(() {});
    _gettingMoreReceipts = false;
  }

  _searchReceipts() async {
    Query q = _firestore
        .collection("users")
        .doc(userId)
        .collection("receipts")
        .where("receiptNumber",
            isGreaterThanOrEqualTo: receipt,
            isLessThan: receipt.substring(0, receipt.length - 1) +
                String.fromCharCode(
                    receipt.codeUnitAt(receipt.length - 1) + 1));
    QuerySnapshot querySnapshot = await q.get();
    setState(() {
      _searchReceiptList = querySnapshot.docs.map((e) => e.data()).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _getReceipts();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if (maxScroll - currentScroll <= delta) {
        _getMoreReceipts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _search == false
              ? IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _search = !_search;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.highlight_remove),
                  onPressed: () {
                    setState(() {
                      _search = !_search;
                      receipt = "";
                    });
                  },
                )
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: _search == true
            ? TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    receipt = value;
                  });
                  _searchReceipts();
                  if (receipt == "") {
                    _searchReceiptList.clear();
                  }
                },
                decoration: const InputDecoration(
                  hintText: "Search receipts",
                  border: InputBorder.none,
                ),
              )
            : const Text(
                "My receipts",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
        automaticallyImplyLeading: false,
      ),
      body: _loadingReceipts == true
          ? const Center(
              child: Text("Loading...."),
            )
          : Container(
              child: _receipts.isEmpty
                  ? const Center(
                      child: Text("No receipts uploaded"),
                    )
                  : receipt == ""
                      ? ListView.builder(
                          controller: _scrollController,
                          itemCount: _receipts.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext ctx, int index) {
                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                var deletedReceipt = _receipts.removeAt(index);

                                showSnackB(
                                  second: 5,
                                  context: context,
                                  contentText: "Receipt deleted succesfully",
                                  afterTimeExecute: () {
                                    deletedReceipt.reference.delete();
                                  },
                                  afterClickingUndo: () {
                                    setState(() {
                                      _receipts.insert(index, deletedReceipt);
                                    });
                                  },
                                );
                              },
                              child: ListTile(
                                tileColor:
                                    index % 2 == 0 ? Colors.amber : Colors.red,
                                leading: GestureDetector(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.network(
                                      "${_receipts[index].get("receiptUrl")}",
                                    ),
                                  ),
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) => Container(
                                      margin: const EdgeInsets.all(40),
                                      child: AlertDialog(
                                        content: Image.network(
                                            "${_receipts[index].get("receiptUrl")}"),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                    "Receipt: ${_receipts[index].get("receiptNumber")}"),
                                subtitle: Text(
                                    "${_receipts[index].get("uploadTime").toDate()}"),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: _searchReceiptList.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return ListTile(
                              leading: GestureDetector(
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.network(
                                    "${_searchReceiptList[index]["receiptUrl"]}",
                                  ),
                                ),
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => Container(
                                    margin: const EdgeInsets.all(40),
                                    child: AlertDialog(
                                      content: Image.network(
                                          "${_searchReceiptList[index]["receiptUrl"]}"),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                  "Receipt: ${_searchReceiptList[index]["receiptNumber"]}"),
                              subtitle: Text(
                                  "${_searchReceiptList[index]["uploadTime"].toDate()}"),
                            );
                          }),
            ),
    );
  }

  showSnackB({
    required BuildContext context,
    required String contentText,
    Widget? buttonPrefixWidget,
    String buttonLabel = 'Undo',
    required void Function() afterTimeExecute,
    required void Function() afterClickingUndo,
    int second = 4,
    Color? backgroundColor,
    TextStyle? contentTextStyle,
  }) {
    bool isExecute = true;
    final snackbar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 12.0),
          Expanded(
              child: Text(contentText,
                  style: contentTextStyle ?? const TextStyle())),
          InkWell(
            splashColor: Colors.white,
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              isExecute = !isExecute;
              afterClickingUndo();
              return;
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              color: Colors.grey[850],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (buttonPrefixWidget != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: buttonPrefixWidget,
                    ),
                  Text(
                    buttonLabel,
                    style: TextStyle(color: Colors.blue[100], fontSize: 18),
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 22.0),
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: second * 1000.toDouble()),
              duration: Duration(seconds: second),
              builder: (context, double value, child) {
                return Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        value: value / (second * 1000),
                        color: Colors.grey[850],
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Center(
                      child: Text(
                        (second - (value / 1000)).toInt().toString(),
                        textScaleFactor: 0.85,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor ?? Colors.grey[850],
      duration: Duration(seconds: second),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackbar);

    Timer(Duration(seconds: second), () {
      if (isExecute) afterTimeExecute();
    });
  }
}
