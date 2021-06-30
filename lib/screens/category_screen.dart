import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/provider/Cart_provider.dart';
import 'package:edge/provider/items_provider.dart';
import 'package:edge/screens/profile_screen.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:edge/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class CategoryScreen extends StatefulWidget {
  static final String routeName = 'Category-Screen';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int page = 1;
  bool isCacheCleared = false;
  bool _isPaginated = false;
  bool _firstPage = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  int getNoPages(int total, int limit) {
    int noPages = 0;
    var ratio = total / limit;
    if (ratio.runtimeType == double) {
      noPages = ratio.floor() + 1;
    }
    return noPages;
  }

  @override
  Widget build(BuildContext context) {
    final itemData = Provider.of<ItemsProvider>(context);
    final result = itemData.totalNoItems;
    final pages = getNoPages(result, 16);
    final Map<String, String> args = ModalRoute.of(context).settings.arguments;
    final subcategory = args['category'];
    final image = args['image'];
    if (!_isPaginated) {
      final fetchedItems = itemData
          .paginateFromAPI(page: page, limit: 16, subcategory: subcategory)
          .whenComplete(() {
        setState(() {
          isCacheCleared = true;
        });
        setState(() {
          _isPaginated = true;
        });
        print('pagginated.');
      });
    }
    final items = itemData.items;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          subcategory,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Ionicons.search),
            onPressed: () {},
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
            icon: Icon(
              Ionicons.person_outline,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                !isCacheCleared
                    ? Container(
                        height: size.height - 100,
                        child: Center(child: CircularProgressIndicator()))
                    : AnimationLimiter(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                            ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                columnCount: 2,
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
              ],
            ),
            if (!(pages == 1))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (!_firstPage)
                    Container(
                      width: size.width / 3,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.5)),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isCacheCleared = false;
                            _isPaginated = false;
                            if (page != 1) {
                              _scrollController.jumpTo(0.0);
                              _firstPage = false;
                              page--;
                            } else {
                              _firstPage = true;
                            }
                          });
                        },
                        child: Center(
                          child: Text(
                            '< PREVIOUS PAGE',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  if (page < pages)
                    Container(
                      width: size.width / 3,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.5)),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isCacheCleared = false;
                            _isPaginated = false;

                            if (page < pages) {
                              _scrollController.jumpTo(0.0);
                              page++;
                              _firstPage = false;
                            }
                          });
                        },
                        child: Center(
                          child: Text(
                            'NEXT PAGE >',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
