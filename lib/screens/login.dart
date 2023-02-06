// ignore_for_file: prefer_typing_uninitialized_variables

import "package:flutter/material.dart";
import "package:flutter/gestures.dart";
import 'package:get/get.dart';
import 'package:parkers_anniversary/auth_controller.dart';
import 'package:parkers_anniversary/screens/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoging = false;
  bool _passwordVisible = false;
  bool? mejl = false;
  bool? sifra = false;
  bool? isTouchedMejl = false;
  bool? isTouchedSifra = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  @override
  void initState() {
    super.initState();
    emailNode = FocusNode();
    passwordNode = FocusNode();
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
  }

  @override
  void dispose() {
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
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
              margin: const EdgeInsets.only(left: 20, top: 35),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome back",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Sign-in to your account",
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
                        horizontal: 40, vertical: 15),
                    child: TextFormField(
                      focusNode: emailNode,
                      key: _emailKey,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!RegExp(
                                r"^\w+([.-]?\w+)@\w+([.-]?\w+)(\.\w{2,3})+$")
                            .hasMatch(value!)) {
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
                        horizontal: 40, vertical: 15),
                    child: TextFormField(
                      focusNode: passwordNode,
                      key: _passwordKey,
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == " " || value!.isEmpty) {
                          return 'Please enter a valid pasword';
                        } else if (!RegExp(
                                r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,16}$")
                            .hasMatch(value)) {
                          return "Password must be between 8-16 characters";
                        }
                        return null;
                      },
                      // onEditingComplete: () {
                      //   _passwordKey.currentState?.validate();
                      // },
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
                    padding: const EdgeInsets.only(right: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Forgot your password?",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // ignore: avoid_print
                                          print("Forgot password clicked");
                                        }),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "Signup!",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.red[300]),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap =
                                          () => Get.to(() => const Signup()),
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
                    margin: const EdgeInsets.only(top: 35),
                    child: (!mejl! || !sifra!)
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(w * 0.5, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: null,
                            child: const Text("Login"),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(w * 0.5, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () {
                              AuthController.instance.login(
                                  emailController.text.trim(),
                                  passwordController.text.trim());
                            },
                            child: const Text("Login"),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
