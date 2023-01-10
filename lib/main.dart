import 'package:flutter/material.dart';
import 'package:parkers_anniversary/screens/history.dart';
import 'package:parkers_anniversary/screens/intro_screen.dart';

void main() {
  runApp(const ParkersAnniversary());
}

class ParkersAnniversary extends StatelessWidget {
  const ParkersAnniversary({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      routes: {
        "/": (context) => const IntroScreen(),
        "/history": (context) => const History(),
      },
      initialRoute: "/",
    );
  }
}
