import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:panow_tech/models/product.dart';
import 'package:panow_tech/ui/control_screen.dart';

class AllProductGrid extends StatefulWidget {
  const AllProductGrid({super.key});

  @override
  State<AllProductGrid> createState() => _AllProductGridState();
}

class _AllProductGridState extends State<AllProductGrid> {
  List<String> categories = ['Keyboard', 'Mouse', 'Headphone'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: categories.length,
      itemBuilder: (ctx, i){
        List<Product> listOfCate = context.read<ProductsManager>().getListProductsByType(categories[i]);
        
        return Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BigText(
                      text: categories[i],
                      size: 18,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chevron_right_rounded,
                        color: primaryCorlor,
                      ),
                    )
                  ],
                ),
              )
            ),
            ListView.builder(
              
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: listOfCate.length,
              itemBuilder: (ctx, index) => HomeProductGridTile(listOfCate[index])
            )
          ],
        );
      
      },
      
    );
  }
}
