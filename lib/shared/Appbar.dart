import 'package:first_flutter/pages/checkout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter/provider/cart.dart';

class CartActionButton extends StatelessWidget {
  final Function(String)? onSearchChanged;

  const CartActionButton({super.key, this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    bool isHomePage = onSearchChanged != null;
    final mainContext = context; // حفظ الـ context للرجوع الصحيح

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          top: 50, bottom: isHomePage ? 20 : 15, left: 16, right: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF4A3B32),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildCircleButton(Icons.notifications_none_rounded, () {}),
                  const SizedBox(width: 8),
                  _buildCircleButton(Icons.notes_rounded,
                      () => Scaffold.of(mainContext).openDrawer()),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          mainContext,
                          MaterialPageRoute(
                              builder: (context) => const Checkout()));
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.shopping_cart_outlined,
                            color: Colors.white, size: 24),
                        Consumer<Cart>(builder: (context, cartInstance, child) {
                          if (cartInstance.selectedProducts.isEmpty)
                            return const SizedBox();
                          return Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: Text(
                                    '${cartInstance.selectedProducts.length}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold)),
                              ));
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Consumer<Cart>(builder: (context, cartInstance, child) {
                    return Text("\$${cartInstance.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFD49A3B),
                            fontWeight: FontWeight.bold));
                  }),
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFFD49A3B).withOpacity(0.5),
                            width: 1.5)),
                    child: const CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/3135/3135715.png')),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("هلا وغلا،",
                            style: TextStyle(
                                color: Color(0xFFD49A3B), fontSize: 11)),
                        Text("خالد عبد الرحمن",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
                      ]),
                ],
              ),
            ],
          ),
          if (isHomePage) ...[
            const SizedBox(height: 20),
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Row(textDirection: TextDirection.rtl, children: [
                Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                        color: Color(0xFFD49A3B), shape: BoxShape.circle),
                    child: const Icon(Icons.tune_rounded,
                        color: Colors.white, size: 18)),
                Expanded(
                    child: TextField(
                        textDirection: TextDirection.rtl,
                        onChanged: onSearchChanged,
                        decoration: const InputDecoration(
                            hintText: "ادخل كلمة البحث",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)))),
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.search_rounded,
                        color: Colors.grey, size: 20)),
              ]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, VoidCallback onTap) {
    return Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08), shape: BoxShape.circle),
        child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(icon, color: Colors.white, size: 20),
            onPressed: onTap));
  }
}
