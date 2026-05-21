import 'package:first_flutter/model/item.dart'; // تأكد من استيراد كلاس Item
import 'package:first_flutter/model/itemeCategries.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter/shared/Coloer.dart';
import 'package:first_flutter/shared/Appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BTNgreen,
        title: const Text("Categories", style: TextStyle(color: Colors.white)),
        actions: const [CartActionButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          itemCount: allCategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StorePage(
                      categoryName: allCategories[index].name,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(allCategories[index].imgPath),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    allCategories[index].name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ✅ تم تحويلها لـ StatefulWidget لجلب بيانات الـ API
class StorePage extends StatefulWidget {
  final String categoryName;
  const StorePage({super.key, required this.categoryName});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  Future<List<Item>> getProducts() async {
    final response = await http.get(Uri.parse(
        'https://fakestoreapi.com/products/category/${widget.categoryName.toLowerCase()}'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((item) => Item(
                name: item['title'],
                price: (item['price'] as num).toDouble(),
                imgPath: item['image'],
              ))
          .toList();
    }
    throw Exception('Error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BTNgreen,
        title: Text(widget.categoryName),
      ),
      body: FutureBuilder<List<Item>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return Card(
                  child: Column(children: [
                Expanded(child: Image.network(item.imgPath)),
                Text(item.name, maxLines: 1),
                Text("\$${item.price}")
              ]));
            },
          );
        },
      ),
    );
  }
}
