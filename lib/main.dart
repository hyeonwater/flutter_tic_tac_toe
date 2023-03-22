import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyeonsookim_tic_tac_toe/pages/HomePage.dart';
import 'package:hyeonsookim_tic_tac_toe/pages/gamePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

