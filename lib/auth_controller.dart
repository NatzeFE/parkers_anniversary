import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkers_anniversary/screens/intro_screen.dart';
import 'package:parkers_anniversary/screens/login.dart';

class AuthController extends GetxController {
  // AuthController.instance..
  static AuthController instance = Get.find();
  // email, password, name
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth
      .instance; // making us able to access a lot of properties from Firebase

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    // our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) async {
    await Future.delayed(const Duration(seconds: 3));
    if (user == null) {
      Get.offAll(() => const Login());
    } else {
      Get.offAll(() => const IntroScreen());
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "About user",
        "User message",
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.yellow,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Account creation failed",
          style: TextStyle(color: Colors.black),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.black),
        ),
      );
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Get.snackbar(
        "About Login",
        "Login message",
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.yellow,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Login failed",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        messageText: const Text(
          "Incorrect username or password",
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      );
    }
  }

  void logOut() async {
    await auth.signOut();
  }
}
