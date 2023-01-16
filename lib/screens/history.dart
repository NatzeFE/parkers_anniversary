import "package:flutter/material.dart";
import 'package:parkers_anniversary/shared/menu_bottom.dart';
import 'package:parkers_anniversary/shared/menu_drawer.dart';

class History extends StatelessWidget {
  const History({super.key});

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
                "Our History",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          )),
      bottomNavigationBar: const MenuBottom(),
      drawer: const MenuDrawer(),
      body: GridView.count(
        crossAxisCount: 2, // having 2 columns per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    // paragraph 1
                    text: "Title 1 \n",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              "Testing to see if this work and if I'll be able to style it correctly \n Testing to see if this work and if I'll be able to style it correctly, Testing to see if this work and if I'll be able to style it correctly Testing to see if this work and if I'll be able to style it correctly Testing to see if this work and if I'll be able to style it correctly Testing to see if this work and if I'll be able to style it correctly",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          )),
                    ]),
              ),
            ),
          ),
          const SizedBox(
            // Image 1
            height: 150,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 120,
              child: CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage('assets/images/history1.jpg'),
              ),
            ),
          ),
          const SizedBox(
            // Image 2
            height: 150,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 120,
              child: CircleAvatar(
                radius: 110,
                backgroundImage: AssetImage('assets/images/history2.jpg'),
              ),
            ),
          ),
          Container(
            // paragraph 2
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: "Title 2 \n",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              "Testing to see if this work and if I'll be able to style it correctly \n Testing to see if this work and if I'll be able to style it correctly, Testing to see if this work and if I'll be able to style it correctly Testing to see if this work and if I'll be able to style it correctly Testing to see if this work and if I'll be able to style it correctly Testing to see if this work and if I'll be able to style it correctly",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          )),
                    ]),
              ),
            ),
          ),
          Container(
            // paragraph 3
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: "Title 3 \n",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              "Testing to see if this work and if I'll be able to style it correctly \n Testing to see if this work and if I'll be able to style it correctly, Testing to see if this work and if I'll be able to style it correctly Testing to see if this work and if I'll be able to style it correctly Testing to see if this work and if I'll be able to style it correctly Testing to see if this work and if I'll be able to style it correctly",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          )),
                    ]),
              ),
            ),
          ),
          const SizedBox(
            // Image 3
            height: 150,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 120,
              child: CircleAvatar(
                radius: 110,
                backgroundImage: AssetImage('assets/images/history3.jpg'),
              ),
            ),
          ),
          const SizedBox(
            // Image 4
            height: 150,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 120,
              child: CircleAvatar(
                radius: 110,
                backgroundImage: AssetImage('assets/images/history4.jpg'),
              ),
            ),
          ),
          Container(
            // paragraph 4
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: "Title 4 \n",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              "Testing to see if this work and if I'll be able to style it correctly \n Testing to see if this work and if I'll be able to style it correctly, Testing to see if this work and if I'll be able to style it correctly Testing to see if this work and if I'll be able to style it correctly Testing to see if this work and if I'll be able to style it correctly Testing to see if this work and if I'll be able to style it correctly",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          )),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
