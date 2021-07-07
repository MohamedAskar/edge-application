import 'package:flutter/material.dart';

class ItemSummary with ChangeNotifier {
  final String id;
  final String itemName;
  final dynamic price;
  final String image;
  final dynamic discount;
  final String category;
  final String subcategory;
  final String description;

  ItemSummary({
    @required this.id,
    @required this.itemName,
    @required this.image,
    this.category,
    this.description,
    this.subcategory,
    this.discount,
    @required this.price,
  });
}

class Item with ChangeNotifier {
  final String id;
  final String name;
  final dynamic price;
  final List<dynamic> images;
  final String category;
  final String subcategory;
  final List<dynamic> avilableColors;
  final String description;
  final dynamic discount;
  final String seller;
  final String additionalInformation;
  final List<dynamic> sizes;
  bool isFavorite;

  Item({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.images,
    @required this.category,
    @required this.subcategory,
    @required this.avilableColors,
    @required this.description,
    @required this.seller,
    @required this.sizes,
    this.isFavorite,
    this.additionalInformation,
    this.discount,
  });
}
