import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:panow_tech/models/product.dart';
import 'package:panow_tech/ui/control_screen.dart';

class AdminProductListTile extends StatelessWidget {
  final Product product;
  const AdminProductListTile(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        product.title,
        style: TextStyle(
            fontFamily: 'SFCompactRounded',
            fontWeight: FontWeight.bold,
            color: textCorlor),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            buildEditButton(context),
            buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_outline_outlined),
      onPressed: () {
        context.read<ProductsManager>().deleteProduct(product.id!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Product deleted',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'SFCompactRounded'),
              ),
            ),
          );
      },
      color: Theme.of(context).colorScheme.error,
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.border_color_rounded,
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
          arguments: product.id,
        );
      },
      color: secondCorlor,
    );
  }
}
