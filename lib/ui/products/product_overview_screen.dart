import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:panow_tech/ui/control_screen.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Products",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          buildSearchIcon(),
          buildProductFilterMenu(),
          buildShoppingCartIcon(),
        ],
      ),
      body: FutureBuilder(
          // print(listProducts);
          future: _fetchProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ValueListenableBuilder<bool>(
                  valueListenable: _showOnlyFavorites,
                  builder: (context, onlyFavorites, child) {
                    if (_showOnlyFavorites.value) {
                      return AllProductAGrid(onlyFavorites);
                    } else {
                      return AllProductGrid();
                    }
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (ctx, cartManager, child) {
        final cart = context.watch<CartManager>();
        final total = cart.productCount;
        return TopRightBadge(
          data: total,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart_rounded,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        );
      },
    );
  }

  Widget buildSearchIcon() {
    return IconButton(
      icon: const Icon(Icons.search_rounded),
      onPressed: () {
        Navigator.of(context).pushNamed(
          SearchScreen.routeName,
        );
      },
    );
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        if (selectedValue == FilterOptions.favorites) {
          _showOnlyFavorites.value = true;
        } else {
          _showOnlyFavorites.value = false;
        }
      },
      icon: const Icon(
        Icons.more_vert_rounded,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: ListTile(
            leading: Icon(
              Icons.favorite_rounded,
            ),
            title: Text(
              "Only Favorites",
            ),
          ),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text(
              "Show All",
            ),
          ),
        ),
      ],
    );
  }
}
