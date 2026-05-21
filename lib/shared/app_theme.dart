import 'package:flutter/material.dart';

class AppTheme {
  // الألوان الأساسية
  static const Color primaryGreen =
      Color(0xFF008080); // لون الـ BTNgreen الخاص بك
  static const Color backgroundColor = Color(0xFFF7F2E8);
  static const Color accentGold = Color(0xFFD49A3B);

  // تنسيق النصوص الموحد
  static const TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // ثيم التطبيق الكامل
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        centerTitle: true,
        titleTextStyle: titleStyle,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}
