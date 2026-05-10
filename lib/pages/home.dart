import 'package:first_flutter/model/item.dart';

import 'package:first_flutter/pages/Categraies.dart';
import 'package:first_flutter/pages/ditail_Screen.dart';
import 'package:first_flutter/provider/cart.dart';
import 'package:first_flutter/shared/Appbar.dart';
import 'package:first_flutter/shared/Coloer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // تم حذف سطر cartInstance من هنا لزيادة الأداء والاعتماد على Consumer فقط

    return Scaffold(
      drawer: Drawer(
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
                    leading: const Icon(Icons.grid_view_rounded,
                        color: Colors.green),
                    onTap: () {
                      // استخدام onTap بدلاً من onPressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoriesPage(), // إزالة categoryName
                        ),
                      );
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
                      leading:
                          const Icon(Icons.logout, color: Colors.redAccent),
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
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Home", style: TextStyle(color: Colors.white)),
        actions: const [
          // استدعاء الـ Widget الجاهز هنا
          CartActionButton(),
        ],
        backgroundColor: BTNgreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15,
            childAspectRatio: 1 / 1,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Details(product: items[index])),
                );
              },
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: BTNgreen,
                  trailing: Consumer<Cart>(
                    builder: (context, cartInstance, child) {
                      return IconButton(
                        color: Colors.white,
                        onPressed: () {
                          cartInstance.add(items[index]);
                        },
                        icon: const Icon(Icons.add),
                      );
                    },
                  ),
                  leading: Text(
                    "\$ ${items[index].price}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  title: const Text(""),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(items[index].imgPath, fit: BoxFit.cover),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
