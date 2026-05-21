import 'package:flutter/material.dart';
import 'package:first_flutter/pages/Categraies.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1490750967868-88aa4486c946?q=80&w=1000&auto=format&fit=crop"),
                fit: BoxFit.cover,
              ),
            ),
            accountName: Text("Mohammed Samir",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            accountEmail: Text("mohammed@example.com",
                style: TextStyle(color: Colors.white)),
            currentAccountPicture: CircleAvatar(
              radius: 55,
              backgroundImage: NetworkImage(
                  "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                    title: const Text("Home"),
                    leading: const Icon(Icons.home, color: Colors.green),
                    onTap: () {}),
                ListTile(
                  title: const Text("My Products"),
                  leading:
                      const Icon(Icons.grid_view_rounded, color: Colors.green),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoriesPage()));
                  },
                ),
                ListTile(
                    title: const Text("About"),
                    leading:
                        const Icon(Icons.info_outline, color: Colors.green),
                    onTap: () {}),
                const Divider(),
                ListTile(
                    title: const Text("Logout"),
                    leading: const Icon(Icons.logout, color: Colors.redAccent),
                    onTap: () {}),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: const Text("Developed by mohammed sameer @2026",
                      style: TextStyle(fontSize: 12, color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
