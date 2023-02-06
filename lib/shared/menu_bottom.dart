import 'package:flutter/material.dart';

class MenuBottom extends StatelessWidget {
  const MenuBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.red[900],
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, "/home");
            break;
          case 1:
            Navigator.pushNamed(context, "/how_to");
            break;
          case 2:
            Navigator.pushNamed(context, "/new_entry");
            break;
          case 3:
            Navigator.pushNamed(context, "/history");
            break;
          case 4:
            Navigator.pushNamed(context, "/profile");
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories_outlined), label: "how to"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_rounded,
              size: 35,
            ),
            label: "New Entry"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "history"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined), label: "Profile"),
      ],
    );
  }
}
