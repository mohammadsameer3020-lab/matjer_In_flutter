//import 'package:first_flutter/pages/card.dart';

//import 'package:first_flutter/pages/Cart.dart'; // أو cart.dart إذا غيرت اسم الملف
import 'package:first_flutter/provider/cart.dart';
import 'package:first_flutter/shared/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      // ✅ استخدم Cart() هنا بالـ T
      create: (context) => Cart(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
