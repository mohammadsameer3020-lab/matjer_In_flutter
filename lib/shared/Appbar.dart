import 'package:first_flutter/pages/checkout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter/provider/cart.dart';

class CartActionButton extends StatelessWidget {
  const CartActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                // هنا يمكنك الانتقال لصفحة السلة عند الضغط
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Checkout()));
              },
              icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
            ),
            Positioned(
              bottom: 20,
              child: Consumer<Cart>(
                builder: (context, cartInstance, child) {
                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(210, 136, 32, 0),
                        shape: BoxShape.circle),
                    child: Text(
                      '${cartInstance.selectedProducts.length}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 11.0),
          child: Consumer<Cart>(
            builder: (context, cartInstance, child) {
              return Text(
                "\$ ${cartInstance.price.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              );
            },
          ),
        ),
      ],
    );
  }
}
