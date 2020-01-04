import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/color_data.dart';

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
Color mainColorDark = HexColor("#1F1F1F");
Color addButtonColor = HexColor("#4997A5");
Color addButtonColorDark = HexColor("#424242");
Color textColor = HexColor("#707070");
Color textColorDark = HexColor("#f5f5f5");
Color addScreenColor = HexColor("#446964");
Color addScreenColorDark = Color.fromRGBO(18, 18, 18, 1);
Color shadowColor = Color.fromRGBO(0, 0, 0, 0.16);
Color transparentColor = Color.fromRGBO(0, 0, 0, 0.025);
Color bottomBarColor = HexColor("#f5f5f5");
Color listBackGroundColor = HexColor("#333333");
Color dividerColor = HexColor("#efefef");

bool isDark(BuildContext context) {
  print(
      "colorListCount(in isDark): ${Provider.of<ColorData>(context).colorListCount}");
  if (Provider.of<ColorData>(context).colorListCount > 0) {
    print(
        "colorList[0].colorMode(in isDark): ${Provider.of<ColorData>(context).colorList[0].colorMode}");
    if (Provider.of<ColorData>(context).colorList[0].colorMode == 0) {
      return false;
    } else {
      return true;
    }
  } else {
    final colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.light) {
      print("false");
      return false;
    } else {
      print("true");
      return true;
    }
  }
}

Color getDividerColor(bool isDark) {
  if (isDark) {
    return addButtonColorDark;
  } else {
    return dividerColor;
  }
}

Color getMainColor(bool isDark) {
  if (isDark) {
    return mainColorDark;
  } else {
    return mainColor;
  }
}

Color getPrimaryColor(Brightness brightness) {
  if (brightness == Brightness.dark) {
    return mainColorDark;
  } else {
    return mainColor;
  }
}

Color getButtonColor(bool isDark) {
  if (isDark) {
    return addButtonColorDark;
  } else {
    return addButtonColor;
  }
}

Color getBottomColor(bool isDark) {
  if (isDark) {
    return bottomBarColor;
  } else {
    return addButtonColor;
  }
}

Color getTextColor(bool isDark) {
  if (isDark) {
    return textColorDark;
  } else {
    return textColor;
  }
}

Color getListTextColor(bool isDark) {
  if (isDark) {
    return listBackGroundColor;
  } else {
    return listBackGroundColor;
  }
}

Color getTopButtonColor(bool isDark) {
  if (isDark) {
    return addButtonColorDark;
  } else {
    return Colors.white;
  }
}

Color getListBackGroundColor(bool isDark) {
  if (isDark) {
    return listBackGroundColor;
  } else {
    return Colors.white;
  }
}

Color getAddScreenColor(bool isDark) {
  if (isDark) {
    return addScreenColorDark;
  } else {
    return addScreenColor;
  }
}

Color getAddButtonTextColor(bool isDark) {
  if (isDark) {
    return listBackGroundColor;
  } else {
    return Colors.white;
  }
}

Color getAddButtonColor(bool isDark) {
  if (isDark) {
    return textColorDark;
  } else {
    return addButtonColor;
  }
}

Color getFocusedBorderColor(bool isDark) {
  if (isDark) {
    return Colors.white;
  } else {
    return mainColor;
  }
}
