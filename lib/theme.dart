import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData();
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black12,
      textTheme: const TextTheme(
        titleMedium: TextStyle(),
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
      ).apply(
        bodyColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black12),
      canvasColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style:
              ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade900)));

    
}
