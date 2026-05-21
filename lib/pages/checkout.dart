import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter/provider/cart.dart';
import 'package:first_flutter/shared/Appbar.dart';
import 'package:first_flutter/shared/Coloer.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("السلة"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context), // الرجوع الصحيح
        ),
      ),
      body: Consumer<Cart>(
        builder: (context, cartInstance, child) {
          // تحويل القائمة إلى قائمة عناصر فريدة (بدون تكرار)
          final uniqueProducts = cartInstance.selectedProducts.toSet().toList();

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: uniqueProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = uniqueProducts[index];

                    // حساب كمية هذا المنتج بالتحديد
                    int quantity = cartInstance.selectedProducts
                        .where((p) => p.name == item.name)
                        .length;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            // 1. صورة المنتج مع خلفية خفيفة
                            Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                item.imgPath,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              ),
                            ),

                            const SizedBox(width: 15),

                            // 2. اسم المنتج والسعر
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "\$ ${item.price.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: BTNgreen,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),

                            // 3. أزرار التحكم والمسح (الجهة اليمنى)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // أيقونة الحذف
                                IconButton(
                                  onPressed: () {
                                    // استدعاء دالة الحذف الكامل للمنتج
                                    cartInstance.removeAllOfProduct(item);

                                    // اختياري: إظهار رسالة تأكيد صغيرة (SnackBar)
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "${item.name} removed from cart"),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors
                                        .redAccent, // تغيير اللون للأحمر يعطي إيحاءً بالحذف الكامل
                                    size: 22,
                                  ),
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                ),
                                const SizedBox(height: 10),
                                // كبسولة التحكم بالكمية
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 240, 219, 185),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cartInstance.delete(item);
                                        },
                                        icon: const Icon(Icons.remove,
                                            size: 18, color: BTNgreen),
                                      ),
                                      Text(
                                        "$quantity",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: BTNgreen),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          cartInstance.add(item);
                                        },
                                        icon: const Icon(Icons.add,
                                            size: 18, color: BTNgreen),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // زر الدفع السفلي
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BTNgreen,
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    "Pay \$ ${cartInstance.price.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 19, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
