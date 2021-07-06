import 'dart:convert';

import 'package:edge/models/item.dart';
import 'package:edge/provider/items_provider.dart';
import 'package:edge/widgets/admin_item.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductsScreen extends StatefulWidget {
  static const routeName = 'manage';
  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  var isLoading = false;
  ItemsProvider itemsProvider;

  // Future<void> _refreshProducts(BuildContext context) async {
  //   await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  // }

  @override
  void initState() {
    itemsProvider = Provider.of<ItemsProvider>(context, listen: false);
    final getData =
        itemsProvider.paginateFromAPI(limit: 8, page: 1).whenComplete(() {
      print('done');
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    final list = itemsProvider.items;

    print(list.length);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: EdgeAppBar(cart: false, profile: true, search: true),
      ),
      body: (list.isEmpty)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10.0),
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, i) => AdminItem(
                      title: list[i].itemName,
                      imageUrl: list[i].image,
                      price: list[i].price.toString())),
            ),
    );
  }
}
