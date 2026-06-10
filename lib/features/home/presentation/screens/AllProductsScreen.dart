import 'package:flutter/material.dart';
import 'package:first_flutter/core/constants/app_colors.dart';
import 'package:first_flutter/features/home/data/models/product_model.dart';
import 'package:first_flutter/features/home/data/data_sources/home_api_service.dart';
import 'package:first_flutter/features/home/presentation/widgets/product_card.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final HomeApiService _apiService = HomeApiService();
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    // استدعاء جلب المنتجات عند فتح الشاشة
    _futureProducts = _apiService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF9F9F9), // خلفية التطبيق الفاتحة والمريحة

      // 1️⃣ شريط علوي متناسق مع ألوان الهيدر البني والذهبي
      // 1️⃣ شريط علوي أنيق وبدون أزرار عودة ليتناسب مع شريط التنقل السفلي
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'كل المنتجات',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      // 2️⃣ محتوى الشاشة وعرض المنتجات في شبكة (Grid)
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryDark),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ أثناء تحميل المنتجات',
                style: TextStyle(color: Colors.red[700], fontSize: 14),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد منتجات متاحة حالياً',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            );
          }

          final products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            // تحديد أبعاد شبكة العرض (عمودين متناسقين)
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // عدد الأعمدة
              childAspectRatio: 0.75, // نسبة العرض إلى الارتفاع للكرت
              crossAxisSpacing: 14, // المسافة الأفقية بين الكروت
              mainAxisSpacing: 14, // المسافة العمودية بين الكروت
            ),
            itemBuilder: (context, index) {
              // إعادة استخدام كرت المنتج الذكي الذي أضفنا له زر المفضلة مسبقاً
              return ProductCard(product: products[index]);
            },
          );
        },
      ),
    );
  }
}
