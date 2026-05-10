import 'package:first_flutter/model/itemeCategries.dart';
import 'package:first_flutter/pages/Protect.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter/shared/Coloer.dart';
import 'package:first_flutter/shared/Appbar.dart';
// تأكد من استيراد صفحة الهوم أو المتجر هنا لكي يعمل الـ Navigator
// import 'package:first_flutter/pages/home.dart';

class CategoriesPage extends StatelessWidget {
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
                // ✅ هنا نطبق منطق الانتقال وتمرير الاسم
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Protect(
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
                      fontWeight: FontWeight.bold,
                    ),
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

// ✅ هذه هي الشاشة "المستقبلة" للبيانات (ضعها في ملف منفصل أفضل)
class StorePage extends StatelessWidget {
  final String categoryName;

  const StorePage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BTNgreen,
        title: Text(categoryName), // سيعرض اسم القسم المختار
      ),
      body: Center(
        child: Text("Displaying items for: $categoryName"),
      ),
    );
  }
}
