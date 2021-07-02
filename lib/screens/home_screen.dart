import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:edge/screens/wishlist_screen.dart';
import 'package:http/http.dart' as http;
import 'package:edge/models/item.dart';
import 'package:edge/provider/Cart_provider.dart';
import 'package:edge/provider/auth.dart';
import 'package:edge/provider/items_provider.dart';
import 'package:edge/screens/profile_screen.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:edge/widgets/carousel.dart';
import 'package:edge/widgets/category_widget.dart';
import 'package:edge/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1624642767/Women/Summer/22/cn19986748_imrvos.webp',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1624639522/Men/Summer/41/cn20356615_ywpftm.webp',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1618873278/Women/Long%20Sleeve%20Woven%20Dress/Screenshot_628_bdcm5i.png',
  ];

  final List canvas = [
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622331736/Canvas/White_Simple_We_Are_Open_Instagram_Post_aqgcur.png',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622332517/Canvas/New_Collection_Instagram_Post_1_sqfaat.png',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622332415/Canvas/logo_1_sedqvu.gif',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622333549/Canvas/Copy_of_Shop_New_Arrivals_Collage_Instagram_Post_kjbci5.png',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622334438/Canvas/Vibrant_Etsy_Shop_Icon_1_hglgdp.png',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622331707/Canvas/Orange_and_Green_Geometric_Apparel_Store_Flyer_vhw2cm.png',
  ];

  List category = ['T-Shirt', 'Jeans', 'Shirt', 'Pants', 'Polo', 'Dress'];

  List<ItemSummary> listsearch = [];
  ItemsProvider itemData;
  Auth auth;
  Future fetchedItems;

  Future getData() async {
    var url = 'https://shrouded-citadel-37368.herokuapp.com/api/v1/items';
    var response = await http.get(Uri.parse(url));
    final data = json.decode(response.body) as Map<String, dynamic>;
    for (var item in data['data']['allItems']) {
      listsearch.add(ItemSummary(
        id: item['_id'].toString(),
        itemName: item['itemName'],
        price: item['Price'],
        image: item['images'][0],
        discount: item['discount'],
      ));
    }
  }

  @override
  void initState() {
    getData();
    auth = Provider.of<Auth>(context, listen: false);
    final userData = auth.getUserData();
    final userID = auth.userID;
    print(userID);
    final qty = Provider.of<CartProvider>(context, listen: false)
        .getTotalQty(userID: userID);

    print('From Home: $qty');
    itemData = Provider.of<ItemsProvider>(context, listen: false);
    fetchedItems = itemData
        .paginateFromAPI(page: Random().nextInt(5), limit: 12)
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
            AutoSizeText(
              'SHOP BY CATEGORY',
              maxFontSize: 26,
              minFontSize: 22,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 22,
            ),
            AnimationLimiter(
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8),
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: 1500),
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: CategoryWidget(
                        image: images[index],
                        category: category[index],
                        underline: 'SHOP NOW',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            AutoSizeText(
              'BESTSELLERS',
              maxFontSize: 26,
              minFontSize: 22,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 22,
            ),
            (items.length == 0)
                ? Center(child: CircularProgressIndicator())
                : AnimationLimiter(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: index,
                            duration: const Duration(milliseconds: 1500),
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: ItemWidget(
                                  id: items[index].id,
                                  itemName: items[index]
                                      .itemName
                                      .toString()
                                      .trimRight(),
                                  image: items[index].image,
                                  price: items[index].price,
                                  discount: items[index].discount,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
            AnimationLimiter(
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8),
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: 1500),
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: CategoryWidget(
                        image: images[index + 2],
                        category: category[index + 2],
                        underline: 'SHOP NOW',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            AutoSizeText(
              'YOU MAY ALSO LIKE',
              maxFontSize: 26,
              minFontSize: 22,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 22,
            ),
            (items.length == 0)
                ? Center(child: CircularProgressIndicator())
                : AnimationLimiter(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: index,
                            duration: const Duration(milliseconds: 1500),
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: ItemWidget(
                                  id: items[index + 4].id,
                                  itemName: items[index + 4]
                                      .itemName
                                      .toString()
                                      .trimRight(),
                                  image: items[index + 4].image,
                                  price: items[index + 4].price,
                                  discount: items[index + 4].discount,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
            AnimationLimiter(
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8),
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: 1500),
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: CategoryWidget(
                        image: images[index + 4],
                        category: category[index + 4],
                        underline: 'SHOP NOW',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            AutoSizeText(
              'THERE\'S ALWAYS MORE',
              maxFontSize: 26,
              minFontSize: 22,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 22,
            ),
            (items.length == 0)
                ? Center(child: CircularProgressIndicator())
                : AnimationLimiter(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: index,
                            duration: const Duration(milliseconds: 1500),
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: ItemWidget(
                                  id: items[index + 8].id,
                                  itemName: items[index + 8]
                                      .itemName
                                      .toString()
                                      .trimRight(),
                                  image: items[index + 8].image,
                                  price: items[index + 8].price,
                                  discount: items[index + 8].discount,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
            CategoryWidget(
              image:
                  'https://res.cloudinary.com/djtpiagbk/image/upload/v1618873501/Women/WOMAN%20LONG%20SLEEVE%20SHIRT/Screenshot_619_cjnqie.png',
              category: 'Tops',
              subcategory: 'NEW COLLECTION',
              underline: 'SEE NOW',
            ),
            SizedBox(
              height: 8,
            ),
            CategoryWidget(
              image:
                  'https://res.cloudinary.com/djtpiagbk/image/upload/v1624209091/Men/Summer/13/8240526400_2_3_8_bnd5rc.webp',
              category: 'Tie-Dye',
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
                  AutoSizeText(
                    (auth.userName == null) ? "" : auth.userName,
                    maxFontSize: 28,
                    minFontSize: 24,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText(
                    (auth.email == null) ? "" : auth.email,
                    maxFontSize: 20,
                    minFontSize: 16,
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w600),
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
                title: AutoSizeText(
                  'My Profile',
                  maxFontSize: 20,
                  minFontSize: 16,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(ProfileScreen.routeName);
                },
              ),
              ListTile(
                leading: Icon(Ionicons.heart_outline, color: Colors.black),
                title: AutoSizeText(
                  'Favourites',
                  maxFontSize: 20,
                  minFontSize: 16,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.pushNamed(context, WishListScreen.routeName);
                },
              ),
              ListTile(
                leading:
                    Icon(Ionicons.notifications_outline, color: Colors.black),
                title: AutoSizeText(
                  'Notifications',
                  maxFontSize: 20,
                  minFontSize: 16,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
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
  List<ItemSummary> data;
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
                item.itemName.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return query.isEmpty
        ? Center(
            child: AutoSizeText(
              'What\'s on your mind?',
              maxFontSize: 21,
              minFontSize: 17,
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
            ),
          )
        : (searchResults.isEmpty)
            ? Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/search.gif'),
                    AutoSizeText(
                      'NO RESULT!',
                      maxFontSize: 21,
                      minFontSize: 17,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Wavehaus',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          'Results',
                          maxFontSize: 26,
                          minFontSize: 22,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            return ItemWidget(
                              id: searchResults[index].id,
                              itemName: searchResults[index]
                                  .itemName
                                  .toString()
                                  .trimRight(),
                              image: searchResults[index].image,
                              price: searchResults[index].price,
                              discount: searchResults[index].discount,
                            );
                          }),
                      //       Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Text(
                      //           'More Results',
                      //           style: TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 22,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //       GridView.builder(
                      //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 2,
                      //             childAspectRatio: 0.7,
                      //           ),
                      //           shrinkWrap: true,
                      //           physics: NeverScrollableScrollPhysics(),
                      //           itemCount: moreResults.length,
                      //           itemBuilder: (context, index) {
                      //             return ItemWidget(
                      //               id: moreResults[index].id,
                      //               itemName:
                      //                   moreResults[index].name.toString().trimRight(),
                      //               image: moreResults[index].images.first,
                      //               price: moreResults[index].price,
                      //               discount: moreResults[index].discount,
                      //             );
                      //           }),
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
                item.itemName.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return (searchlist.isEmpty)
        ? Center(
            child: Column(
              children: [
                Image.asset('assets/images/search.gif'),
                AutoSizeText(
                  'NO RESULT!',
                  maxFontSize: 21,
                  minFontSize: 17,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Wavehaus',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        : ListView.builder(
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
                title: AutoSizeText(
                  searchlist[index].itemName.toString().trimRight(),
                  maxFontSize: 21,
                  minFontSize: 17,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Wavehaus',
                      fontWeight: FontWeight.bold),
                ),
                // RichText(
                //   text: TextSpan(
                //       text: searchlist[index]
                //           .name
                //           .toString()
                //           .substring(0, query.length),
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 17,
                //           fontFamily: 'Wavehaus',
                //           fontWeight: FontWeight.bold),
                //       children: [
                //         TextSpan(
                //           text: searchlist[index]
                //               .name
                //               .toString()
                //               .substring(query.length)
                //               .trimRight(),
                //           style: TextStyle(
                //               color: Colors.black38,
                //               fontFamily: 'Wavehaus',
                //               fontSize: 17,
                //               fontWeight: FontWeight.bold),
                //         )
                //       ]),
                // ),
                onTap: () {
                  query = searchlist[index].itemName;
                  showResults(context);
                },
              );
            },
          );
  }
}
