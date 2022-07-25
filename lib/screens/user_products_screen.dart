import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';
  const UserProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProduct();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: products.items[i],
              child: const UserProductItem(),
            ),
          ),
        ),
      ),
    );
  }
}
