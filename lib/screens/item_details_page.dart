import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/models/cart_item.dart';
import 'package:edge/models/item.dart';
import 'package:edge/provider/Cart_provider.dart';
import 'package:edge/provider/color_picker.dart';
import 'package:edge/provider/items_provider.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cart_screen.dart';

class ItemDetailsPage extends StatefulWidget {
  static final String routeName = 'Item-Details-Screen';

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  int quantity = 1;
  bool isCacheCleared = false;
  int _currentPage = 0;
  bool _expanded = false;
  bool _expanded1 = false;
  var selectedColor = 0;
  var selectedSize = 0;
  List<int> randomizedNumber = [];
  Item item;

  final _controller = PageController(
    initialPage: 0,
  );

  void changeSelectedColor(int index) {
    setState(() {
      selectedColor = index;
    });
  }

  void changeSelectedSize(int index) {
    setState(() {
      selectedSize = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String itemID = ModalRoute.of(context).settings.arguments;
    final itemData = Provider.of<ItemsProvider>(context, listen: false);
    final fetchedItem = itemData.findById(itemID).whenComplete(() {
      isCacheCleared = true;
      item = itemData.item;
      //itemData.clear();
    });
    //item = itemData.item;

    //print(widget.id.runtimeType);

    final size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text('edge.', style: Theme.of(context).textTheme.headline1),
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
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: (!isCacheCleared)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text.rich(
                          TextSpan(
                            text: '> Category > ',
                            style: Theme.of(context).textTheme.bodyText1,
                            children: [
                              TextSpan(text: '${item.category} > '),
                              TextSpan(text: 'Hoodie')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SafeArea(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: size.height / 1.5,
                              child: PageView.builder(
                                itemCount: item.images.length,
                                onPageChanged: (value) {
                                  setState(() {
                                    _currentPage = value;
                                  });
                                },
                                controller: _controller,
                                itemBuilder: (context, index) {
                                  return PinchZoom(
                                    zoomedBackgroundColor:
                                        Colors.black.withOpacity(0.1),
                                    resetDuration:
                                        const Duration(milliseconds: 100),
                                    maxScale: 3,
                                    zoomEnabled: true,
                                    onZoomStart: () {
                                      print('Start zooming');
                                    },
                                    onZoomEnd: () {
                                      print('Stop zooming');
                                    },
                                    image: Hero(
                                      tag: itemID,
                                      child: CachedNetworkImage(
                                        imageUrl: item.images[index],
                                        fit: BoxFit.fill,
                                        progressIndicatorBuilder:
                                            (context, url, progress) =>
                                                Container(
                                          height: 60,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value: progress.progress,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              right: size.width / 2 - 42,
                              bottom: 15,
                              child: SmoothPageIndicator(
                                controller: _controller,
                                count: item.images.length,
                                effect: WormEffect(
                                    activeDotColor: Colors.black,
                                    dotColor: Colors.grey,
                                    radius: 8.0,
                                    dotHeight: 8.0,
                                    dotWidth: 8.0),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text.rich(
                              TextSpan(
                                  text: 'sold by: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54),
                                  children: [
                                    TextSpan(
                                        text: item.seller,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87))
                                  ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${item.price} LE",
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 42,
                            ),

                            Text(
                              'Color : ${item.avilableColors[selectedColor]}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                  itemCount: item.avilableColors.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: InkWell(
                                          splashColor: Colors.white,
                                          onTap: () {
                                            changeSelectedColor(index);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            width: 36,
                                            height: 36,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color:
                                                        selectedColor == index
                                                            ? Colors.black
                                                            : Colors.grey,
                                                    width:
                                                        selectedColor == index
                                                            ? 2
                                                            : 1,
                                                    style: BorderStyle.solid)),
                                            child: CircleAvatar(
                                              backgroundColor: Color(
                                                  ColorPicker().hexColorToInt(
                                                      item.avilableColors[
                                                          index])),
                                              radius: 16,
                                            ),
                                          ),
                                        ),
                                      )),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            Row(children: <Widget>[
                              Text(
                                "SELECT YOUR SIZE",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 36,
                                    )),
                              ),
                            ]),
                            SizedBox(
                              height: 18,
                            ),
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                  itemCount: item.sizes.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: InkWell(
                                          splashColor: Colors.white,
                                          onTap: () {
                                            changeSelectedSize(index);
                                          },
                                          child: Container(
                                              width: 40,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          selectedSize == index
                                                              ? Colors.black
                                                              : Colors.grey,
                                                      width:
                                                          selectedSize == index
                                                              ? 2
                                                              : 1,
                                                      style:
                                                          BorderStyle.solid)),
                                              child: Center(
                                                child: Text(
                                                  item.sizes[index],
                                                  style: TextStyle(
                                                      color:
                                                          selectedSize == index
                                                              ? Colors.black
                                                              : Colors.black54,
                                                      fontWeight:
                                                          selectedSize == index
                                                              ? FontWeight.bold
                                                              : FontWeight
                                                                  .w500),
                                                ),
                                              )),
                                        ),
                                      )),
                            ),

                            SizedBox(
                              height: 32,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black26),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      child: Text(
                                        '$quantity',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black26),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: InkWell(
                                            child: Icon(
                                              Ionicons.add_outline,
                                              size: 22,
                                            ),
                                            onTap: () {
                                              if (quantity < 10) {
                                                setState(() {
                                                  quantity++;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black26),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: InkWell(
                                            child: Icon(
                                              Ionicons.remove_outline,
                                              size: 22,
                                            ),
                                            onTap: () {
                                              if (quantity > 1) {
                                                setState(() {
                                                  quantity--;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      cart.addToCart(CartItem(
                                          id: item.id,
                                          image: item.images.first,
                                          name: item.name,
                                          price: item.price,
                                          quantity: quantity,
                                          selectedColor: item
                                              .avilableColors[selectedColor],
                                          selectedSize:
                                              item.sizes[selectedSize],
                                          seller: item.seller));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      color: Colors.black,
                                      child: Center(
                                        child: Text(
                                          'ADD TO CART',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextButton.icon(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.black12,
                                  ),
                                ),
                                onPressed: () {},
                                icon: Icon(
                                  Ionicons.heart_outline,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  'ADD TO WISHLIST',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black),
                                )),
                            SizedBox(
                              height: 12,
                            ),
                            Row(children: <Widget>[
                              Text(
                                "DESCRIPTION",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 36,
                                    )),
                              ),
                            ]),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              item.description,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              title: Text(
                                'ADDITIONAL INFORMATIONS',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              trailing: InkWell(
                                child: Icon(
                                  !_expanded
                                      ? Ionicons.add_outline
                                      : Ionicons.remove_outline,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  setState(() {
                                    _expanded = !_expanded;
                                  });
                                },
                              ),
                            ),
                            if (_expanded)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  item.additionalInformation,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            Divider(
                              thickness: 1.5,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              title: Text(
                                'DELIVERY AND MORE',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              trailing: InkWell(
                                child: Icon(
                                  !_expanded1
                                      ? Ionicons.add_outline
                                      : Ionicons.remove_outline,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  setState(() {
                                    _expanded1 = !_expanded1;
                                  });
                                },
                              ),
                            ),
                            if (_expanded1)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  item.description,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            Divider(
                              thickness: 1.5,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                'YOU MAY ALSO LIKE',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            // FutureBuilder(
                            //     future: fetchFromAPI,
                            //     builder: (context, snapshot) {
                            //       if (snapshot.connectionState ==
                            //           ConnectionState.waiting) {
                            //         return Center(child: CircularProgressIndicator());
                            //       }
                            //       return GridView.builder(
                            //           gridDelegate:
                            //               SliverGridDelegateWithFixedCrossAxisCount(
                            //             crossAxisCount: 2,
                            //             childAspectRatio: 0.7,
                            //           ),
                            //           shrinkWrap: true,
                            //           physics: NeverScrollableScrollPhysics(),
                            //           itemCount: 4,
                            //           itemBuilder: (context, index) {
                            //             print(snapshot.data[index].id.runtimeType);
                            //             return ItemWidget(
                            //                 item: snapshot.data[randomizedNumber[index]]);
                            //           });
                            //     }),
                          ],
                        ),
                      ),
                    ],
                  )));
  }
}
