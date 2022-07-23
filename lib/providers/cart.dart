import 'package:flutter/foundation.dart';

import '../models/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.isEmpty ? 0 : _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach(
      (key, value) {
        total += value.price * value.quantity;
      },
    );

    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => Cart(
          id: value.id,
          title: value.title,
          quantity: value.quantity + 1,
          price: value.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => Cart(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
