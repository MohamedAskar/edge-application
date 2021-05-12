import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edge/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;

class ItemsProvider with ChangeNotifier {
  List<ItemSummary> _items = [];

  List<ItemSummary> get items {
    return [..._items];
  }

  var dio = Dio();

  Future<Item> findById(String id) async {
    var url = 'https://stormy-dawn-26584.herokuapp.com/api/v1/items?_id=$id';
    var response = await dio.get(url);

    final data = response.data as Map<String, dynamic>;

    final dynamic extractedDate = data['data']['items'];
    final Item item = Item(
        id: extractedDate['_id'].toString(),
        name: extractedDate['itemName'],
        price: extractedDate['price'],
        images: extractedDate['images'],
        category: extractedDate['category'],
        avilableColors: extractedDate['availableColors'],
        description: extractedDate['description'],
        seller: extractedDate['seller'],
        sizes: extractedDate['sizes'],
        discount: extractedDate['discount'],
        additionalInformation: extractedDate['additional info']);

    return item;
  }

  Future<void> pagginateFromAPI({int page, int limit}) async {
    var url =
        'https://stormy-dawn-26584.herokuapp.com/api/v1/items?page=$page&limit=$limit';
    List<ItemSummary> loadedItems = [];

    var response = await dio.get(url);

    final data = response.data as Map<String, dynamic>;
    final List<dynamic> extractedItems = data['data']['items'];

    extractedItems.forEach((item) {
      loadedItems.add(ItemSummary(
        id: item['_id'].toString(),
        itemName: item['itemName'],
        price: item['price'],
        image: item['images'][0],
        discount: item['discount'],
      ));
      _items = loadedItems.toSet().toList();
    });
    notifyListeners();
  }

  Future<void> fetchFromAPI() async {
    var url = 'https://edge-graduate.herokuapp.com/api/v1/items';
    List<Item> loadedItems = [];

    var response = await dio.get(url);

    final extractedData = response.data as Map<String, dynamic>;

    final List<dynamic> fetchedItems = extractedData['data']['items'];
    fetchedItems.forEach((item) {
      loadedItems.add(Item(
          id: item['_id'],
          name: item['itemName'],
          price: item['price'],
          images: item['images'],
          category: item['category'],
          avilableColors: item['availableColors'],
          description: item['description'],
          seller: item['seller'],
          sizes: item['sizes'],
          discount: item['discount'],
          additionalInformation: item['additional info']));
    });
    //if (loadedItems.length > _items.length) _items = loadedItems;
    notifyListeners();
  }

  // Future fetchItems() async {
  //   final String response =
  //       await services.rootBundle.loadString('assets/items.json');

  //   final extractedData = json.decode(response) as List<dynamic>;
  //   extractedData.forEach((item) {
  //     _items.add(Item(
  //         id: item['id'],
  //         name: item['itemName'],
  //         price: item['price'],
  //         images: item['images'],
  //         category: item['category'],
  //         avilableColors: item['avilableColors'],
  //         description: item['description'],
  //         seller: item['seller'],
  //         additionalInformation: item['additional info'],
  //         sizes: item['sizes'],
  //         discount: item['discount']));
  //   });
  // }
}
