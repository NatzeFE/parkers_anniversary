import 'package:flutter/material.dart';
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
      "How to",
      "History",
      "Profile",
    ];

    List<Widget> menuItems = [];
    menuItems.add(
      const DrawerHeader(
        decoration: BoxDecoration(color: Colors.red),
        child: Text(
          "Parker's Anniversary",
          style: TextStyle(color: Colors.white, fontSize: 30),
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
              case "History":
                screen = const History();
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
