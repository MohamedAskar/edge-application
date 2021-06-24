import 'package:dio/dio.dart';
import 'package:edge/models/item.dart';
import 'package:flutter/material.dart';

class ItemsProvider with ChangeNotifier {
  List<ItemSummary> _items = [];

  List<ItemSummary> get items {
    return [..._items];
  }

  Item _item;

  Item get item {
    return _item;
  }

  final dio = Dio();

  Future<void> findById(String id) async {
    var url = 'https://sleepy-lake-90434.herokuapp.com/api/v1/items?_id=$id';
    List<Item> loadedItems = [];

    var response = await dio.get(url);
    final data = response.data as Map<String, dynamic>;
    final List<dynamic> extractedDate = data['data']['items'];
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

  Future<void> pagginateFromAPI({int page, int limit}) async {
    var url =
        'https://sleepy-lake-90434.herokuapp.com/api/v1/items?page=$page&limit=$limit';
    List<ItemSummary> loadedItems = [];

    var response = await dio.get(url);

    final data = response.data as Map<String, dynamic>;
    final List<dynamic> extractedItems = data['data']['items'];
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
