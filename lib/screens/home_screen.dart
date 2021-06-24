import 'dart:async';

import 'package:dio/dio.dart';
import 'package:edge/models/item.dart';
import 'package:edge/provider/items_provider.dart';
import 'package:edge/screens/profile_screen.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:edge/widgets/carousel.dart';
import 'package:edge/widgets/category_widget.dart';
import 'package:edge/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'Home-Screen';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1624209297/Men/Summer/19/4241932250_2_3_8_uhogxg.jpg',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1624209179/Men/Summer/24/4685511407_2_3_8_od7lsp.webp',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1624209420/Men/Summer/23/4470513401_2_1_8_owrmmi.webp',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1618873404/Women/Straight%20Jean%20Trousers/Screenshot_647_gqwewr.png',
  ];

  final List canvas = [
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622331736/Canvas/White_Simple_We_Are_Open_Instagram_Post_aqgcur.png',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622332517/Canvas/New_Collection_Instagram_Post_1_sqfaat.png',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622332415/Canvas/logo_1_sedqvu.gif',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622333549/Canvas/Copy_of_Shop_New_Arrivals_Collage_Instagram_Post_kjbci5.png',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622334438/Canvas/Vibrant_Etsy_Shop_Icon_1_hglgdp.png',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622331707/Canvas/Orange_and_Green_Geometric_Apparel_Store_Flyer_vhw2cm.png'
  ];

  List category = ['T-SHIRTS', 'JEANS', 'SHIRTS', 'PANTS'];

  List<Item> listsearch = [];
  ItemsProvider itemData;
  Future fetchedItems;

  Future getData() async {
    var url = 'https://sleepy-lake-90434.herokuapp.com/api/v1/items';
    var response = await Dio().get(url);
    final data = response.data as Map<String, dynamic>;
    for (var item in data['data']['items']) {
      listsearch.add(Item(
          id: item['_id'].toString(),
          name: item['itemName'],
          price: item['Price'],
          images: item['images'],
          category: item['Category'],
          subcategory: item['SubCategory'],
          avilableColors: item['availableColors'],
          description: item['description'],
          seller: item['Seller'],
          sizes: item['AvailavleSizes'],
          discount: item['discount'],
          additionalInformation:
              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."));
    }
  }

  @override
  void initState() {
    getData();

    itemData = Provider.of<ItemsProvider>(context, listen: false);
    fetchedItems = itemData
        .pagginateFromAPI(page: 1, limit: 16)
        .whenComplete(() => print('pagginated.'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    final items = itemData.items;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: EdgeAppBar(
            listsearch: listsearch,
            profile: true,
            cart: true,
            search: true,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EdgeCarousel(images: canvas, height: 350),
            SizedBox(
              height: 32,
            ),
            Text(
              'SHOP BY CATEGORY',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 22,
            ),
            ListView.builder(
              itemCount: images.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 8),
              itemBuilder: (context, index) => CategoryWidget(
                image: images[index],
                category: category[index],
                underline: 'SHOP NOW',
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'BESTSELLERS',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 22,
            ),
            (items.length == 0)
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ItemWidget(
                        id: items[index].id,
                        itemName: items[index].itemName.toString().trimRight(),
                        image: items[index].image,
                        price: items[index].price,
                        discount: items[index].discount,
                      );
                    }),
            CategoryWidget(
              image:
                  'https://res.cloudinary.com/djtpiagbk/image/upload/v1618873501/Women/WOMAN%20LONG%20SLEEVE%20SHIRT/Screenshot_619_cjnqie.png',
              category: 'TEES AND TOPS',
              subcategory: 'NEW COLLECTION',
              underline: 'SEE NOW',
            ),
            SizedBox(
              height: 8,
            ),
            CategoryWidget(
              image:
                  'https://res.cloudinary.com/djtpiagbk/image/upload/v1624209091/Men/Summer/13/8240526400_2_3_8_bnd5rc.webp',
              category: 'TIE DYE',
              subcategory: 'TRENDS',
              underline: 'SEE NOW',
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 12),
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/avatar.png',
                    height: 100,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Edge.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'user@edge.com',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Divider()
                ],
              ),
              ListTile(
                leading: Icon(
                  Ionicons.person_outline,
                  color: Colors.black,
                ),
                title: Text(
                  'My Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(ProfileScreen.routeName);
                },
              ),
              ListTile(
                leading: Icon(Ionicons.heart_outline, color: Colors.black),
                title: Text(
                  'Favourites',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () {},
              ),
              ListTile(
                leading:
                    Icon(Ionicons.notifications_outline, color: Colors.black),
                title: Text(
                  'Notifications',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                trailing: ClipOval(
                  child: Container(
                    color: Colors.red,
                    width: 20,
                    height: 20,
                    child: Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        elevation: 20,
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  List<Item> data;
  BuildContext context;

  DataSearch({this.data, this.context})
      : super(
          searchFieldLabel: 'Looking for something?',
          searchFieldStyle: TextStyle(
              color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w600),
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    // Action for AppBar
    return [
      IconButton(
        icon: Icon(Ionicons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon leading
    return IconButton(
      icon: Icon(Ionicons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Search Results
    List<dynamic> searchResults = query.isEmpty
        ? []
        : data
            .where((item) =>
                item.name.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    List<dynamic> moreResults = query.isEmpty
        ? []
        : data
            .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return query.isEmpty
        ? Center(
            child: Text(
              'What\'s on your mind?',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Results',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return ItemWidget(
                          id: searchResults[index].id,
                          itemName:
                              searchResults[index].name.toString().trimRight(),
                          image: searchResults[index].images.first,
                          price: searchResults[index].price,
                          discount: searchResults[index].discount,
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'More Results',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: moreResults.length,
                      itemBuilder: (context, index) {
                        return ItemWidget(
                          id: moreResults[index].id,
                          itemName:
                              moreResults[index].name.toString().trimRight(),
                          image: moreResults[index].images.first,
                          price: moreResults[index].price,
                          discount: moreResults[index].discount,
                        );
                      }),
                ],
              ),
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions shown when user write anything
    // var searchlist = query.isEmpty
    //     ? data
    //     : data.where((p) => p.name.startsWith(query)).toList();

    List<dynamic> searchlist = query.isEmpty
        ? data
        : data
            .where((item) =>
                item.name.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: searchlist.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Ionicons.search_outline),
          trailing: IconButton(
            icon: Icon(
              Icons.north_west,
              size: 20,
            ),
            onPressed: () {
              query = searchlist[index].name;
            },
          ),
          title: RichText(
            text: TextSpan(
                text: searchlist[index]
                    .name
                    .toString()
                    .substring(0, query.length),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Wavehaus',
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: searchlist[index]
                        .name
                        .toString()
                        .substring(query.length)
                        .trimRight(),
                    style: TextStyle(
                        color: Colors.black38,
                        fontFamily: 'Wavehaus',
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )
                ]),
          ),
          onTap: () {
            query = searchlist[index].name;
            showResults(context);
          },
        );
      },
    );
  }
}
