import 'dart:convert';

import 'package:edge/models/item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemsProvider with ChangeNotifier {
  List<ItemSummary> _items = [];
  List<ItemSummary> _recommendations = [];
  List<ItemSummary> _wishlist = [];
  Item _item;
  int totalNoItems = 0;

  List<ItemSummary> get items {
    return [..._items];
  }

  List<ItemSummary> get recommendations {
    return [..._recommendations];
  }

  List<ItemSummary> get wishlist {
    return [..._wishlist];
  }

  Item get item {
    return _item;
  }

  static const URL = 'http://192.168.173.44:3000';

  Future<void> getAllData() async {
    var url = '$URL/api/v1/items';

    print(url);

    List<ItemSummary> loadedItems = [];

    try {
      var response = await http.get(Uri.parse(url));

      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> extractedItems = data['data']['allItems'];
      extractedItems.forEach((item) {
        loadedItems.add(ItemSummary(
          id: item['_id'].toString(),
          itemName: item['itemName'],
          price: item['Price'],
          image: item['images'][0],
        ));
      });
      _items = loadedItems;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> findById({String id, String userID}) async {
    var url = '$URL/api/v1/items/filter?_id=$id';
    List<Item> loadedItems = [];

    final body = {"owner": userID};

    try {
      var response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
      );

      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> extractedDate = data['data']['filteredItems'];
      extractedDate.forEach((item) {
        loadedItems.add(
          Item(
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
            isFavorite: data['favorite'],
          ),
        );
      });

      _item = loadedItems.toSet().toList().first;
    } catch (e) {
      throw e;
    }
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
          '$URL/api/v1/items/paginate?SubCategory=$subcategory&page=$page&limit=$limit';
    }
    if (category != null) {
      url =
          '$URL/api/v1/items/paginate?SubCategory=$subcategory&Category=$category&page=$page&limit=$limit';
    }
    if (category == null && subcategory == null) {
      url = '$URL/api/v1/items/paginate?page=$page&limit=$limit';
    }

    print(url);

    List<ItemSummary> loadedItems = [];

    try {
      var response = await http.get(Uri.parse(url));
      //print(response.data);

      _items = [];
      final data = json.decode(response.body) as Map<String, dynamic>;
      totalNoItems = data['results'];
      print(totalNoItems);
      final List<dynamic> extractedItems = data['data']['paginatedItems'];
      extractedItems.forEach((item) {
        loadedItems.add(ItemSummary(
          id: item['_id'].toString(),
          itemName: item['itemName'],
          price: item['Price'],
          image: item['images'][0],
        ));
        _items = loadedItems.toSet().toList();
      });
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> addToWishlist({@required Item item, @required userID}) async {
    final url = '$URL/api/v1/favorite';
    Map<String, dynamic> data = {
      'owner': userID,
      'items': [
        {
          'itemId': item.id,
          'itemName': item.name,
          'price': item.price,
          'images': item.images,
          'color': item.avilableColors,
          'size': item.sizes,
          'seller': item.seller,
          'SubCategory': item.subcategory
        }
      ]
    };
    print(url);
    print(data);
    try {
      final body = json.encode(data);
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {"Content-Type": "application/json"},
      );
      print(response.body);

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> getWishList({@required String userID}) async {
    final url = '$URL/api/v1/favorite?owner=$userID';
    print(url);
    List<ItemSummary> loadedItems = [];

    try {
      final response = await http.get(
        Uri.parse(url),
      );

      final decodedData = json.decode(response.body) as Map<String, dynamic>;
      print(decodedData);

      final List<dynamic> extractedData = decodedData['data']['items'];
      if (extractedData == []) {
        _wishlist = [];
      } else {
        extractedData.forEach((item) {
          loadedItems.add(ItemSummary(
            id: item['itemId'].toString(),
            itemName: item['itemName'],
            price: item['price'],
            image: item['images'][0],
          ));
        });
      }
      _wishlist = loadedItems;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> removeWishlist({@required userID, @required itemID}) async {
    final url = '$URL/api/v1/favorite';

    final body = json.encode(
      {'owner': userID, 'itemId': itemID},
    );

    print(body);
    try {
      final response = await http.delete(
        Uri.parse(url),
        body: body,
        headers: {"Content-Type": "application/json"},
      );

      print(response.body);
      getWishList(userID: userID);
      findById(id: itemID, userID: userID);
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> getUserRecommendations({String userID}) async {
    final url = '$URL/api/v1/akin';
    List<ItemSummary> loadedItems = [];

    final body = json.encode({
      'owner': userID,
      'samples': 12,
    });
    print(body);
    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {"Content-Type": "application/json"},
      );

      final decodedData = json.decode(response.body) as Map<String, dynamic>;

      final List<dynamic> extractedData = decodedData['recommendations'];

      extractedData.forEach((recommendedItem) {
        loadedItems.add(ItemSummary(
          id: recommendedItem['_id'].toString(),
          itemName: recommendedItem['itemName'],
          price: recommendedItem['Price'],
          image: recommendedItem['images'][0],
        ));
      });

      _recommendations = loadedItems;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }
}
