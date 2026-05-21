import 'dart:ui'; // 1️⃣ تأكد من وجود هذا السطر في أول الملف فوق
import 'package:first_flutter/provider/cart.dart';
import 'package:first_flutter/shared/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 2️⃣ ضع هذا الجزء هنا داخل الـ MaterialApp مباشرة
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch, // للهواتف
          PointerDeviceKind.mouse, // للمحاكي بالماوس
        },
      ),

      home: const MainPage(),
    );
  }
}
