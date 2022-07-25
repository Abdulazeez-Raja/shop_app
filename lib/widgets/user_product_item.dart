import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    final product = Provider.of<Product>(context);
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
                arguments: product.id,
              );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              try {
                await Provider.of<Products>(context, listen: false)
                    .deleteProduct(product.id!);
              } catch (error) {
                scaffold.showSnackBar(
                  const SnackBar(
                    content: Text('Deleting failed!'),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
