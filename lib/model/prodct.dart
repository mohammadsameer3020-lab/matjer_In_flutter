class brodct {
  final String imgPath;
  final double price;
  final String location;
  final String name;

  brodct({
    required this.imgPath,
    required this.price,
    this.location = "Flower Shop",
    required this.name, // تم تعديلها لتكون مطلوبة وممررة بشكل صحيح
  });
}

final List<brodct> items = [
  brodct(
      imgPath:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000&auto=format&fit=crop",
      price: 11.99, // تم تبسيط الرقم ليكون منطقياً كـ double
      name: "Rose"),
  brodct(
      imgPath:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000&auto=format&fit=crop",
      price: 12.99,
      name: "Tulip"),
  brodct(
      imgPath:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000&auto=format&fit=crop",
      price: 12.99,
      name: "Lily"),
  brodct(
      imgPath:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000&auto=format&fit=crop",
      price: 12.99,
      name: "Daisy"),
];
