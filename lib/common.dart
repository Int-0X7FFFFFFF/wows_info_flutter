import 'package:flutter/material.dart';

class ColorSeed extends ChangeNotifier {
  var colorSeed = const Color(0xff6750a4);

  void setColor(targetColor) {
    colorSeed = targetColor;
    notifyListeners();
  }

  Color get getColor => colorSeed;
}
