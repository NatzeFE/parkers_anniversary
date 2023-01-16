import 'package:flutter/material.dart';
import 'package:parkers_anniversary/screens/how_to.dart';
import 'package:parkers_anniversary/screens/landing.dart';
import 'package:parkers_anniversary/screens/login.dart';
import 'package:parkers_anniversary/screens/new_entries.dart';
import 'package:parkers_anniversary/screens/profile.dart';
import 'package:parkers_anniversary/screens/signup.dart';
import '../screens/history.dart';
import '../screens/intro_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      "Home",
      "How To",
      "History",
      "Profile",
      "Landing", // temporary
      "Login", // temporary
      "Signup", // temporary
      "New Entries", // temporary
    ];

    List<Widget> menuItems = [];
    menuItems.add(
      const DrawerHeader(
        decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
                image: AssetImage("assets/images/drawer_cover.jpg"),
                fit: BoxFit.cover)),
        child: Text(
          "Parker's Anniversary",
          style: TextStyle(color: Colors.red, fontSize: 27),
        ),
      ),
    );
    // ignore: avoid_function_literals_in_foreach_calls
    menuTitles.forEach((String element) {
      Widget screen = Container();
      menuItems.add(
        ListTile(
          title: Text(
            element,
            style: const TextStyle(fontSize: 20),
          ),
          onTap: () {
            switch (element) {
              case "Home":
                screen = const IntroScreen();
                break;
              case "How To":
                screen = const HowTo();
                break;
              case "History":
                screen = const History();
                break;
              case "Profile":
                screen = const Profile();
                break;
              case "Landing":
                screen = const Landing();
                break;
              case "Login":
                screen = const Login();
                break;
              case "Signup":
                screen = const Signup();
                break;
              case "New Entries":
                screen = const NewEntries();
                break;
            }
            Navigator.pop(context);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => screen)));
          },
        ),
      );
    });
    return menuItems;
  }
}
