import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

abstract class ColorConstants {
  static Color surfacePrimaryDark = hexToColor('#0B1822');
  static Color surfacePrimary = hexToColor('#114649');
  static Color surfaceSecondary = hexToColor('#19222A');
  static Color surfaceWhite = hexToColor('#FFFFFF');
  static Color onSurfacePrimary = hexToColor('#166E6E');
  static Color onSurfacePrimaryLighter = hexToColor('#2BA4A4');
  static Color onSurfaceSecondary = hexToColor('#1E4C5E');
  static Color onSurfaceWhite = hexToColor('#FFFFFF');
  static Color onSurfaceWhite64 = hexToColor('#FFFFFF').withAlpha(163);
  static Color onSurfaceWhite80 = hexToColor('#FFFFFF').withAlpha(204);
  static Color onSurfaceHigh = hexToColor('#070F15');
  static Color onSurfaceMedium = hexToColor('#A5AFB4');
  static Color onSurfaceGray = hexToColor('#EEEEEE');
  static Color statesError = hexToColor('#F85959');
  static Color statesDanger = hexToColor('#FAB639');
  static Color statesSuccess = hexToColor('#1EE86F');
  static Color stroke = hexToColor('#45696B');
  static List<Color> gradientPrimary = [
    hexToColor('#114649'),
    hexToColor('#0B1822'),
  ];
}
