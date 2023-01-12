import 'package:flutter/material.dart';

import '../shared/menu_bottom.dart';
import '../shared/menu_drawer.dart';

class HowTo extends StatelessWidget {
  const HowTo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("How to")),
        bottomNavigationBar: const MenuBottom(),
        drawer: const MenuDrawer(),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: const Text(
                    "How to enter",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "First step",
                      style: TextStyle(fontSize: 25, color: Colors.red[700]),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      width: 250,
                      height: 250,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Second step",
                      style: TextStyle(fontSize: 25, color: Colors.red[700]),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      width: 250,
                      height: 250,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Third step",
                      style: TextStyle(fontSize: 25, color: Colors.red[700]),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      width: 250,
                      height: 250,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
