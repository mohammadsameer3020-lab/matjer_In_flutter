import 'package:first_flutter/pages/home.dart';
import 'package:first_flutter/pages/profile.dart';
import 'package:flutter/material.dart';
// محتوى صفحة الهوم القديم
import 'package:first_flutter/pages/Categraies.dart';
import 'package:first_flutter/pages/checkout.dart';
import 'package:first_flutter/shared/Coloer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // في أعلى الملف تأكد من عمل import لشاشة البروفايل
// import 'package:first_flutter/pages/profile.dart';

  int currentIndex = 0; // المتغير الذي يحدد الصفحة الحالية

// قائمة الصفحات
  final List<Widget> pages = [
    const Home(), // index 0
    CategoriesPage(), // index 1
    const Checkout(), // index 2 (شاشة السلة)
    const ProfilePage(), // index 3 (شاشة البروفايل التي سننتقل إليها)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // عرض الصفحة بناءً على الرقم المختار
      body: pages[currentIndex],
      backgroundColor: const Color.fromARGB(255, 214, 200, 200),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,

        // --- التعديلات المطلوبة للألوان هنا ---
        backgroundColor:
            BTNgreen, // جعل خلفية الشريط خضراء ليظهر اللون الأبيض بوضوح
        selectedItemColor: Colors.white, // لون الأيقونة والنص المختار
        unselectedItemColor:
            Colors.white70, // لون الأيقونات غير المختارة (أبيض شفاف قليلاً)

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
