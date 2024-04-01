import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../app/config/app_theme.dart';
import '../../app/util/util.dart';
import '../../data/providers/storage/local_provider.dart';
import '../screens/home/home_screen.dart';
import '../screens/welcome_screen.dart';
import 'home_screen/home_screen_binding.dart';

class AppConfigController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxBool isDarkMode = false.obs;
  Rx<ThemeData> theme = AppTheme.lightTheme.obs;
  String appVersion = "Not detected";
  late StreamSubscription<ConnectivityResult> subscription;

  List<Locale> supportedLocales = const [
    Locale('ar', 'EG'),
    Locale('en', 'US'),
  ];

  @override
  onReady() {
    super.onReady();

    ever(isLoggedIn, (callback) async {
      Utils.logMessage('Ever called on logged in callback');
      debugPrint('isLoggedIn =>$callback');
      if (callback) {
        Get.offAll(() => const HomeScreen(), binding: HomeScreenBinding());
      } else {
        Get.offAll(() => const WelcomeScreen());
      }
    });
    _initialize();
  }

  _initialize() async {
    await _watchNetworkState();
    isLoggedIn.value = LocalProvider().isLogged();
    _applySavedTheme();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
  }

  Future<void> _watchNetworkState() async {
    /// this for app initialization only
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network.
      Utils.hideGetXDialog();
    } else {
      Utils.showNoConnectionDialog();
    }

    /// this for listen in app
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        // I am connected to a mobile network.
        Utils.hideGetXDialog();
      } else {
        Utils.showNoConnectionDialog();
      }
    });
  }

  void _applySavedTheme() {
    int currentTheme = LocalProvider().get(LocalProviderKeys.appTheme) ?? 0;
    if (currentTheme != 1) {
      theme.value = AppTheme.lightTheme;
      isDarkMode.value = false;
    } else {
      theme.value = AppTheme.darkTheme;
      isDarkMode.value = true;
    }
  }

  void toggleAppTheme() async {
    int currentTheme = LocalProvider().get(LocalProviderKeys.appTheme) ?? 0;
    await LocalProvider()
        .save(LocalProviderKeys.appTheme, currentTheme == 1 ? 0 : 1);
    if (theme.value == AppTheme.darkTheme) {
      theme.value = AppTheme.lightTheme;
      isDarkMode.value = false;
    } else {
      theme.value = AppTheme.darkTheme;
      isDarkMode.value = true;
    }
  }
}
