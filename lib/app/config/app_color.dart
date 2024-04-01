import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../controller/app_config_controller.dart';

const hintColor = Color(0xFF716E6E);
const errorColor = Color(0xFFE74343);
final editableColor = Get.find<AppConfigController>().isDarkMode.value
    ? Colors.white24
    : const Color.fromRGBO(217, 217, 217, 0.5);

class DarkThemeColor {
  const DarkThemeColor._();

  static const primaryColor = Color(0xFF7737F8);
  static const disabledColor = Colors.white60;
  static const scaffoldBackground = Color(0xFF1B1C1F);
  static const bottomBarColor = Color(0xFF1B1C1F);
}

class LightThemeColor {
  LightThemeColor._();

  static const primaryColor = Color(0xFF1E68AC);
  static const disabledColor = Color(0xFF929292);
  static const scaffoldBackground = Color(0xffF7F7F7);
  static const bottomBarColor = Color(0xFFFFFFFF);
}
