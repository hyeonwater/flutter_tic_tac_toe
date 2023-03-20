import 'package:flutter/material.dart';
import 'package:hyeonsookim_tic_tac_toe/pages/gamePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GamePage(),
      ),
    );
  }
}

