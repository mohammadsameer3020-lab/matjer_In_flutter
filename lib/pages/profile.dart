import 'package:first_flutter/shared/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter/shared/Coloer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Account ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: BTNgreen,
        actions: [
          IconButton(
            onPressed: () {
              // تنفيذ أمر ما أو الانتقال لصفحة الإعدادات
            },
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. قسم المعلومات الشخصية (Header)

          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: BTNgreen.withOpacity(0.1), // خلفية خفيفة بلون التطبيق
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage("https://via.placeholder.com/150"),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Mohamed Ahmed",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Text("mohamed@example.com",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 2. قائمة الخيارات (List of Options)
          Expanded(
            child: ListView(
              children: [
                buildProfileOption(Icons.shopping_bag, "My Orders", () {}),
                buildProfileOption(Icons.location_on, "Shipping sameer", () {}),
                buildProfileOption(Icons.payment, "Payment Methods", () {}),
                buildProfileOption(Icons.settings, "Settings", () {}),
                const Divider(), // خط فاصل
                buildProfileOption(Icons.logout, "Logout", () {},
                    isLogout: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget مساعد لإنشاء صفوف القائمة بشكل منظم
  Widget buildProfileOption(IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: isLogout ? Colors.red : BTNgreen),
      title: Text(
        title,
        style: TextStyle(
            color: isLogout ? Colors.red : Colors.black, fontSize: 17),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
    );
  }
}
