import 'package:flutter/material.dart';

class ItemSummary with ChangeNotifier {
  final String id;
  final String itemName;
  final dynamic price;
  final String image;
  final dynamic discount;

  ItemSummary({
    @required this.id,
    @required this.itemName,
    @required this.image,
    @required this.discount,
    @required this.price,
  });
}

class Item with ChangeNotifier {
  final String id;
  final String name;
  final dynamic price;
  final List<dynamic> images;
  final String category;
  final List<dynamic> avilableColors;
  final String description;
  final dynamic discount;
  final String seller;
  final String additionalInformation;
  final List<dynamic> sizes;

  Item({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.images,
    @required this.category,
    @required this.avilableColors,
    @required this.description,
    @required this.seller,
    @required this.sizes,
    this.additionalInformation,
    this.discount,
  });
}
