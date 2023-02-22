import 'package:flutter/material.dart';
import 'package:parkers_anniversary/screens/how_to.dart';
import 'package:parkers_anniversary/screens/intro_screen.dart';
import 'package:parkers_anniversary/screens/new_entry.dart';
import 'package:parkers_anniversary/screens/profile.dart';
import 'package:parkers_anniversary/screens/your_entries.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List pages = [
    const IntroScreen(),
    const HowTo(),
    const NewEntry(),
    const YourEntries(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        selectedItemColor: Colors.red,
        currentIndex: currentIndex,
        elevation: 0,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories_outlined),
            label: "How to",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box_rounded,
                size: 35,
              ),
              label: "New Entry"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Receipts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined), label: "Profile"),
        ],
      ),
    );
  }
}
