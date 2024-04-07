import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widgets/api_state_views/no_connection_view.dart';

class Utils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void logMessage(String message, {bool isError = false}) {
    if (kDebugMode) {
      Get.log(message, isError: isError);
    }
  }

  static hideGetXDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  static showNoConnectionDialog({String? text}) {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    Get.dialog(const NoConnectionView(), barrierDismissible: false);
  }

  String formatNumbers(
    String number, {
    String? symbol,
    int? digits = 1,
  }) {
    return '${NumberFormat.decimalPatternDigits(
      locale: Get.locale?.languageCode == 'ar' ? 'ar_EG' : 'en_US',
      decimalDigits: digits,
    ).format(
      num.parse(number),
    )} ${symbol ?? (Get.locale?.languageCode == 'ar' ? 'ريال' : 'SAR')}';
  }

  void playSound() async {
    final player = AudioPlayer();
    await player.play(AssetSource('audio/sound.mp3'));
  }
}
