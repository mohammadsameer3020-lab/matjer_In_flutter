import 'package:flutter/material.dart';
import 'package:first_flutter/model/item.dart';

class Cart with ChangeNotifier {
  List<Item> selectedProducts = [];
  double price = 0;

  // إضافة منتج للسلة
  // داخل ملف provider/cart.dart
  // داخل كلاس Cart في ملف cart.dart
  void removeAll(Item product) {
    // هذه الدالة تحذف كل المنتجات التي تملك نفس الاسم من القائمة
    selectedProducts.removeWhere((item) => item.name == product.name);
    notifyListeners();
  }
// داخل ملف provider/cart.dart
// داخل كلاس Cart في ملف lib/provider/cart.dart

  void delete(Item product) {
    // 1. حذف النسخة الأولى التي يجدها من المنتج في القائمة
    selectedProducts.remove(product);

    // 2. خصم سعر المنتج من إجمالي السعر
    price -= product.price;

    // 3. تحديث جميع الشاشات التي تستمع لهذا البروفايدر (مهم جداً)
    notifyListeners();
  }

  void removeAllOfProduct(Item product) {
    // حساب عدد القطع الموجودة من هذا المنتج
    int count = selectedProducts.where((p) => p.name == product.name).length;
    double amountToSubtract = product.price * count;

    // حذف جميع القطع التي تحمل نفس الاسم
    selectedProducts.removeWhere((p) => p.name == product.name);

    // خصم المبلغ الإجمالي للمنتج المحذوف
    price -= amountToSubtract;

    // تصفير السعر إذا أصبحت السلة فارغة
    if (selectedProducts.isEmpty) {
      price = 0;
    }

    notifyListeners();
  }

  void add(Item product) {
    selectedProducts.add(product);
    price += product.price;
    notifyListeners(); // هذا السطر هو المسؤول عن تغيير الرقم في الشاشة فوراً
  }

  int get count => selectedProducts.length;
}
