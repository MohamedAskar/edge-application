import 'dart:convert';

import 'package:edge/models/cart_item.dart';
import 'package:edge/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  static const URL = 'https://evening-cliffs-75470.herokuapp.com';

  Order findById(String id) {
    return _orders.firstWhere((order) => order.id == id);
  }

  Future<void> placeOrder(
      {@required String userID,
      @required List<CartItem> cart,
      @required double totalAmount}) async {
    final url = '$URL/api/v1/order/checkout';
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
    final orderID = UniqueKey().toString();
    Map<String, dynamic> data = {
      'owner': userID,
      'orders': [
        {
          'orderID':
              'EDG0021${orderID.substring(2, orderID.length - 1).toUpperCase()}',
          'order': cartItems,
          'totalPrice': totalAmount,
          'date': DateFormat("EEE, MMM dd").format(DateTime.now()),
        }
      ],
    };
    print(url);

    final body = json.encode(data);
    print(body);
    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {"Content-Type": "application/json"},
      );
      print(response.body);
    } catch (e) {
      throw e;
    }

    notifyListeners();
  }

  Future<void> getUserOrders({@required userID}) async {
    final url = '$URL/api/v1/order/getorder?owner=$userID';
    print(url);
    List<Order> loadedorders = [];

    try {
      final response = await http.get(
        Uri.parse(url),
      );

      final decodedData = json.decode(response.body) as Map<dynamic, dynamic>;

      if (decodedData['data'].isEmpty) {
        _orders = [];
      } else {
        final List<dynamic> orders = decodedData['data'][0]['orders'];

        orders.forEach((order) {
          List<CartItem> cartItems = [];
          List<dynamic> orderItems = order['order'];
          orderItems.forEach((cartItem) {
            cartItems.add(CartItem(
              id: cartItem['itemId'].toString(),
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
              id: order['orderID'],
              items: cartItems,
              dateTime: order['date'],
              totalPrice: order['totalPrice']));
        });
      }
      print(loadedorders.length);
      _orders = loadedorders;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }
}
