import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:parkers_anniversary/auth_controller.dart';

// String? uid = AuthController().getUserId();

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final db = FirebaseFirestore.instance;

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var comfirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.none,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Create a new account",
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ]),
                    child: TextField(
                      controller: emailController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: "E-mail",
                        prefixIcon: Icon(Icons.email_rounded,
                            color: Colors.redAccent[700]),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ]),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon:
                            Icon(Icons.password, color: Colors.redAccent[700]),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   height: 45,
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(30),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           blurRadius: 10,
                  //           spreadRadius: 7,
                  //           offset: const Offset(1, 1),
                  //           color: Colors.grey.withOpacity(0.3),
                  //         ),
                  //       ]),
                  //   child: TextField(
                  //     controller: comfirmPasswordController,
                  //     obscureText: true,
                  //     style: const TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 18,
                  //     ),
                  //     decoration: InputDecoration(
                  //       hintText: "Comfirm password",
                  //       prefixIcon:
                  //           Icon(Icons.password, color: Colors.redAccent[700]),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //         borderSide:
                  //             const BorderSide(color: Colors.grey, width: 1.0),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //         borderSide: const BorderSide(
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ]),
                    child: TextField(
                      controller: firstNameController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: "First Name",
                        prefixIcon: Icon(Icons.account_box_rounded,
                            color: Colors.redAccent[700]),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ]),
                    child: TextField(
                      controller: lastNameController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: "Last Name",
                        prefixIcon: Icon(Icons.account_box_rounded,
                            color: Colors.redAccent[700]),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ]),
                    child: TextField(
                      controller: phoneNumberController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        prefixIcon: Icon(Icons.phone_android,
                            color: Colors.redAccent[700]),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Already have an account? ",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                            TextSpan(
                              text: "Login!",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.red[300]),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15.0),
              width: w * 0.6,
              height: h * 0.05,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent[700],
                  textStyle: const TextStyle(fontSize: 20),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  // var userID;
                  AuthController.instance.register(emailController.text.trim(),
                      passwordController.text.trim());

                  FirebaseAuth.instance
                      .authStateChanges()
                      .listen((User? user) async {
                    if (user != null) {
                      await db.collection('users').doc(user.uid).set({
                        'firstName': firstNameController.text,
                        'lastName': lastNameController.text,
                        'phoneNumber': phoneNumberController.text,
                      });
                    }
                  });
                  // if (FirebaseAuth.instance.currentUser != null) {
                  //   userID = FirebaseAuth.instance.currentUser?.uid;
                  //   // print(FirebaseAuth.instance.currentUser?.uid);
                  // }
                  // print(userID);
                },
                child: const Text(
                  'Signup',
                  style: TextStyle(fontSize: 27),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
