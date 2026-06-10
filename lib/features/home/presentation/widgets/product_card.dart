// lib/features/home/presentation/widgets/product_card.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1️⃣ تم إضافة مكتبة الـ Provider
import '../../../../core/constants/app_colors.dart';
import '../../../../features/cart/provider/cart_provider.dart';
import '../../../favorites/provider/favorites_provider.dart'; // 2️⃣ قم بتعديل هذا المسار ليطابق مسار الملف لديك
import '../../data/models/product_model.dart';
import '../screens/product_details_screen.dart';

// تم إرجاعه إلى StatelessWidget لأن الـ Provider هو المسؤول عن إدارة الحالة الآن
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  // 1️⃣ خلفية خفيفة وصورة المنتج
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: product.image != null && product.image!.isNotEmpty
                        ? Hero(
                            tag: 'product-${product.id}',
                            child: Image.network(
                              product.image!,
                              fit: BoxFit.contain,
                            ),
                          )
                        : const Icon(Icons.broken_image,
                            size: 50, color: Colors.grey),
                  ),

                  // 2️⃣ أيقونة المفضلة المتزامنة مع الـ Provider (أعلى اليمين)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Consumer<FavoritesProvider>(
                      builder: (context, favProvider, child) {
                        // التحقق المباشر من حالة المنتج في المفضلة العالمية
                        final bool isFav = favProvider.isFavorite(product);

                        return GestureDetector(
                          onTap: () {
                            // عكس حالة المفضلة في الـ Provider
                            favProvider.toggleFavorite(product);

                            // إظهار رسالة سريعة ومحسنة للمستخدم
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isFav
                                      ? 'تم إزالة المنتج من المفضلة 💔'
                                      : 'تم إضافة المنتج إلى المفضلة ❤️',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily:
                                          'Cairo'), // يدعم خط تطبيقك إذا كان موجوداً
                                ),
                                duration: const Duration(seconds: 1),
                                backgroundColor:
                                    isFav ? Colors.redAccent : Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.grey,
                              size: 18,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // 3️⃣ أيقونة السلة السريعة (أسفل اليسار)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: GestureDetector(
                      onTap: () {
                        cartProvider.addProduct(product);

                        ScaffoldMessenger.of(context)
                            .clearSnackBars(); // تنظيف السينك بارز السابقة لتفادي تراكمها
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'تم إضافة ${product.title ?? "المنتج"} إلى السلة',
                              textAlign: TextAlign.center,
                            ),
                            duration: const Duration(seconds: 1),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // القسم السفلي: تفاصيل المنتج (العنوان والسعر)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      color: AppColors.accentGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
