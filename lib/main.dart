import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first_flutter/features/home/presentation/screens/main_layout_screen.dart';
import 'package:first_flutter/features/cart/provider/cart_provider.dart';
import 'package:first_flutter/features/favorites/provider/favorites_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(),
        ),
      ],
      child: const MatjarApp(),
    ),
  );
}

class MatjarApp extends StatelessWidget {
  const MatjarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matjar App',
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      theme: ThemeData(
        fontFamily: 'Cairo',
        useMaterial3: true,
      ),
      home: const MainLayoutScreen(),
    );
  }
}
