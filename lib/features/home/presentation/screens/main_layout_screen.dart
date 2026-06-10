// lib/features/main_layout_screen.dart

import 'package:first_flutter/features/home/presentation/screens/AllProductsScreen.dart';
// ⚠️ التعديل هنا: قمنا بتغيير المسار ليقرأ من مجلد ميزة المفضلات الحقيقية
import 'package:first_flutter/features/favorites/presentation/screens/favorites_screen.dart';

import 'package:first_flutter/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter/core/constants/app_colors.dart';
import 'package:first_flutter/features/home/presentation/screens/home_screen.dart';
import 'package:first_flutter/features/cart/presentation/screens/cart_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 4;

  // الشاشات الآن مرتبة وستقرأ FavoritesScreen الاحترافية القائمة على الـ Consumer
  final List<Widget> _screens = [
    const ProfileScreen(),
    const FavoritesScreen(), // ستعمل الآن تلقائياً وتظهر المنتجات المتفاعلة 🎉
    const CartScreen(),
    const AllProductsScreen(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.accentGold,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'حسابي',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'المفضلة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: 'السلة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view),
              label: 'المنتجات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
          ],
        ),
      ),
    );
  }
}
