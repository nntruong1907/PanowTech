import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:panow_tech/ui/control_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-product';
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final search = ValueNotifier<String>('');
  late Future<void> _fetchProducts;
  List<String> searchList = [
    "Keyboard",
    "logitech 650",
    "Gaming mouse",
    "Keychron K8 Pro"
  ];
  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
    // var listProducts =
    //     context.read<ProductsManager>().getListProductsByType('Headphone');
    // print(listProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded, size: 28.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 30,
        title: searchBox(),
        iconTheme: const IconThemeData(
          color: primaryCorlor,
        ),
        backgroundColor: grey,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: _fetchProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ValueListenableBuilder(
                  valueListenable: search,
                  builder: (context, searchText, child) {
                    if (search.value != '') {
                      return SearchResult(searchText);
                    } else {
                      return SearchRecent();
                    }
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget searchListView(List pairsList) {
    return ListView.builder(
      itemCount: pairsList.length,
      itemBuilder: (ctx, i) {
        return ListTile(
          contentPadding: const EdgeInsets.only(left: 25, right: 20),
          title: Row(
            children: [
              const Icon(Icons.access_time_rounded),
              const SizedBox(width: 10),
              Text(
                pairsList[i],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () {},
              )
            ],
          ),
          onTap: () {
            // Navigator.of(context).pushNamed(
            //   SearchDetailScreen.routeName,
            //   arguments: matchQuery[i],
            // );
          },
        );
      },
    );
  }

  Widget iconSearch() {
    return IconButton(
      onPressed: () {
        SearchResult(search.value);
      },
      icon: const Icon(Icons.search_rounded),
      color: primaryCorlor,
    );
  }

  Widget searchBox() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(
        // margin: const EdgeInsets.only(right: 0.0),
        // alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 2,
            color: primaryCorlor,
          ),
          // color: grey,
        ),
        child: TextField(
          onSubmitted: ((value) {}),
          onChanged: (value) {
            search.value = value;
          },
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: const TextStyle(
              fontFamily: 'SFCompactRounded',
              color: primaryCorlor,
            ),
            border: InputBorder.none,
            // focusedBorder: const UnderlineInputBorder(
            //   borderSide: BorderSide(
            //     color: primaryCorlor,
            //   ),
            // ),
            suffixIcon: iconSearch(),
          ),
        ),
      ),
    );
  }
}
