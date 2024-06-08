import 'dart:io';

import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'app/util/util.dart';
import 'data/providers/storage/local_provider.dart';
import 'firebase_options.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
          X509Certificate cert,
          String host,
          int port,
          ) =>
      true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await LocalProvider().init();

 await initializeNotifications();

  runApp(const App());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Utils.logMessage("Handling a background message: ${message.messageId}");
  // handleNotificationClick(message.notification);
}
Future initializeNotifications() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FCMConfig.instance.init(
    onBackgroundMessage: _firebaseMessagingBackgroundHandler,
    defaultAndroidChannel: const AndroidNotificationChannel(
      'com.vpm.diver',
      'Driver',
    ),
  );

  FCMConfig.instance.messaging.getToken().then((token) {
    Utils.logMessage('Firebase Token:$token');
  });
}