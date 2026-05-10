class Item {
  final String imgPath;
  final double price;
  final String location;
  final String name;

  Item({
    required this.imgPath,
    required this.price,
    this.location = "Flower Shop",
    required this.name, // تم تعديلها لتكون مطلوبة وممررة بشكل صحيح
  });
}

final List<Item> items = [
  Item(
      imgPath:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000&auto=format&fit=crop",
      price: 11.99, // تم تبسيط الرقم ليكون منطقياً كـ double
      name: "Rose"),
  Item(
      imgPath:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000&auto=format&fit=crop",
      price: 12.99,
      name: "Tulip"),
  Item(
      imgPath:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000&auto=format&fit=crop",
      price: 12.99,
      name: "Lily"),
  Item(
      imgPath:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000&auto=format&fit=crop",
      price: 12.99,
      name: "Daisy"),
];
