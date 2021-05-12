import 'package:edge/models/cart_item.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _cartItem = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItem};
  }

  double _totalAmount = 0.0;
  int _totalQuantity = 0;

  double get totalAmount {
    return double.parse(_totalAmount.toStringAsFixed(2));
  }

  int get totalQuantity {
    return _totalQuantity;
  }

  void addToCart(CartItem cartItem) {
    if (_cartItem.containsKey(cartItem.id)) {
      _cartItem.update(
          cartItem.id,
          (existingItem) => CartItem(
              id: existingItem.id,
              quantity: existingItem.quantity + 1,
              name: existingItem.name,
              price: existingItem.price,
              image: existingItem.image,
              selectedColor: cartItem.selectedColor,
              selectedSize: cartItem.selectedSize,
              seller: existingItem.seller));

      print('Item updated');
    } else {
      _cartItem.putIfAbsent(
          cartItem.id,
          () => CartItem(
              id: cartItem.id,
              quantity: cartItem.quantity,
              name: cartItem.name,
              price: cartItem.price,
              image: cartItem.image,
              selectedColor: cartItem.selectedColor,
              selectedSize: cartItem.selectedSize,
              seller: cartItem.seller));

      print('item added');
    }
    print(cartItems.length);
    notifyListeners();
  }

  void removeItem(String id) {
    _cartItem.remove(id);
  }
}
