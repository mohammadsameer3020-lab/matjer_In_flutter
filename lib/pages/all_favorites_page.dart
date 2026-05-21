import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter/model/item.dart';
import 'package:first_flutter/provider/cart.dart';
import 'package:first_flutter/shared/Coloer.dart';
import 'package:first_flutter/pages/ditail_Screen.dart';

class AllFavoritesPage extends StatelessWidget {
  final List<Item> favoriteProducts;

  const AllFavoritesPage({super.key, required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "المفضلة",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: BTNgreen,
        centerTitle: true,
      ),
      // نستخدم Consumer لمراقبة التغييرات (إذا حذف مستخدم منتجاً يختفي فوراً)
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          // إذا كانت قائمة المفضلات فارغة، نعرض رسالة لطيفة للمستخدم
          if (cart.favoriteProducts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border_rounded,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "قائمة المفضلات فارغة حالياً",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }

          // إذا كانت تحتوي على منتجات، نعرضها في قائمة مرنة (ListView)
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: cart.favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = cart.favoriteProducts[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: ListTile(
                  leading: Image.network(
                    product.imgPath,
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "\$${product.price}",
                    style:
                        TextStyle(color: BTNgreen, fontWeight: FontWeight.bold),
                  ),
                  // عند الضغط على المنتج يفتح صفحة تفاصيله القديمة الخاصة بك
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(product: product)),
                    );
                  },
                  // زر الحذف من المفضلة (القلب الممتلئ) عند الضغط عليه يحذفه فوراً
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite_rounded, color: Colors.red),
                    onPressed: () {
                      cart.toggleFavorite(product);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
