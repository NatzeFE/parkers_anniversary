import "package:flutter/material.dart";
import 'package:parkers_anniversary/shared/menu_bottom.dart';
import 'package:parkers_anniversary/shared/menu_drawer.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Our History")),
      bottomNavigationBar: const MenuBottom(),
      drawer: const MenuDrawer(),
    );
  }
}
