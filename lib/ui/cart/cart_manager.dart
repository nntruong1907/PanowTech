import 'package:flutter/foundation.dart';

import 'package:panow_tech/models/cart_item.dart';
import 'package:panow_tech/models/product.dart';

class CartManager with ChangeNotifier {
  Map<String, CartItem> _items = {
  };

  int get productCount {
    return _items.length;
  }

  List<CartItem> get products {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product, n) {
    int num = n;
    if (_items.containsKey(product.id)) {
      // change quantity...
      _items.update(
        product.id!,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity + num,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id!,
        () => CartItem(
            id: 'c${DateTime.now().toIso8601String()}',
            title: product.title,
            quantity: num,
            imageUrl: product.imageUrl,
            price: product.price),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity as num > 1) {
      _items.update(
        productId,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
