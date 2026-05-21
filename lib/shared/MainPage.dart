import 'package:first_flutter/pages/home.dart';
import 'package:first_flutter/pages/profile.dart';
import 'package:first_flutter/pages/Categraies.dart';
import 'package:first_flutter/pages/checkout.dart';
import 'package:first_flutter/pages/all_favorites_page.dart';
import 'package:first_flutter/provider/cart.dart';
import 'package:first_flutter/shared/Coloer.dart';
import 'package:first_flutter/pages/favorite_icon_badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  // قائمة الصفحات (4 عناصر فقط، لأن السلة صفحة منفصلة وليست في التبويب)
  final List<Widget> pages = [
    const Home(),
    Consumer<Cart>(
      builder: (context, cart, child) =>
          AllFavoritesPage(favoriteProducts: cart.favoriteProducts),
    ),
    CategoriesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      backgroundColor: const Color.fromARGB(255, 214, 200, 200),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          // منطق التنقل:
          // إذا كان index هو 3، نفتح السلة كصفحة مستقلة (Push)
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Checkout()),
            );
          } else {
            // إذا كان index أكبر من 3 (أي البروفايل وهو ترتيبه 4)، نعدله لـ 3
            setState(() {
              currentIndex = (index > 3) ? index - 1 : index;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: BTNgreen,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: FavoriteIconBadge(), label: "Favorites"),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"), // الترتيب 3
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"), // الترتيب 4
        ],
      ),
    );
  }
}
