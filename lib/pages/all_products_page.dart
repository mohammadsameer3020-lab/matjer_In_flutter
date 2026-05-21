import 'package:flutter/material.dart';
import 'package:first_flutter/model/item.dart';
import 'package:first_flutter/shared/Coloer.dart';
import 'package:first_flutter/pages/widgit/grid_product_item.dart';
import 'package:first_flutter/pages/widgit/search_bar.dart';

class AllProductsPage extends StatefulWidget {
  final List<Item> products;
  final String pageTitle;

  const AllProductsPage({
    super.key,
    required this.products,
    required this.pageTitle,
  });

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // تصفية المنتجات بناءً على ما يكتبه المستخدم في هذه الصفحة
    List<Item> filteredProducts = widget.products.where((product) {
      return product.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        // يعرض اسم القسم ديناميكياً (مثلاً: Upcoming Products أو Latest Products)
        title:
            Text(widget.pageTitle, style: const TextStyle(color: Colors.white)),
        backgroundColor: BTNgreen,
      ),
      body: Column(
        children: [
          // شريط البحث المخصص الذي قمنا بفصله سابقاً لحاله
          CustomSearchBar(
            onSearchChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),

          // شبكة عرض المنتجات المصفاة
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text("No products found!",
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GridView.builder(
                      itemCount: filteredProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        return GridProductItem(
                            product: filteredProducts[index]);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
