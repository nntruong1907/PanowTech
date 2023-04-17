import 'package:flutter/foundation.dart';

import 'package:panow_tech/models/auth_token.dart';
import 'package:panow_tech/models/product.dart';
import 'package:panow_tech/services/product_service.dart';

class ProductsManager with ChangeNotifier {
  List<Product> _items = [];

  final ProductsService _itemsService;

  ProductsManager([AuthToken? authToken])
      : _itemsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _itemsService.authToken = authToken;
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items = await _itemsService.fetchProducts(filterByUser);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _itemsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      if (await _itemsService.updateProduct(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Product? existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _itemsService.deleteProduct(id)) {
      _items.insert(index, existingProduct);
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Product product) async {
    final savedStatus = product.isFavorite;
    product.isFavorite = !savedStatus;

    if (!await _itemsService.saveFavoriteStatus(product)) {
      product.isFavorite = savedStatus;
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  bool isExistInList(List<Product> list, Product product) {
    // int num = list.length;
    for (var e in list) {
      if (e.id == product.id) {
        return true;
      }
    }
    return false;
  } 

  List<Product> getListProducts() {
    return _items.toList();
  }

  List<Product> getListProductsByType(String name) {
    return _items.where((product) => product.type == name).toList();
  }

  List<Product> searchProduct(String name) {
    return _items
        .where((product) =>
            product.title.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }
  Product? findById(String id) {
    try {
      return _items.firstWhere((element) => element.id == id);
    } catch (error) {
      return null;
    }
  }
}
