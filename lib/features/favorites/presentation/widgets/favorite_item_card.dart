import 'package:first_flutter/features/favorites/provider/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/data/models/product_model.dart';

class FavoriteItemCard extends StatelessWidget {
  final Product product;

  const FavoriteItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Color primaryDark = AppColors.primaryDark;
    final Color accentGold = AppColors.accentGold;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // زر الحذف السريع من المفضلة (أيقونة سلة أو قلب مكسور)
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: () {
              context.read<FavoritesProvider>().toggleFavorite(product);
            },
          ),
          const Spacer(),
          // تفاصيل المنتج (النصوص والسعر)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: primaryDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${(product.price ?? 0).toStringAsFixed(2)}',
                  style: TextStyle(
                    color: accentGold,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // صورة المنتج
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: product.image != null && product.image!.startsWith('http')
                  ? Image.network(
                      product.image!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, color: Colors.grey),
                    )
                  : const Icon(Icons.broken_image, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
