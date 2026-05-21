import 'package:first_flutter/model/item.dart';
import 'package:first_flutter/pages/all_favorites_page.dart';
import 'package:first_flutter/pages/all_products_page.dart';
import 'package:first_flutter/provider/cart.dart';
import 'package:first_flutter/shared/Appbar.dart';
import 'package:first_flutter/shared/Coloer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'widgit/home_drawer.dart';
import 'widgit/upcoming_products_list.dart';
import 'widgit/grid_product_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Item> favoriteProducts = [];
  List<Item> apiProducts = [];
  bool isLoading = true;
  String searchQuery = ""; // متغيّر الفلترة الأساسي

  Future getProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        List<dynamic> decodedData = json.decode(response.body);
        if (mounted) {
          setState(() {
            apiProducts = decodedData.map((jsonItem) {
              return Item(
                name: jsonItem['title'].toString(),
                price: (jsonItem['price'] is int)
                    ? (jsonItem['price'] as int).toDouble()
                    : jsonItem['price'],
                imgPath: jsonItem['image'].toString(),
              );
            }).toList();
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    // تصفية المنتجات بناءً على النص المخزن القادم من شريط البحث
    List<Item> filteredProducts = apiProducts.where((product) {
      return product.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      drawer: const HomeDrawer(),
      backgroundColor: const Color(
          0xFFF7F2E8), // 🌟 تغيير خلفية الصفحة للون البيج الناعم المتناسق مع الصورة

      // 🛠️ 1. تم إلغاء الـ AppBar التقليدي لتجنب الخط الأحمر تماماً واعتماد الرأس البني المطور
      appBar: null,

      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🌟 2. استدعاء الـ AppBar المطور (الذي يحمل كود السلة والبحث والترحيب معاً كالصورة)
                  CartActionButton(
                    onSearchChanged: (value) {
                      setState(() {
                        searchQuery =
                            value; // تحديث الفلترة فوراً عند الكتابة في شريط البحث
                      });
                    },
                  ),

                  const SizedBox(height: 15),

                  // عنوان Upcoming Products
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Upcoming Products",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(
                                    0xFF5D4A3A))), // لون بني متناسق للعناوين
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllProductsPage(
                                  products: apiProducts,
                                  pageTitle: "Upcoming Products",
                                ),
                              ),
                            );
                          },
                          child: const Text("View all",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFD49A3B))), // لون ذهبي متناسق
                        ),
                      ],
                    ),
                  ),

                  UpcomingProductsList(products: apiProducts),
                  const SizedBox(height: 15),

                  // عنوان Latest Products
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Latest Products",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5D4A3A)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllProductsPage(
                                  products: apiProducts,
                                  pageTitle: "Latest Products",
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD49A3B)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // شبكة المنتجات المصفاة بناءً على البحث
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: filteredProducts.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text("No products found!",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              return GridProductItem(
                                  product: filteredProducts[index]);
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
