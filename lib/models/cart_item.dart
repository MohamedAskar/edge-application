import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final dynamic price;
  int quantity;
  final String image;
  final String selectedColor;
  final String seller;
  final String selectedSize;

  CartItem({
    @required this.id,
    @required this.quantity,
    @required this.name,
    @required this.price,
    @required this.image,
    @required this.selectedColor,
    @required this.selectedSize,
    @required this.seller,
  });
}
