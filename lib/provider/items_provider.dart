import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edge/models/item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemsProvider with ChangeNotifier {
  List<ItemSummary> _items = [];

  List<ItemSummary> get items {
    return [..._items];
  }

  Item _item;

  Item get item {
    return _item;
  }

  int totalNoItems = 0;

  List<ItemSummary> _allItems = [];

  List<ItemSummary> get allItems {
    return [..._allItems];
  }

  final dio = Dio();

  Future getAllItems() async {
    List<ItemSummary> allData = [];
    var url = 'http://192.168.33.44/api/v1/items';
    var response = await http.get(Uri.parse(url));
    final data = json.encode(response.body) as Map<String, dynamic>;
    for (var item in data['data']['allItems']) {
      allData.add(ItemSummary(
        id: item['_id'].toString(),
        itemName: item['itemName'],
        price: item['Price'],
        image: item['images'][0],
        discount: item['discount'],
      ));
    }
    _allItems = allData;
    notifyListeners();
  }

  Future<void> findById({String id, String userID}) async {
    var url = 'http://192.168.33.44:3000/api/v1/items/filter?_id=$id';
    List<Item> loadedItems = [];

    final body = {"owner": userID};

    var response = await http.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> extractedDate = data['data']['filteredItems'];
    extractedDate.forEach((item) {
      loadedItems.add(Item(
        id: item['_id'].toString(),
        name: item['itemName'],
        price: item['Price'],
        images: item['images'],
        category: item['Category'],
        subcategory: item['SubCategory'],
        avilableColors: item['availableColors'],
        description: item['Description'],
        seller: item['Seller'],
        sizes: item['AvailableSizes'],
      ));
    });
    _item = loadedItems.toSet().toList().first;
    notifyListeners();
  }

  Future<void> paginateFromAPI({
    @required int page,
    @required int limit,
    String subcategory,
    String category,
  }) async {
    String url;
    if (subcategory != null && category == null) {
      url =
          'http://192.168.33.44:3000/api/v1/items/paginate?SubCategory=$subcategory&page=$page&limit=$limit';
    }
    if (category != null) {
      url =
          'http://192.168.33.44:3000/api/v1/items/paginate?SubCategory=$subcategory&Category=$category&page=$page&limit=$limit';
    }
    if (category == null && subcategory == null) {
      url =
          'http://192.168.33.44:3000/api/v1/items/paginate?page=$page&limit=$limit';
    }

    print(url);

    List<ItemSummary> loadedItems = [];

    var response = await http.get(Uri.parse(url));
    //print(response.data);

    _items = [];
    final data = json.decode(response.body) as Map<String, dynamic>;
    totalNoItems = data['results'];
    final List<dynamic> extractedItems = data['data']['paginatedItems'];
    extractedItems.forEach((item) {
      loadedItems.add(ItemSummary(
        id: item['_id'].toString(),
        itemName: item['itemName'],
        price: item['Price'],
        image: item['images'][0],
        discount: "",
      ));
      _items = loadedItems.toSet().toList();
    });
    notifyListeners();
  }

  // Future<void> fetchFromAPI() async {
  //   var url = 'https://edge-graduate.herokuapp.com/api/v1/items';
  //   List<Item> loadedItems = [];

  //   var response = await dio.get(url);

  //   final extractedData = response.data as Map<String, dynamic>;

  //   final List<dynamic> fetchedItems = extractedData['data']['items'];
  //   fetchedItems.forEach((item) {
  //     loadedItems.add(Item(
  //         id: item['_id'].toString(),
  //         name: item['itemName'],
  //         price: item['Price'],
  //         images: item['images'],
  //         category: item['Category'],
  //         subcategory: item['SubCategory'],
  //         avilableColors: item['availableColors'],
  //         description: item['Description'],
  //         seller: item['Seller'],
  //         sizes: item['AvailavleSizes'],
  //         discount: item['discount'],
  //         additionalInformation:
  //             "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."));
  //   });
  //   //if (loadedItems.length > _items.length) _items = loadedItems;
  //   notifyListeners();
  // }

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
