import 'dart:async';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:edge/models/item.dart';
import 'package:edge/provider/Cart_provider.dart';
import 'package:edge/provider/items_provider.dart';
import 'package:edge/screens/category_screen.dart';
import 'package:edge/widgets/category_widget.dart';
import 'package:edge/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cart_screen.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'Home-Screen';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final _controller = PageController(
    initialPage: 0,
  );

  List images = [
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1618872666/Men/Basic%20hoodie%20with%20a%20rubberized%20patch/9594513403_2_4_8_vcfg3j.webp',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1618873127/Men/1006/8062320406_6_1_1_vsp8ks.jpg',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1618873501/Women/WOMAN%20LONG%20SLEEVE%20SHIRT/Screenshot_619_cjnqie.png',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1618873404/Women/Straight%20Jean%20Trousers/Screenshot_647_gqwewr.png',
  ];

  List category = ['HOODIES', 'JEANS', 'TOPS', 'PANTS'];
  List<int> randomizedNumber = [];

  List<Item> listsearch = [];
  Future getData() async {
    var url = 'https://evening-falls-32097.herokuapp.com/api/v1/items';
    var response = await Dio().get(url);
    final data = response.data as Map<String, dynamic>;
    for (var item in data['data']['items']) {
      listsearch.add(Item(
          id: item['_id'].toString(),
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
    }
  }

  @override
  void initState() {
    getData();
    randomizedNumber = List.generate(38, (index) => index + 1)
      ..shuffle()
      ..take(8);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_controller.hasClients) {
        _controller.animateToPage(_currentPage,
            duration: Duration(milliseconds: 350), curve: Curves.easeIn);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    var size = MediaQuery.of(context).size;
    final itemData = Provider.of<ItemsProvider>(context);
    final fetchItems = itemData.pagginateFromAPI(page: 1, limit: 8);
    final items = itemData.items;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('edge.', style: Theme.of(context).textTheme.headline1),
        actions: [
          IconButton(
            icon: Icon(Ionicons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: DataSearch(data: listsearch));
            },
          ),
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Badge(
                badgeColor: Colors.black,
                toAnimate: true,
                alignment: Alignment.center,
                animationType: BadgeAnimationType.scale,
                badgeContent: Text(
                  cart.totalQuantity.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12),
                ),
                position: BadgePosition.topEnd(end: 6, top: 8),
                child: child,
              );
            },
            child: IconButton(
              icon: Icon(
                Ionicons.bag_handle_outline,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 400,
                  child: PageView.builder(
                    itemCount: 4,
                    onPageChanged: (value) {
                      setState(() {
                        _currentPage = value;
                      });
                    },
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl:
                            'https://res.cloudinary.com/djtpiagbk/image/upload/v1619903723/Canvas/logo_q6zvwh.gif',
                        fit: BoxFit.fitHeight,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Container(
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      );
                    },
                  ),
                ),
                Positioned(
                  right: size.width / 2 - 32,
                  bottom: 10,
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: WormEffect(
                        activeDotColor: Colors.white,
                        dotColor: Colors.grey,
                        radius: 8.0,
                        dotHeight: 8.0,
                        dotWidth: 8.0),
                  ),
                )
              ],
            ),
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
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return ItemWidget(
                        id: items[index].id,
                        itemName: items[index].itemName,
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
                  'https://res.cloudinary.com/djtpiagbk/image/upload/v1618873197/Women/Half%20Off%20shoulder%20swetshirt/Screenshot_640_ben6e4.png',
              category: 'OFF SHOULDERS',
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
        child: Center(
          child: Text(
            'Under Construction',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  List<Item> data;

  DataSearch({this.data});
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
    return null;
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
            .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: searchlist.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Ionicons.search_outline),
          title: Text('${searchlist[index].name}'),
          onTap: () {
            query = searchlist[index].name;
            showResults(context);
          },
        );
      },
    );
  }
}
