import 'dart:convert';
import 'package:first_flutter/features/home/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class HomeApiService {
  final String _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('فشل في تحميل المنتجات من السيرفر');
      }
    } catch (e) {
      throw Exception('حدث خطأ أثناء الاتصال بالشبكة: $e');
    }
  }
}
