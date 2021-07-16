import 'dart:io';

import 'package:edge/provider/items_provider.dart';
import 'package:edge/screens/Edit_item_screen.dart';
import 'package:edge/widgets/admin_item.dart';
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
    try {
      Provider.of<ItemsProvider>(context, listen: false)
          .paginateFromAPI(page: 1, limit: 25)
          .whenComplete(() {
        print('done');
      });
    } on HttpException {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('An error occurred!',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              content: Text(
                'Something went wrong! Please try again later.',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay',
                      style: Theme.of(context).textTheme.bodyText1),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            );
          });
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    final itemsProvider = Provider.of<ItemsProvider>(context);
    final list = itemsProvider.items;

    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'edge.',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
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
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                children: [
                  AnimationLimiter(
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
                ],
              ),
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, EditItemScreen.routeName);
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
