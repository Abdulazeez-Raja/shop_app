import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

import '../models/cart.dart';

class ItemCart extends StatelessWidget {
  const ItemCart({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      confirmDismiss: (value) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to remove item from the cart?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('NO'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('YES '),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (d) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      key: ValueKey(cart.id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text('\$${cart.price}'),
                ),
              ),
            ),
            title: Text(cart.title),
            subtitle: Text('Total: \$${cart.price * cart.quantity}'),
            trailing: Text('${cart.quantity} X'),
          ),
        ),
      ),
    );
  }
}
