import 'dart:convert';

import 'package:edge/models/cart_item.dart';
import 'package:edge/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Order findById(String id) {
    return _orders.firstWhere((order) => order.id == id);
  }

  Future<void> placeOrder(
      {@required String userID,
      @required List<CartItem> cart,
      @required double totalAmount}) async {
    final url = 'http://192.168.33.44:3000/api/v1/order/checkout';
    List<Map<String, dynamic>> cartItems = [];
    cart.forEach((item) {
      cartItems.add({
        'itemId': item.id,
        'itemName': item.name,
        'qty': item.quantity,
        'price': item.price,
        'images': item.image,
        'color': item.selectedColor,
        'size': item.selectedSize,
        'seller': item.seller,
        'SubCategory': item.subCategory
      });
    });
    Map<String, dynamic> data = {
      'owner': userID,
      'orders': [
        {
          'order': cartItems,
          'totalPrice': totalAmount,
          'date': '30-6-2021',
        }
      ],
    };
    print(url);
    print(data);

    final body = json.encode(data);
    final response = await http.post(
      Uri.parse(url),
      body: body,
      //headers: {"Content-Type": "application/json"},
    );
    print(response.body);

    notifyListeners();
  }

  Future<void> getUserOrders({@required userID}) async {
    final url = 'http://192.168.33.44:3000/api/v1/order/getorder?owner=$userID';
    print(url);
    List<Order> loadedorders = [];

    final response = await http.get(
      Uri.parse(url),
    );

    final decodedData = json.decode(response.body) as Map<String, dynamic>;

    if (decodedData['status'] == 'error') {
      _orders = [];
    } else {
      final List<dynamic> orders = decodedData['data']['order'];
      List<Map<String, dynamic>> orderItems = [];

      orders.forEach((order) {
        List<CartItem> cartItems = [];
        List<dynamic> orderItems = order['items'];
        orderItems.forEach((cartItem) {
          cartItems.add(CartItem(
            id: cartItem['_id'].toString(),
            quantity: cartItem['qty'],
            name: cartItem['itemName'],
            price: cartItem["price"],
            image: cartItem['images'],
            selectedColor: cartItem['color'],
            selectedSize: cartItem['size'],
            seller: cartItem['seller'],
            subCategory: cartItem['SubCategory'],
          ));
        });
        loadedorders.add(Order(
            id: order['_id'].toString(),
            items: cartItems,
            dateTime: order['datetime'],
            totalPrice: order['totalPrice']));
      });
    }
    notifyListeners();
  }
}
