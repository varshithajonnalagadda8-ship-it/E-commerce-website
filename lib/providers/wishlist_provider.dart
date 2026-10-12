import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistProvider extends ChangeNotifier {
  final Map<String, Product> _items = {};

  // All wishlist products
  List<Product> get items => _items.values.toList();

  // Wishlist item count
  int get itemCount => _items.length;

  // Check whether product is already in wishlist
  bool isWishlisted(Product product) {
    return _items.containsKey(product.id);
  }

  // Add / Remove product from wishlist
  void toggleWishlist(Product product) {
    if (_items.containsKey(product.id)) {
      _items.remove(product.id);
    } else {
      _items[product.id] = product;
    }

    notifyListeners();
  }

  // Remove one product
  void removeFromWishlist(Product product) {
    _items.remove(product.id);
    notifyListeners();
  }

  // Remove everything
  void clearWishlist() {
    _items.clear();
    notifyListeners();
  }
}
