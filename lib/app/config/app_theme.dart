import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../res/res.dart';
import 'app_color.dart';
import 'app_style.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: Res.appFontFamily,
    colorScheme: const ColorScheme.light(
      primary: LightThemeColor.primaryColor,
    ),
    primaryColor: LightThemeColor.primaryColor,
    focusColor: LightThemeColor.primaryColor,
    splashColor: LightThemeColor.scaffoldBackground,
    canvasColor: LightThemeColor.scaffoldBackground,
    // Scrollbar color
    highlightColor: LightThemeColor.primaryColor,
    scaffoldBackgroundColor: LightThemeColor.scaffoldBackground,
    hintColor: Colors.black26,
    dividerColor: Colors.black26,
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.all(LightThemeColor.primaryColor),
    ),
    scrollbarTheme: const ScrollbarThemeData().copyWith(
      thumbColor: MaterialStateProperty.all(LightThemeColor.primaryColor),
      trackColor: MaterialStateProperty.all(LightThemeColor.primaryColor),
    ),
    textTheme: const TextTheme(
      displayLarge: displayLargeStyle,
      displayMedium: displayMediumLight,
      displaySmall: displaySmallLight,
      headlineMedium: headlineMediumLight,
      headlineSmall: headlineSmallLight,
      titleLarge: titleLargeLight,
      bodyLarge: bodyLargeLight,
      titleMedium: bodySmallLight,
      bodySmall: bodySmallLight,
      labelLarge: buttonStyle,
    ),
    iconTheme: const IconThemeData(color: Colors.black45),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: LightThemeColor.primaryColor,
      foregroundColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: Res.appFontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),

    cardTheme: CardTheme(
      elevation: 2.0,
      color: LightThemeColor.scaffoldBackground,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(LightThemeColor.primaryColor),

        /// button text color
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        textStyle: MaterialStateProperty.all<TextStyle>(buttonStyle.copyWith(
          fontFamily: Res.appFontFamily,
        )),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        /// button text color
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        textStyle: MaterialStateProperty.all<TextStyle>(buttonStyle.copyWith(
          fontFamily: Res.appFontFamily,
        )),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        /// button text color
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        textStyle: MaterialStateProperty.all<TextStyle>(buttonStyle.copyWith(
          fontFamily: Res.appFontFamily,
        )),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 4.0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      unselectedItemColor: LightThemeColor.disabledColor,
      selectedItemColor: LightThemeColor.primaryColor,
      selectedIconTheme: IconThemeData(color: LightThemeColor.primaryColor),
      unselectedIconTheme: IconThemeData(color: LightThemeColor.disabledColor),
      selectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      unselectedLabelStyle:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black,
    ),
    bottomAppBarTheme:
        const BottomAppBarTheme(color: LightThemeColor.bottomBarColor),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: Res.appFontFamily,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.dark(
      primary: DarkThemeColor.primaryColor,
    ),
    canvasColor: DarkThemeColor.primaryColor,
    focusColor: DarkThemeColor.primaryColor,
    splashColor: DarkThemeColor.primaryColor,
    scaffoldBackgroundColor: DarkThemeColor.scaffoldBackground,
    hintColor: Colors.white60,
    dividerColor: Colors.white60,
    primaryColor: DarkThemeColor.primaryColor,
    highlightColor: DarkThemeColor.primaryColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: DarkThemeColor.primaryColor,
      foregroundColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      displayLarge: displayLargeStyle.copyWith(color: Colors.white),
      displayMedium: displayMediumLight.copyWith(color: Colors.white),
      displaySmall: displaySmallLight.copyWith(color: Colors.white),
      headlineMedium: headlineMediumLight.copyWith(color: Colors.white),
      headlineSmall: headlineSmallLight.copyWith(color: Colors.white),
      titleLarge: titleLargeLight.copyWith(color: Colors.white),
      bodyLarge: bodyLargeLight.copyWith(color: Colors.white),
      titleMedium: bodySmallLight.copyWith(color: Colors.white),
      bodySmall: bodySmallLight.copyWith(color: Colors.white),
      labelLarge: buttonStyle.copyWith(color: Colors.white),
    ),
    appBarTheme: AppBarTheme(
      elevation: 2,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.white),
      toolbarTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: Res.appFontFamily,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: Res.appFontFamily,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    cardTheme: CardTheme(
      elevation: 2.0,
      color: DarkThemeColor.scaffoldBackground,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(DarkThemeColor.primaryColor),
      checkColor: MaterialStateProperty.all(Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(DarkThemeColor.primaryColor),

        /// button text color
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        textStyle: MaterialStateProperty.all<TextStyle>(
          buttonStyle.copyWith(
            color: Colors.white,
            fontFamily: Res.appFontFamily,
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        /// button text color
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        textStyle: MaterialStateProperty.all<TextStyle>(
          buttonStyle.copyWith(
            color: Colors.white,
            fontFamily: Res.appFontFamily,
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        /// button text color
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        textStyle: MaterialStateProperty.all<TextStyle>(
          buttonStyle.copyWith(
            color: Colors.white,
            fontFamily: Res.appFontFamily,
          ),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 2.0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: DarkThemeColor.bottomBarColor,
      selectedItemColor: DarkThemeColor.primaryColor,
      unselectedItemColor: DarkThemeColor.disabledColor,
      selectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white,
    ),
    bottomAppBarTheme:
        const BottomAppBarTheme(color: DarkThemeColor.bottomBarColor),
  );
}
