import 'package:flutter/material.dart';
import '../../home/data/models/product_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Product> _favoriteItems = [];

  List<Product> get favoriteItems => _favoriteItems;

  bool isFavorite(Product product) {
    return _favoriteItems.any(
      (item) => item.id == product.id,
    );
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      _favoriteItems.removeWhere(
        (item) => item.id == product.id,
      );
    } else {
      _favoriteItems.add(product);
    }

    notifyListeners();
  }
}
