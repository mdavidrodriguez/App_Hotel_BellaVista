import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GlobalColors {
  static HexColor maincolor = HexColor("#1E3190");
  static HexColor textColor = HexColor("#4F4F4F");
}

const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0, 'Selected color must Be greater and 0'),
        assert(selectedColor < colorList.length - 1,
            'Selected color must lest or equal than ${colorList.length}');

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorList[selectedColor],
      appBarTheme: const AppBarTheme(centerTitle: false));
}
