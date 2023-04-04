// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:parkers_anniversary/screens/intro_screen.dart';
import 'package:parkers_anniversary/screens/login.dart';
import 'package:parkers_anniversary/shared/main_page.dart';

class AuthController extends GetxController {
  // AuthController.instance..
  static AuthController instance = Get.find();

  // email, password, name
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth
      .instance; // making us able to access a lot of properties from Firebase
  // late DocumentReference user;
  // late CollectionReference usersReference;
  // late Stream<User?> _authStateChanges;
  // var userID;

  @override
  void onReady() {
    super.onReady();
    // _authStateChanges = auth.authStateChanges();
    // _authStateChanges.listen((User? user) {
    //   _user.value = user;
    //   userID = user?.uid;
    // });
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
      Get.offAll(() => const MainPage());
    }
  }

  void register(String email, password) async {
    User? user;
    try {
      // FirebaseFirestore.instance.collection('users').doc(getUserId());
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar(
        "About user",
        "User message",
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.greenAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Registering account successful",
          style: TextStyle(color: Colors.black),
        ),
        messageText: const Text(
          "User created",
          style: TextStyle(color: Colors.black),
        ),
      );
      if (user?.email == email) return;
      // print("tekst:", proba.uid);
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
        messageText: const Text(
          "User with the email already exists!",
          style: TextStyle(color: Colors.black),
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

  // Future createUser(Map<String, String> map) async {
  //   usersReference = FirebaseFirestore.instance.collection('users');
  //   user = usersReference.doc('userID');
  //   user.set(map);
  // }

  void logOut() async {
    await auth.signOut();
  }

  // String getUserId() {
  //   return userID.toString();
  // }

  // String getEmail() {
  //   return auth.currentUser!.email.toString().toLowerCase();
  // }
}
