import 'package:flutter/material.dart';
// import 'package:parkers_anniversary/shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: const MenuBottom(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        // child: const Center(
        //   child: Text("Placeholder"),
        // ),
      ),
    );
  }
}
