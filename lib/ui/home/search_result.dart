import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:panow_tech/ui/control_screen.dart';

class SearchResult extends StatelessWidget {
  final String searchText;

  const SearchResult(this.searchText, {super.key});

  @override
  Widget build(BuildContext context) {
    var listProducts =
        context.read<ProductsManager>().searchProduct(searchText);
    return ListView.builder(
        padding: const EdgeInsets.only(top: 10.0),
        itemCount: listProducts.length,
        itemBuilder: (ctx, i) => HomeProductGridTile(listProducts[i]));
  }
}
