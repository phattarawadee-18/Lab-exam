import 'package:flutter/material.dart';

class MangaTheme {

  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF0F0F0F),

    primaryColor: Colors.redAccent,

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF111111),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(

      filled: true,
      fillColor: const Color(0xFF1C1C1C),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),

      hintStyle: const TextStyle(color: Colors.white54),

    ),

  );
}