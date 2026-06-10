// lib/features/profile/presentation/screens/profile_screen.dart

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryDark = AppColors.primaryDark;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          'الملف الشخصي',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1️⃣ القسم العلوي: خلفية ملونة منحنية مع الصورة والاسم
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: primaryDark,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        // دائرة الصورة الشخصية المحمية بـ Shadow وإطار أبيض
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: const NetworkImage(
                              'https://placeholder.com/user_avatar.png', // رابط الصورة التجريبي
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // اسم المستخدم والبريد الإلكتروني
                        const Text(
                          'محمد سمير',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'mohammed@example.com',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 2️⃣ قائمة الخيارات التفاعلية داخل كارد موحد
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 0,
                child: Column(
                  children: [
                    _ProfileMenuItem(
                      icon: Icons.person_outline_rounded,
                      title: 'تعديل البيانات الشخصية',
                      onTap: () {
                        // الانتقال لشاشة تعديل البيانات الشخصية لاحقاً
                      },
                    ),
                    const _MenuDivider(),
                    _ProfileMenuItem(
                      icon: Icons.shopping_bag_outlined,
                      title: 'طلباتي',
                      onTap: () {
                        // الانتقال لشاشة الطلبات
                      },
                    ),
                    const _MenuDivider(),
                    _ProfileMenuItem(
                      icon: Icons.location_on_outlined,
                      title: 'العناوين المحفوظة',
                      onTap: () {
                        // الانتقال لشاشة العناوين
                      },
                    ),
                    const _MenuDivider(),
                    _ProfileMenuItem(
                      icon: Icons.settings_outlined,
                      title: 'الإعدادات',
                      onTap: () {
                        // الانتقال لشاشة الإعدادات
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 3️⃣ كارد مستقل لزر تسجيل الخروج
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 0,
                child: _ProfileMenuItem(
                  icon: Icons.logout_rounded,
                  title: 'تسجيل الخروج',
                  iconColor: Colors.redAccent,
                  textColor: Colors.redAccent,
                  onTap: () {
                    // دالة تسجيل الخروج ومسح التوكن
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// الودجت الفرعي المخصص لعناصر القائمة لضمان نظافة الكود وإعادة استخدامه
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = AppColors.primaryDark,
    this.textColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: Colors.grey,
      ),
    );
  }
}

// خط فاصل ناعم ومحدد المسافات بين الـ ListTiles
class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey.shade100,
      height: 1,
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}
