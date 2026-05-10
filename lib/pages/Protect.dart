import 'package:first_flutter/model/item.dart';

import 'package:first_flutter/pages/ditail_Screen.dart';
import 'package:first_flutter/provider/cart.dart';
import 'package:first_flutter/shared/Appbar.dart';
import 'package:first_flutter/shared/Coloer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Protect extends StatelessWidget {
  const Protect({super.key, required String categoryName});

  @override
  Widget build(BuildContext context) {
    // تم حذف سطر cartInstance من هنا لزيادة الأداء والاعتماد على Consumer فقط

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("products", style: TextStyle(color: Colors.white)),
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
                  backgroundColor: const Color.fromARGB(140, 0, 0, 0),
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
                  title: const Text("prodct"),
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
