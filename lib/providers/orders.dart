import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';
import '../models/order.dart';

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<Cart> cartProduct, double total) async {
    final url = Uri.https(
        'todoor-49ebd-default-rtdb.europe-west1.firebasedatabase.app',
        '/orders.json');
    final timestamp = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'amount': total,
            'products': cartProduct
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'price': e.price,
                      'quantity': e.quantity,
                    })
                .toList(),
            'dateTime': timestamp.toIso8601String(),
          },
        ),
      );

      _orders.insert(
        0,
        Order(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProduct,
          dateTime: timestamp,
        ),
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.https(
        'todoor-49ebd-default-rtdb.europe-west1.firebasedatabase.app',
        '/orders.json');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<Order> loadedProduct = [];
    if (extractedData == null) {
      return;
    }
    extractedData.forEach(
      (key, value) {
        loadedProduct.add(
          Order(
            id: key,
            amount: value['amount'],
            products: (value['products'] as List<dynamic>)
                .map(
                  (e) => Cart(
                    id: e['id'],
                    title: e['title'],
                    quantity: e['quantity'],
                    price: e['price'],
                  ),
                )
                .toList(),
            dateTime: DateTime.parse(
              value['dateTime'],
            ),
          ),
        );
      },
    );
    _orders = loadedProduct.reversed.toList();
  }
}
