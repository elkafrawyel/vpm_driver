import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../app/config/environment.dart';
import '../app/util/focus_remover.dart';
import '../app/util/language/translation.dart';
import '../data/providers/storage/local_provider.dart';
import 'controller/app_config_controller.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppConfigController appConfigController = Get.put(
    AppConfigController(),
    permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    PlatformDispatcher.instance.onLocaleChanged = () {
      print("Locale changed");
      setState(() {});
    };
    String appLanguage = LocalProvider().getAppLanguage();
    return Obx(
      () => FocusRemover(
        child: OKToast(
          child: GetMaterialApp(
            home: Container(color: Theme.of(context).scaffoldBackgroundColor),
            debugShowCheckedModeBanner:
                Environment.appMode == AppMode.staging ||
                    Environment.appMode == AppMode.testing,
            defaultTransition: Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 300),
            title: 'Driver',
            theme: appConfigController.theme.value,
            translations: Translation(),
            locale: Locale(appLanguage),
            fallbackLocale: Locale(appLanguage),
            supportedLocales: appConfigController.supportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              child = EasyLoading.init()(context, child);
              EasyLoading.instance
                ..displayDuration = const Duration(milliseconds: 2000)
                ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                ..loadingStyle = EasyLoadingStyle.custom
                ..maskType = EasyLoadingMaskType.black
                ..indicatorSize = 50.0
                ..radius = 10.0
                ..progressWidth = 3
                ..progressColor = Colors.green
                ..textColor = Colors.black
                ..backgroundColor = Colors.white
                ..indicatorColor = Theme.of(context).primaryColor
                ..maskColor = Colors.blue.withOpacity(0.5)
                ..textStyle = const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )
                ..userInteractions = true
                ..dismissOnTap = false;
              child = MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: child,
              );
              return child;
            },
          ),
        ),
      ),
    );
  }
}
