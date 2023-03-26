import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hyeonsookim_tic_tac_toe/pages/homePage.dart';
import 'package:hyeonsookim_tic_tac_toe/pages/gamePage.dart';

import 'customs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); /// 세로모드 고정
    return GetMaterialApp(
      builder: (context,child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: child!), /// 디바이스 자체 텍스트 크기를 키우더라도 앱내에 텍스트 크기 고정
      home: HomePage(),
        themeMode: ThemeMode.light,
        theme: CustomThemeData.light,
        darkTheme: CustomThemeData.dark,
      );
  }
}

