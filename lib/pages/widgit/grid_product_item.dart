import 'package:flutter/material.dart';
import 'package:first_flutter/model/item.dart';
import 'package:first_flutter/pages/ditail_Screen.dart';
import 'package:first_flutter/provider/cart.dart';
import 'package:first_flutter/shared/Coloer.dart';
import 'package:provider/provider.dart';

class GridProductItem extends StatelessWidget {
  final Item product;
  const GridProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details(product: product)),
        );
      },
      child: Container(
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
        // استخدام Stack لتوفير إمكانية وضع زر القلب في زاوية الكرت بالأعلى
        child: Stack(
          children: [
            // 1️⃣ تصميم الكرت الأساسي (الصورة والبيانات بالأسفل)
            Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(
                      product.imgPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${product.price}",
                            style: TextStyle(
                                color: BTNgreen,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          // زر السلة الخاص بك
                          Consumer<Cart>(
                            builder: (context, cart, child) {
                              return InkWell(
                                onTap: () => cart.add(product),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: BTNgreen,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(Icons.add_shopping_cart,
                                      color: Colors.white, size: 18),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 2️⃣ زر القلب العائم بالأعلى جهة اليمين
            Positioned(
              top: 5,
              right: 5,
              child: Consumer<Cart>(
                builder: (context, cartInstance, child) {
                  // جلب حالة المنتج الحالية (مفضل أم لا)
                  bool isFav = cartInstance.isFavorite(product);

                  return IconButton(
                    icon: Icon(
                      isFav
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isFav
                          ? Colors.red
                          : Colors
                              .grey, // يمكنك إعادتها إلى Colors.deepOrangeAccent حسب رغبتك
                      size: 24,
                    ),
                    onPressed: () {
                      // استدعاء دالة المفضلة من الـ Provider
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
  }
}
