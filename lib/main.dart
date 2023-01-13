import 'package:flutter/material.dart';
import 'package:parkers_anniversary/screens/history.dart';
import 'package:parkers_anniversary/screens/intro_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/how_to.dart';
import 'screens/new_entry.dart';
import 'screens/profile.dart';

void main() {
  runApp(const ParkersAnniversary());
}

class ParkersAnniversary extends StatelessWidget {
  const ParkersAnniversary({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.red,
      ),
      routes: {
        "/": (context) => const IntroScreen(),
        "/how_to": (context) => const HowTo(),
        "/new_entry": (context) => const NewEntry(),
        "/history": (context) => const History(),
        "/profile": (context) => const Profile(),
      },
      initialRoute: "/",
    );
  }
}
