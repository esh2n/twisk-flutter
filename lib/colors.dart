import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color mainColor = HexColor("#95E6DA");
Color addButtonColor = HexColor("#4997A5");
Color textColor = HexColor("#707070");
Color addScreenColor = HexColor("#757575");
Color shadowColor = Color.fromRGBO(0, 0, 0, 0.16);
Color transparentColor = Color.fromRGBO(0, 0, 0, 0.025);
Color bottomBarColor = HexColor("#f5f5f5");
