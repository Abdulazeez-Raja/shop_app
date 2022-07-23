import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/orders_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'bw',
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
      ),
      home: const ProductsOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
        CartScreen.routeName: (ctx) => const CartScreen(),
        OrdersScreen.routeName: (ctx) => const OrdersScreen(),
      },
    );
  }
}
