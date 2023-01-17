import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkers_anniversary/auth_controller.dart';
import 'package:parkers_anniversary/screens/history.dart';
import 'package:parkers_anniversary/screens/intro_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkers_anniversary/screens/landing.dart';

import 'screens/how_to.dart';
import 'screens/new_entry.dart';
import 'screens/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const ParkersAnniversary());
}

class ParkersAnniversary extends StatelessWidget {
  const ParkersAnniversary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.red,
      ),
      routes: {
        "/": (context) => const Landing(),
        "/home": (context) => const IntroScreen(),
        "/how_to": (context) => const HowTo(),
        "/new_entry": (context) => const NewEntry(),
        "/history": (context) => const History(),
        "/profile": (context) => const Profile(),
      },
      initialRoute: "/",
    );
  }
}
