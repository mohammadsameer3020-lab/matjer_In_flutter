import 'package:flutter/material.dart';
import 'package:first_flutter/model/item.dart';

class Cart with ChangeNotifier {
  List<Item> _selectedProducts = [];
  List<Item> _favoriteProducts = [];
  double _price = 0;

  // استخدام Getters للوصول للبيانات بشكل آمن
  List<Item> get selectedProducts => _selectedProducts;
  List<Item> get favoriteProducts => _favoriteProducts;
  double get price => _price;

  // 1. إضافة منتج
  void add(Item product) {
    _selectedProducts.add(product);
    _price += product.price;
    notifyListeners();
  }

  // 2. حذف منتج واحد فقط (عند تقليل الكمية مثلاً)
  void delete(Item product) {
    if (_selectedProducts.contains(product)) {
      _selectedProducts.remove(product);
      _price -= product.price;
      // تأمين ضد القيم السالبة الناتجة عن أخطاء الحساب
      if (_price < 0) _price = 0;
      notifyListeners();
    }
  }

  // 3. حذف كل النسخ من منتج معين
  void removeAllOfProduct(Item product) {
    int count = _selectedProducts.where((p) => p.name == product.name).length;
    _selectedProducts.removeWhere((p) => p.name == product.name);
    _price -= (product.price * count);
    if (_price < 0) _price = 0;
    notifyListeners();
  }

  // 4. تحسين دالة المفضلة (استخدام اسم المنتج للمقارنة لضمان الدقة)
  void toggleFavorite(Item product) {
    if (_favoriteProducts.any((item) => item.name == product.name)) {
      _favoriteProducts.removeWhere((item) => item.name == product.name);
    } else {
      _favoriteProducts.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(Item product) {
    return _favoriteProducts.any((item) => item.name == product.name);
  }
}
