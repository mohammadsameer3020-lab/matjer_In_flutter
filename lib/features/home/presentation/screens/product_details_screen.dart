// lib/features/home/presentation/screens/product_details_screen.dart

import 'package:first_flutter/features/favorites/provider/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/product_model.dart';
import '../../../cart/provider/cart_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return _ProductDetailsContent(product: product);
  }
}

class _ProductDetailsContent extends StatefulWidget {
  final Product product;

  const _ProductDetailsContent({super.key, required this.product});

  @override
  State<_ProductDetailsContent> createState() => _ProductDetailsContentState();
}

class _ProductDetailsContentState extends State<_ProductDetailsContent> {
  int _quantity = 1;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final Color primaryDark = AppColors.primaryDark;
    final Color accentGold = AppColors.accentGold;

    // ✅ السطر المفقود الذي كان يسبب مشكلة في الشاشة وتحديث الـ Context:
    final cartProvider = context.read<CartProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 16),
          ),
        ),
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, favProvider, child) {
              final bool isFav = favProvider.isFavorite(widget.product);

              return GestureDetector(
                onTap: () {
                  context
                      .read<FavoritesProvider>()
                      .toggleFavorite(widget.product);

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFav
                            ? 'تم إزالة المنتج من المفضلة 💔'
                            : 'تم إضافة المنتج إلى المفضلة ❤️',
                        style: const TextStyle(fontFamily: 'Cairo'),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: isFav ? Colors.redAccent : Colors.green,
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.white,
                    size: 20,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.42,
                  decoration: BoxDecoration(
                    color: primaryDark,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 80),
                      child: Hero(
                        tag: 'product-${widget.product.id}',
                        child: widget.product.image != null &&
                                widget.product.image!.startsWith('http')
                            ? Image.network(
                                widget.product.image!,
                                fit: BoxFit.contain,
                                height: 220,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image,
                                        size: 100, color: Colors.grey),
                              )
                            : const Icon(Icons.broken_image,
                                size: 100, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${(widget.product.price ?? 0).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: accentGold,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.product.title ?? '',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: primaryDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        '(4.5)',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(width: 4),
                      Row(
                        children: List.generate(
                          5,
                          (index) =>
                              Icon(Icons.star, color: accentGold, size: 16),
                        ),
                      ),
                    ],
                  ),
                  const _CustomDivider(),
                  Text(
                    'تفاصيل المنتج',
                    style: TextStyle(
                      color: primaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          widget.product.description ??
                              'لا يوجد وصف متاح لهذا المنتج حالياً.',
                          textAlign: TextAlign.right,
                          maxLines: _isExpanded ? null : 2,
                          overflow: _isExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Text(
                          _isExpanded ? 'عرض أقل' : 'عرض المزيد...',
                          style: TextStyle(
                            color: accentGold,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const _CustomDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon:
                                  Icon(Icons.add, color: primaryDark, size: 18),
                              onPressed: () {
                                setState(() {
                                  _quantity++;
                                });
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '$_quantity',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove,
                                  color: primaryDark, size: 18),
                              onPressed: () {
                                if (_quantity > 1) {
                                  setState(() {
                                    _quantity--;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'الكمية',
                        style: TextStyle(
                          color: primaryDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            cartProvider.addProduct(
              widget.product,
              quantity: _quantity,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'تم إضافة $_quantity من المنتج إلى السلة',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'Cairo'),
                ),
                backgroundColor: Colors.green,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryDark,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 2,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 20),
              SizedBox(width: 10),
              Text(
                'إضافة إلى السلة',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Divider(color: Colors.grey.shade200, height: 1, thickness: 1),
    );
  }
}
