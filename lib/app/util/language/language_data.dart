
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/providers/network/api_provider.dart';
import '../../../data/providers/storage/local_provider.dart';
import '../constants.dart';

class LanguageData {
  final String flag;
  final String name;
  final String languageCode;

  static LanguageData selectedLanguage = languageList()
      .where((element) =>
          element.languageCode.toLowerCase() == (Get.locale?.languageCode.toLowerCase() ?? Constants.mainAppLanguage))
      .first;

  LanguageData(this.flag, this.name, this.languageCode);

  static List<LanguageData> languageList() {
    return <LanguageData>[
      LanguageData("🇺🇸", "English", 'en'),
      LanguageData("🇸🇦", "العربية", "ar"),
    ];
  }

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageData &&
          runtimeType == other.runtimeType &&
          flag == other.flag &&
          name == other.name &&
          languageCode == other.languageCode;

  @override
  int get hashCode => flag.hashCode ^ name.hashCode ^ languageCode.hashCode;

  static Future<void> changeLanguage(LanguageData value) async {
    await Get.updateLocale(Locale(value.languageCode));
    await LocalProvider().save(LocalProviderKeys.language, value.languageCode);
    APIProvider.instance.updateAcceptedLanguageHeader(value.languageCode);
  }
}
