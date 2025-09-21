import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color gray = Color(0xff535353);
  static const Color red = Color(0xffCC1010);
  static const Color green = Color(0xff0CB359);
  static const Color lightPink = Color(0xffF9ECF0);
  static const MaterialColor white = MaterialColor(0xffF9F9F9, <int, Color>{
    10: Color(0xffFEFEFE),
    20: Color(0xfffdfdfd),
    30: Color(0xfffcfcfc),
    40: Color(0xfffbfbfb),
    50: Color(0xfffafafa),
    0: Color(0xfff9f9f9),
    60: Color(0xffd0d0d0),
    70: Color(0xffa6a6a6),
    80: Color(0xff7d7d7d),
    90: Color(0xff535353),
    100: Color(0xff323232),
    101:Color(0xffEAEAEA),
  });

  static const MaterialColor pink = MaterialColor(0xffD21E6A, <int, Color>{
    10: Color(0xfff6d2e1),
    20: Color(0xfff0b4cd),
    30: Color(0xffe98fb5),
    40: Color(0xffe1699c),
    50: Color(0xffda4483),
    0: Color(0xffd21e6a),
    60: Color(0xffaf1958),
    70: Color(0xff8c1447),
    80: Color(0xff690f35),
    90: Color(0xff460a23),
    100: Color(0xff2a0615),
  });

  static const MaterialColor black = MaterialColor(0xff0c1015, <int, Color>{
    10: Color(0xffcecfd0),
    20: Color(0xffaeafb1),
    30: Color(0xff86888a),
    40: Color(0xff5d6063),
    50: Color(0xff34383c),
    0: Color(0xff0c1015),
    60: Color(0xff0a0d12),
    70: Color(0xff080b0e),
    80: Color(0xff06080b),
    90: Color(0xff040507),
    100: Color(0xff020304),
  });

  static const Color darkGray = Color(0xff49454F);
}
