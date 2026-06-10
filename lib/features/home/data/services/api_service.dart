// lib/services/api_service.dart

import 'dart:convert';
import 'package:first_flutter/features/home/data/models/product_model.dart';

import 'package:http/http.dart' as http;
// استدعاء الموديل (تأكد من صحة المسار بحسب مجلداتك)

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Product> products =
            body.map((dynamic item) => Product.fromJson(item)).toList();
        return products;
      } else {
        throw Exception('فشل في تحميل المنتجات');
      }
    } catch (e) {
      throw Exception('حدث خطأ أثناء الاتصال: $e');
    }
  }
}
