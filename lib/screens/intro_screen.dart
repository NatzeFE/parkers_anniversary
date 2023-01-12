import 'package:flutter/material.dart';
import 'package:parkers_anniversary/shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
              height: 48,
            ),
            const SizedBox(
              width: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.facebook,
                    color: Colors.grey[400], size: 25.0),
                const SizedBox(
                  width: 15,
                ),
                Icon(FontAwesomeIcons.instagram,
                    color: Colors.grey[400], size: 25.0),
                const SizedBox(
                  width: 15,
                ),
                Icon(FontAwesomeIcons.at, color: Colors.grey[400], size: 25.0),
                const SizedBox(
                  width: 15,
                ),
                Icon(FontAwesomeIcons.envelope,
                    color: Colors.grey[400], size: 25.0),
              ],
            ),
          ],
        ),
      ),
      drawer: const MenuDrawer(),
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
