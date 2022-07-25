import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../providers/orders.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context).fetchAndSetOrders(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return Consumer<Orders>(
            builder: (ctx, ordersData, _) => ListView.builder(
              itemCount: ordersData.orders.length,
              itemBuilder: (ctx, i) {
                return ChangeNotifierProvider.value(
                  value: ordersData.orders[i],
                  child: const OrderItem(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
