import 'package:first_flutter/core/constants/app_colors.dart';
import 'package:first_flutter/features/cart/presentation/screens/cart_screen.dart';
import 'package:first_flutter/features/cart/provider/cart_provider.dart';

import 'package:first_flutter/features/home/presentation/widgets/search_bar_widget.dart';

import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 25),
      decoration: const BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1️⃣ السطر العلوي: الترحيب (يمين) والأيقونات بالترتيب المعكوس تماماً (يسار)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 👈 جهة اليسار: [ منيو -> إشعارات -> سلة -> سعر ] (لأن القراءة البرمجية تبدأ من اليمين لليسار)
              ListenableBuilder(
                listenable: cartProvider,
                builder: (context, child) {
                  return Row(
                    children: [
                      // 📜 1. المنيو (يأتي أولاً من اليمين ليكون الأقرب لاسم خالد)
                      _buildCircularIcon(Icons.notes, () {}),
                      const SizedBox(width: 8),

                      // 🔔 2. الإشعارات (في المنتصف)
                      _buildCircularIcon(
                          Icons.notifications_none_outlined, () {}),
                      const SizedBox(width: 8),

                      // 🛒 3. السلة
                      _buildCircularIcon(
                        Icons.shopping_cart_outlined,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ),
                          );
                        },
                        isCart: true,
                      ),
                      const SizedBox(width: 8),

                      // 💰 4. السعر (يظهر في أقصى زاوية الشاشة من اليسار تماماً)
                      Text(
                        '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.accentGold,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  );
                },
              ),

              // 👉 اليمين: الترحيب والاسم والصورة الشخصية
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'هلا وغلا',
                        style: TextStyle(
                          color: AppColors.accentGold,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'خالد عبد الرحمن',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.accentGold,
                    child: const Icon(
                      Icons.person,
                      color: AppColors.primaryDark,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24), // مسافة بين السطر العلوي وشريط البحث

          // 2️⃣ 🔍 شريط البحث المستقل البارز
          const CustomSearchBar(),
        ],
      ),
    );
  }

  // ويدجت موحد لإنشاء الأزرار الدائرية الشفافة لضمان تماثل الأحجام 100%
  Widget _buildCircularIcon(IconData icon, VoidCallback onTap,
      {bool isCart = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isCart ? AppColors.accentGold : Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
