// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parkers_anniversary/auth_controller.dart';
import 'package:parkers_anniversary/screens/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final db = FirebaseFirestore.instance;
  bool isRegistering = false;

  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _firstNameKey = GlobalKey<FormFieldState>();
  final _lastNameKey = GlobalKey<FormFieldState>();
  final _phoneNumberKey = GlobalKey<FormFieldState>();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode phoneNumberNode = FocusNode();

  bool _passwordVisible = false;

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneNumberController = TextEditingController(text: "+");
  // var comfirmPasswordController = TextEditingController();
  bool? mejl = false;
  bool? sifra = false;
  bool? ime = false;
  bool? prezime = false;
  bool? brTel = false;
  bool? isTouchedMejl = false;
  bool? isTouchedSifra = false;
  bool? isTouchedIme = false;
  bool? isTouchedPrezime = false;
  bool? isTouchedBrojTel = false;

  @override
  void initState() {
    super.initState();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    phoneNumberNode = FocusNode();

    emailNode.addListener(() {
      if (!emailNode.hasFocus) {
        setState(() {
          mejl = _emailKey.currentState?.validate();
          isTouchedMejl = true;
        });
      }
    });
    passwordNode.addListener(() {
      if (!passwordNode.hasFocus) {
        setState(() {
          sifra = _passwordKey.currentState?.validate();
          isTouchedSifra = true;
        });
      }
    });
    firstNameNode.addListener(() {
      if (!firstNameNode.hasFocus) {
        setState(() {
          ime = _firstNameKey.currentState?.validate();
          isTouchedIme = true;
        });
      }
    });
    lastNameNode.addListener(() {
      if (!lastNameNode.hasFocus) {
        setState(() {
          prezime = _lastNameKey.currentState?.validate();
          isTouchedPrezime = true;
        });
      }
    });
    phoneNumberNode.addListener(() {
      if (!phoneNumberNode.hasFocus) {
        setState(() {
          brTel = _phoneNumberKey.currentState?.validate();
          isTouchedBrojTel = true;
        });
      }
    });
  }

  @override
  void dispose() {
    emailNode.dispose();
    passwordNode.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    phoneNumberNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.11,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.none,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Create a new account",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: TextFormField(
                      key: _emailKey,
                      controller: emailController,
                      focusNode: emailNode,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == " " || value!.isEmpty) {
                          return 'Please enter a valid email';
                        } else if (!RegExp(
                                r"^\w+([.-]?\w+)@\w+([.-]?\w+)(\.\w{2,3})+$")
                            .hasMatch(value)) {
                          return "Invalid email format";
                        }
                        return null;
                      },
                      onChanged: isTouchedMejl!
                          ? ((value) {
                              setState(() {
                                mejl = _emailKey.currentState?.validate();
                              });
                            })
                          : null,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(30),
                        //   borderSide: const BorderSide(
                        //       color: Colors.greenAccent, width: 1.0),
                        // ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Colors.redAccent, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: TextFormField(
                      key: _passwordKey,
                      controller: passwordController,
                      focusNode: passwordNode,
                      obscureText: !_passwordVisible,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == " " || value!.isEmpty) {
                          return 'Please enter a valid pasword';
                        } else if (!RegExp(
                                r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,16}$")
                            .hasMatch(value)) {
                          return "Password must be between 8-16 characters, contain an uppercase, a lowercase letter and a number";
                        }
                        return null;
                      },
                      onChanged: isTouchedSifra!
                          ? ((value) {
                              setState(() {
                                sifra = _passwordKey.currentState?.validate();
                              });
                            })
                          : null,
                      decoration: InputDecoration(
                        errorMaxLines: 3,
                        hintText: "Enter your password",
                        prefixIcon: const Icon(Icons.password_outlined),
                        suffixIcon: GestureDetector(
                          child: _passwordVisible
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility),
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(30),
                        //   borderSide: const BorderSide(
                        //       color: Colors.greenAccent, width: 1.0),
                        // ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Colors.redAccent, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: TextFormField(
                      key: _firstNameKey,
                      controller: firstNameController,
                      focusNode: firstNameNode,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == " " || value!.isEmpty) {
                          return 'Field must not be empty';
                        } else if (!RegExp(
                                r"([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}")
                            .hasMatch(value)) {
                          return "First name must be at least 2 letters long and must only contain ' , . -";
                        }
                        return null;
                      },
                      onChanged: isTouchedIme!
                          ? ((value) {
                              setState(() {
                                ime = _firstNameKey.currentState?.validate();
                              });
                            })
                          : null,
                      decoration: InputDecoration(
                        hintText: "Enter your first name",
                        errorMaxLines: 3,
                        prefixIcon: const Icon(Icons.account_box_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(30),
                        //   borderSide: const BorderSide(
                        //       color: Colors.greenAccent, width: 1.0),
                        // ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Colors.redAccent, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: TextFormField(
                      key: _lastNameKey,
                      controller: lastNameController,
                      focusNode: lastNameNode,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == " " || value!.isEmpty) {
                          return 'Field must not be empty';
                        } else if (!RegExp(
                                r"([a-zA-Z',.-]+( [a-zA-Z',.-]+)*){2,30}")
                            .hasMatch(value)) {
                          return "First name must be at least 2 letters long and must only contain ' , . -";
                        }
                        return null;
                      },
                      onChanged: isTouchedPrezime!
                          ? ((value) {
                              setState(() {
                                prezime = _lastNameKey.currentState?.validate();
                              });
                            })
                          : null,
                      decoration: InputDecoration(
                        hintText: "Enter your last name",
                        errorMaxLines: 3,
                        prefixIcon: const Icon(Icons.account_box_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(30),
                        //   borderSide: const BorderSide(
                        //       color: Colors.greenAccent, width: 1.0),
                        // ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Colors.redAccent, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: TextFormField(
                      key: _phoneNumberKey,
                      controller: phoneNumberController,
                      focusNode: phoneNumberNode,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == " " || value!.isEmpty) {
                          return 'Field must not be empty';
                        } else if (!RegExp(r"^\+[1-9][0-9]{7,14}$")
                            .hasMatch(value)) {
                          return "Number must start with a + and have between 7-15 digits";
                        }
                        return null;
                      },
                      onChanged: isTouchedBrojTel!
                          ? ((value) {
                              setState(() {
                                brTel =
                                    _phoneNumberKey.currentState?.validate();
                              });
                            })
                          : null,
                      decoration: InputDecoration(
                        hintText: "Enter your phone number",
                        errorMaxLines: 3,
                        prefixIcon: const Icon(Icons.phone_android_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(30),
                        //   borderSide: const BorderSide(
                        //       color: Colors.greenAccent, width: 1.0),
                        // ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Colors.redAccent, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              TextSpan(
                                text: "Login!",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.red[300]),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => const Login()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    child: (!mejl! || !sifra! || !ime! || !prezime! || !brTel!)
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(w * 0.5, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: null,
                            child: const Text("Signup"),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(w * 0.5, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                AuthController.instance.register(
                                    emailController.text.trim(),
                                    passwordController.text.trim());
                                FirebaseAuth.instance
                                    .authStateChanges()
                                    .listen((User? user) async {
                                  if (user != null) {
                                    await db
                                        .collection('users')
                                        .doc(user.uid)
                                        .set({
                                      'firstName': firstNameController.text,
                                      'lastName': lastNameController.text,
                                      'phoneNumber': phoneNumberController.text,
                                      'email': emailController.text,
                                    });
                                  }
                                });
                              }
                            },
                            child: const Text("Signup"),
                          ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
