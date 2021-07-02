import 'package:auto_size_text/auto_size_text.dart';
import 'package:edge/models/item.dart';
import 'package:edge/provider/auth.dart';
import 'package:edge/provider/items_provider.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:edge/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  static const routeName = 'wishlist-screen';
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  ItemsProvider itemsProvider;
  Future<void> getWishlist;
  String userID;
  List<ItemSummary> wishlist = [];
  bool check = false;

  @override
  void initState() {
    userID = Provider.of<Auth>(context, listen: false).userID;
    itemsProvider = Provider.of<ItemsProvider>(context, listen: false);
    getWishlist = itemsProvider.getWishList(userID: userID).whenComplete(() {
      check = true;
      wishlist = itemsProvider.wishlist;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: EdgeAppBar(cart: true, profile: true, search: false)),
      body: (!check)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (wishlist.isEmpty)
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - kToolbarHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/wishlist.png',
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      AutoSizeText(
                        'Really? No Items!',
                        maxFontSize: 28,
                        minFontSize: 24,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  child: Column(
                    children: [
                      AnimationLimiter(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                            ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: wishlist.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                columnCount: 2,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: ItemWidget(
                                      id: wishlist[index].id,
                                      itemName: wishlist[index]
                                          .itemName
                                          .toString()
                                          .trimRight(),
                                      image: wishlist[index].image,
                                      price: wishlist[index].price,
                                      discount: wishlist[index].discount,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
    );
  }
}
