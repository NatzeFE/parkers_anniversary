import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red[900],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 2) - 150.0 / 2,
            left: (MediaQuery.of(context).size.width / 2) - 150.0 / 2,
            child: Container(
              height: 150.0,
              width: 150.0,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.fill)),
            ),
          ),
        ],
      ),
    );
  }
}
