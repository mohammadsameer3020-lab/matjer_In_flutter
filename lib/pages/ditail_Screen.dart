import 'package:first_flutter/model/item.dart';
import 'package:first_flutter/provider/cart.dart'; // تأكد من وجود هذا الـ Import
import 'package:first_flutter/shared/Appbar.dart';
import 'package:first_flutter/shared/Coloer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // تأكد من وجود هذا الـ Import

class Details extends StatefulWidget {
  final Item product;
  const Details({super.key, required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isShowMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title:
            const Text("Details Screen", style: TextStyle(color: Colors.white)),
        actions: const [
          CartActionButton(),
        ],
        backgroundColor: BTNgreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // صورة المنتج
            Image.network(widget.product.imgPath),
            const SizedBox(height: 16),
            // السعر
            Text(
              "\$${widget.product.price}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // شريط المعلومات (New, Stars, Location)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 129, 129),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text("New", style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: List.generate(
                        5,
                        (index) => const Icon(Icons.star,
                            size: 22, color: Color.fromARGB(255, 235, 189, 2))),
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Icon(Icons.edit_location, size: 22, color: Colors.green),
                      Text(" Flower Shop ", style: TextStyle(fontSize: 16))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            // عنوان التفاصيل
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "Details:",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // نص الوصف وزر "Show More"
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    "This product represents high quality and elegance. Jasmine flowers are among the most beautiful flowers, characterized by a fragrant and attractive scent, and are used in decorating homes and special occasions. It also symbolizes beauty and purity. You can order it now from our store to receive it wrapped in the best possible way to ensure its quality and safety.",
                    style: const TextStyle(fontSize: 18),
                    maxLines: isShowMore ? null : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isShowMore = !isShowMore;
                      });
                    },
                    child: Text(
                      isShowMore ? "Show less" : "Show More",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            // --- زر الإضافة إلى السلة ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Consumer<Cart>(
                builder: (context, cartInstance, child) {
                  return ElevatedButton(
                    onPressed: () {
                      cartInstance.add(widget.product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Added to cart!"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BTNgreen,
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Add to cart",
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
