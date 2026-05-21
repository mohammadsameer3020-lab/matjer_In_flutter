import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter/model/item.dart';
import 'package:first_flutter/provider/cart.dart';
import 'package:first_flutter/pages/ditail_Screen.dart';
import 'package:first_flutter/shared/Coloer.dart';

class UpcomingProductsList extends StatelessWidget {
  final List<Item> products;

  const UpcomingProductsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    // نأخذ أول 5 منتجات فقط كمثال للمنتجات القادمة
    List<Item> upcomingItems = products.take(5).toList();

    return SizedBox(
      height: 220, // ارتفاع مناسب ليتسع للكرت مع النصوص والأزرار
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: upcomingItems.length,
        itemBuilder: (context, index) {
          final product = upcomingItems[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Details(product: product)),
              );
            },
            child: Container(
              width: 160,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              // استخدام Stack لوضع زر القلب في زاوية كروت المنتجات العلوية أيضاً
              child: Stack(
                children: [
                  // 1️⃣ محتوى الكرت (الصورة، الاسم، السعر، زر السلة)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15)),
                            child: Image.network(
                              product.imgPath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          product.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${product.price}",
                              style: TextStyle(
                                color: BTNgreen,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // زر إضافة المنتج إلى السلة
                            Consumer<Cart>(
                              builder: (context, cart, child) {
                                return InkWell(
                                  onTap: () => cart.add(product),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: BTNgreen,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // ❤️ 2️⃣ زر القلب العائم مصلح ومربوط بالـ Provider في زاوية الكرت العلوي
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Consumer<Cart>(
                      builder: (context, cartInstance, child) {
                        bool isFav = cartInstance.isFavorite(product);

                        return IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            isFav
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: isFav ? Colors.red : Colors.grey,
                            size: 22,
                          ),
                          onPressed: () {
                            cartInstance.toggleFavorite(product);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
