import 'package:first_flutter/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';

// تمثيل العنصر داخل السلة مع كميته
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  // إضافة منتج إلى السلة
  void addProduct(Product product, {int quantity = 1}) {
    // البحث إذا كان المنتج موجود مسبقاً في السلة
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      // إذا كان موجوداً، أضف الكمية الجديدة المحددة إلى الكمية السابقة
      _items[index].quantity += quantity;
    } else {
      // إذا لم يكن موجوداً، أضف العنصر بالكمية المحددة
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners(); // لتحديث الشاشات فوراً
  }

  // زيادة الكمية
  void incrementQuantity(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  // تقليل الكمية أو الحذف التلقائي إذا وصلت إلى صفر
  void decrementQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  // حذف العنصر تماماً
  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  // حساب السعر الإجمالي بشكل آمن
  double get totalPrice {
    double total = 0.0;
    for (var item in _items) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  // تفريغ السلة بالكامل
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

// نسخة عالمية موحدة ليسهل استدعاؤها في أي مكان بالتطبيق
final cartProvider = CartProvider();
