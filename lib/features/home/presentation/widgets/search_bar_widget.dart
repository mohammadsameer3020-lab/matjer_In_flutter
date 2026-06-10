import 'package:first_flutter/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        clipBehavior:
            Clip.none, // يسمح للدائرة الصفراء بالبروز خارج حدود المستطيل الأبيض
        children: [
          // أ - المستطيل الأبيض الخلفي مائل قليلاً لليمين لترك مساحة البروز يساراً
          Positioned(
            left: 20,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Row(
                children: [
                  const SizedBox(
                      width:
                          35), // مساحة أمان حتى لا يختفي نص البحث خلف الدائرة الصفراء

                  // أيقونة البحث الرمادية بجانب الدائرة مباشرة
                  const Icon(Icons.search, color: Colors.grey, size: 22),

                  // حقل إدخال النص
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'ادخل كلمة البحث',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ب - الدائرة الصفراء البارزة (Filter) موضوعة بدقة فوق المستطيل ومزاحة لأقصى اليسار
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.accentGold,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset:
                        Offset(2, 2), // يعطي تباين خفيف لإظهار البروز الهيكلي
                  )
                ],
              ),
              child: const Icon(
                Icons.tune,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
