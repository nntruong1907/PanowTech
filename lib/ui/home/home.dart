import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:panow_tech/models/product.dart';
import 'package:panow_tech/ui/control_screen.dart';


class HomePageScreen extends StatefulWidget {
  static const routeName = '/homepage';
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<String> categories = ['Keyboard', 'Mouse', 'Headphone'];
  String category = 'Keyboard';
  int selectedPage = 0;
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
            'Panow Tech',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          buildSearchIcon(),
          buildShoppingCartIcon(),
        ],
      ),
      // drawer: const AppDrawer(),
      body: FutureBuilder(
          future: _fetchProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var products = context
                  .read<ProductsManager>()
                  .getListProductsByType(category);
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text(
                              'Categories',
                              style: TextStyle(
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Text(
                                  'See all',
                                  style: TextStyle(
                                    color: secondCorlor,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: secondCorlor),
                                  child: const Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 14,
                                      color: white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      //Các danh mục
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            ...List.generate(
                              categories.length,
                              (index) => Padding(
                                padding: index == 0
                                    ? const EdgeInsets.symmetric(horizontal: 20)
                                    : const EdgeInsets.only(right: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      category = categories[index];
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: categories[index] == category
                                          ? primaryCorlor
                                          : white,
                                      boxShadow: [
                                        categories[index] == category
                                            ? const BoxShadow(
                                                offset: Offset(0, 5),
                                                color: primaryCorlor,
                                                spreadRadius: 0,
                                                blurRadius: 10)
                                            : const BoxShadow(color: white)
                                      ],
                                    ),
                                    child: Text(
                                      categories[index],
                                      style: TextStyle(
                                          color: categories[index] == category
                                              ? white
                                              : black,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      //Sản phẩm
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text(
                              'Products',
                              style: TextStyle(
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Text(
                                  'See all',
                                  style: TextStyle(
                                    color: secondCorlor,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProductsOverviewScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: secondCorlor),
                                    child: const Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        size: 14,
                                        color: white),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) =>
                              HomeProductGridTile(products[index])),
                      // )
                    ],
                  ),
                ),
              );
              return Column(
                // child: Column(
                children: [
                  // Banner
                  const SizedBox(height: 20),
                  BannerScreen(),

                  //Categories
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Text(
                              'See all',
                              style: TextStyle(
                                color: secondCorlor,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: secondCorlor),
                              child: const Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  size: 14,
                                  color: white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Các danh mục
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        ...List.generate(
                          categories.length,
                          (index) => Padding(
                            padding: index == 0
                                ? const EdgeInsets.symmetric(horizontal: 20)
                                : const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  category = categories[index];
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: categories[index] == category
                                      ? primaryCorlor
                                      : white,
                                  boxShadow: [
                                    categories[index] == category
                                        ? const BoxShadow(
                                            offset: Offset(0, 5),
                                            color: primaryCorlor,
                                            spreadRadius: 0,
                                            blurRadius: 10)
                                        : const BoxShadow(color: white)
                                  ],
                                ),
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                      color: categories[index] == category
                                          ? white
                                          : black,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //Sản phẩm
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text(
                          'Products',
                          style: TextStyle(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Text(
                              'See all',
                              style: TextStyle(
                                color: secondCorlor,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductsOverviewScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: secondCorlor),
                                child: const Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    size: 14,
                                    color: white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: products.length,
                        itemBuilder: (context, index) =>
                            HomeProductGridTile(products[index])),
                  )
                ],
                // ),
              );
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

          // data: 1,
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

  Widget productItem(BuildContext context, Product product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: MediaQuery.of(context).size.height * .35,
        width: MediaQuery.of(context).size.width * .6,
        color: white,
        child: Stack(
          children: [
            Positioned(
              bottom: -10,
              right: 20,
              child: Image.asset(
                product.imageUrl,
                height: MediaQuery.of(context).size.height * .25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSlideCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          color: primaryCorlor.withOpacity(.6),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 40,
                    color: orange200,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 28,
                          height: 273,
                          child: SvgPicture.asset(
                            "assets/panow.svg",
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
