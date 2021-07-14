import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edge/models/cart_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems {
    return [..._cartItems];
  }

  dynamic _totalAmount = 0;
  int _totalQuantity = 0;

  final dio = new Dio();

  dynamic get totalAmount {
    return double.parse(_totalAmount.toStringAsFixed(2));
  }

  int get totalQuantity {
    return _totalQuantity;
  }

  static const URL = 'http://192.168.189.44:3000';

  Future<void> getTotalQty({@required String userID}) async {
    var qty = 0;
    final url = '$URL/api/v1/cart/qty?owner=$userID';
    print(url);

    var response = await http.get(Uri.parse(url));
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    print(responseData);

    if (responseData['status'] == 'error') {
      qty = 0;
    } else {
      qty = responseData['quantity'];
    }

    _totalQuantity = qty;
    notifyListeners();
  }

  Future<void> addToCart({@required CartItem item, @required userID}) async {
    final url = '$URL/api/v1/cart';
    Map<String, dynamic> data = {
      'owner': userID,
      'items': {
        'itemId': item.id,
        'itemName': item.name,
        'qty': item.quantity,
        'price': item.price,
        'images': item.image,
        'color': item.selectedColor,
        'size': item.selectedSize,
        'seller': item.seller,
        'SubCategory': item.subCategory
      }
    };
    final body = json.encode(data);
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    getTotalQty(userID: userID);

    notifyListeners();
  }

  Future<void> getCartItems({@required String userID}) async {
    final url = '$URL/api/v1/cart/getcart?owner=$userID';
    print(url);
    List<CartItem> loadedItems = [];

    final response = await http.get(
      Uri.parse(url),
    );

    final decodedData = json.decode(response.body) as Map<String, dynamic>;
    print(decodedData);

    final List<dynamic> extractedData = decodedData['data']['items'];
    if (extractedData == []) {
      _cartItems = [];
      _totalAmount = 0.0;
    } else {
      extractedData.forEach((cartItem) {
        if (cartItem != null) {
          loadedItems.add(
            CartItem(
              id: cartItem['itemId'].toString(),
              quantity: cartItem['qty'],
              name: cartItem['itemName'],
              price: cartItem["price"],
              image: cartItem['images'],
              selectedColor: cartItem['color'],
              selectedSize: cartItem['size'],
              seller: cartItem['seller'],
              subCategory: cartItem['SubCategory'],
            ),
          );
        }
      });
      _totalAmount = decodedData['data']['totalPrice'];
      _cartItems = loadedItems;
    }
    notifyListeners();
  }

  Future<void> removeItem(
      {@required String itemID,
      @required String userID,
      @required String color,
      @required String size}) async {
    //_cartItems.remove(id);
    final url = '$URL/api/v1/cart';

    final body = json.encode(
      {
        'owner': userID,
        'itemId': itemID,
        "color": color,
        "size": size,
      },
    );

    print(body);
    final response = await http.delete(
      Uri.parse(url),
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    print(response.body);
    getCartItems(userID: userID);
    getTotalQty(userID: userID);
    notifyListeners();
  }
}
