import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin CustomThemeData implements ThemeData{
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor:const Color(0xffFDFDFD),
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor:const Color(0xff2D2F36),
  );
}


