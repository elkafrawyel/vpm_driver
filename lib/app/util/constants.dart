import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants {
  // Colors
  static Color kBackgroundColor = const Color(0xFFD2FFF4);
  static Color kPrimaryColor = const Color(0xFF2D5D70);
  static Color kSecondaryColor = const Color(0xFF265DAB);

  // static String mainAppLanguage = 'en';

  static String mainAppLanguage = Get.deviceLocale?.languageCode ?? 'en';
  static String defaultUserType = 'client';
  static String defaultApiTokenType = 'Bearer';

}

double kRadius = 18;
double kBorderWidth = 0.0;
double kSelectedBorderWidth = 2;

final List<BoxShadow> shadows = [
  const BoxShadow(
    color: Color(0x28000000),
    offset: Offset(0, 5),
    blurRadius: 30,
  ),
];
