import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../app/util/constants.dart';
import '../../../app/util/util.dart';
import '../../../controller/app_config_controller.dart';
import '../../models/user_model.dart';
import '../network/api_provider.dart';

enum LocalProviderKeys {
  language, //String
  notifications, //int
  userModel, //Json String
  appTheme, //int  0-> light mode , 1-> dark mode
}

class LocalProvider {
  final GetStorage _box = GetStorage();

  Future init() async {
    await GetStorage.init();
    //set keys default values
    dynamic language = get(LocalProviderKeys.language);
    if (language == null) {
      save(LocalProviderKeys.language, Constants.mainAppLanguage);
    }

    dynamic notifications = get(LocalProviderKeys.notifications);
    if (notifications == null) {
      save(LocalProviderKeys.notifications, true);
    }

    debugPrint('LocalProvider initialization.');
  }

  String getAppLanguage() => get(LocalProviderKeys.language) ?? 'ar';

  bool isLogged() => getUser() != null;

  bool isAr() => get(LocalProviderKeys.language) == 'ar';

  bool isDarkMode() => get(LocalProviderKeys.appTheme) == 1;

  /// ============= ============== ===================  =================
  Future save(LocalProviderKeys localProviderKeys, dynamic value) async {
    await GetStorage().write(localProviderKeys.name, value);
    Utils.logMessage('Setting value to ${localProviderKeys.name} => $value');
  }

  dynamic get(LocalProviderKeys localProviderKeys) {
    // Utils.logMessage('Getting value of ${localProviderKeys.name} => $value');

    return GetStorage().read(localProviderKeys.name);
  }

  Future<bool> saveUser(UserModel? userModel) async {
    try {
      if (userModel != null) {
        await save(
          LocalProviderKeys.userModel,
          jsonEncode(userModel.toJson()),
        ); // userModel jsonString
        APIProvider.instance.updateTokenHeader(
          userModel.token,
        );
        return true;
      } else {
        Utils.logMessage('Failed to save user...');
        return false;
      }
    } catch (e) {
      Utils.logMessage(e.toString());
      return false;
    }
  }

  UserModel? getUser() {
    String? userModelString = get(LocalProviderKeys.userModel);
    if (userModelString == null) {
      return null;
    }
    UserModel userModel = UserModel.fromJson(jsonDecode(userModelString));
    return userModel;
  }

  Future<void> signOut() async {
    await _box.erase();
    Get.find<AppConfigController>().isLoggedIn.value = false;
    APIProvider.instance.updateTokenHeader(null);
    Utils.logMessage('User Logged Out Successfully');
  }
}
