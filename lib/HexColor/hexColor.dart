import 'package:flutter/material.dart';

// This class used only custom color
class HexColor extends Color {
  static int _getColorFromHex(String haxColor) {
    haxColor = haxColor.toUpperCase().replaceAll('#', ""); // convert parameter
    if (haxColor.length == 6) {
      haxColor = "FF" + haxColor;
    }
    return int.parse(haxColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

// How to Use
/*
Color color1 = HexColor("b74093"),
Color color2 = HexColor("#b74093"),
Color color3 = HexColor("#88b74093"), if you wish to use ARGB


 */
