class Category {
  final String name;
  final String imgPath;

  Category({required this.name, required this.imgPath});

  static int? get length => null;
}

// قائمة تجريبية للتصنيفات
List<Category> allCategories = [
  Category(
      name: "Classic Roses",
      imgPath:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000&auto=format&fit=crop"),
  Category(
      name: "Wedding Bouquets",
      imgPath: "https://images.unsplash.com/photo-1519741497674-611481863552"),
  Category(
      name: "Indoor Plants",
      imgPath: "https://images.unsplash.com/photo-1485955900006-10f4d324d411"),
  Category(
      name: "Gifts",
      imgPath: "https://images.unsplash.com/photo-1513201099705-a9746e1e201f"),
  Category(
      name: "Gifts",
      imgPath: "https://images.unsplash.com/photo-1513201099705-a9746e1e201f"),
];
