import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:panow_tech/models/product.dart';
import 'package:panow_tech/ui/control_screen.dart';

class AllProductAGrid extends StatelessWidget {
  final bool showFavorites;

  const AllProductAGrid(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.select<ProductsManager, List<Product>>(
      (productsManager) => showFavorites
      ? productsManager.favoriteItems
      : productsManager.items
    );
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => HomeProductGridTile(products[i])
    );
  }
}