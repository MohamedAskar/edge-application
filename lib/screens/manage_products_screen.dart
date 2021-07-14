import 'dart:convert';

import 'package:edge/models/item.dart';
import 'package:edge/provider/items_provider.dart';
import 'package:edge/widgets/admin_item.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
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
    Provider.of<ItemsProvider>(context, listen: false)
        .getAllData()
        .whenComplete(() {
      print('done');
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    final itemsProvider = Provider.of<ItemsProvider>(context);
    final list = itemsProvider.items;

    print(list.length);
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('edge.', style: Theme.of(context).textTheme.headline1),
        actions: [
          IconButton(
            icon: Icon(Ionicons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: (list.isEmpty)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: AnimationLimiter(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10.0),
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) =>
                        AnimationConfiguration.staggeredList(
                          position: i,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: AdminItem(
                                  title: list[i].itemName,
                                  imageUrl: list[i].image,
                                  price: list[i].price.toString()),
                            ),
                          ),
                        )),
              ),
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, 'routeName');
        },
        label: Text(
          'ADD ITEM',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: Icon(Ionicons.add),
      ),
    );
  }
}
