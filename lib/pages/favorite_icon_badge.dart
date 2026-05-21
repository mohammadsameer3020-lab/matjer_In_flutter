import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter/provider/cart.dart';

class FavoriteIconBadge extends StatelessWidget {
  const FavoriteIconBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Stack(
          clipBehavior:
              Clip.none, // لمنع قص الدائرة الحمراء إذا خرجت عن حدود الأيقونة
          children: [
            // 1️⃣ شكل أيقونة القلب (يتغير شكلها ولونها إذا كانت تحتوي على عناصر مضافة)
            Icon(
              cart.favoriteProducts.isNotEmpty
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: cart.favoriteProducts.isNotEmpty ? Colors.red : null,
            ),

            // 2️⃣ دائرة الإشعار الحمراء (تظهر فقط إذا كان هناك منتجات في المفضلة)
            if (cart.favoriteProducts.isNotEmpty)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    "${cart.favoriteProducts.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
