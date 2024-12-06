import 'package:flutter/material.dart';
import 'package:netflix_clone/product/constants/locale_keys.dart';

class MyTheme {
  const MyTheme._();
  static final appTheme = ThemeData.dark(useMaterial3: true).copyWith(
    brightness: Brightness.dark,
    primaryColor: Colors.redAccent,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 33,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontFamily: LocaleKeys.kFontFam,
      ),
      displayLarge: TextStyle(fontFamily: 'BebasNeue', fontSize: 32, color: Colors.white),
      displayMedium: TextStyle(fontFamily: 'BebasNeue', fontSize: 24, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[900],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: const TextStyle(color: Colors.grey),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.red),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
  );
}
