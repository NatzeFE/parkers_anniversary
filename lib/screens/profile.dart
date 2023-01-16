import 'package:flutter/material.dart';

import '../shared/menu_bottom.dart';
import '../shared/menu_drawer.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
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
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                    Column(
                      children: [
                        Text(
                          "First and Last Name",
                          style: TextStyle(
                            color: Colors.redAccent[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Dummy@gmail.com",
                          style: TextStyle(
                              color: Colors.redAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "9999999999",
                          style: TextStyle(
                              color: Colors.redAccent[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: [
                    Icon(Icons.menu_book, color: Colors.red[400], size: 50.0),
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
              Container(
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
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red[400], size: 50.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
