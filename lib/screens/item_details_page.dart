import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/models/cart_item.dart';
import 'package:edge/models/item.dart';
import 'package:edge/provider/Cart_provider.dart';
import 'package:edge/provider/auth.dart';
import 'package:edge/provider/color_picker.dart';
import 'package:edge/provider/items_provider.dart';
import 'package:edge/screens/cart_screen.dart';
import 'package:edge/screens/checkout_screen.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemDetailsPage extends StatefulWidget {
  static final String routeName = 'Item-Details-Screen';

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  int _currentPage = 0;
  final _controller = PageController(
    initialPage: 0,
  );

  int quantity = 1;
  bool isCacheCleared = false;
  bool _expanded = false;
  bool _expanded1 = false;
  var selectedColor = 0;
  var selectedSize = 0;
  var isFavorite = false;
  List<int> randomizedNumber = [];
  Item item;

  bool isItemAdded = false;

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

  bool isLoading = false;

  _showModalBottomSheet(double height, double width) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: height,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/cart.png',
                scale: 3,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Hurray! Your Item has been added.',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'We still have a lot more to match with this item!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width / 3,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.maybePop(context);
                      },
                      child: Center(
                        child: Text(
                          'CONTINUE SHOPPING',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Container(
                    width: width / 3,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1.5)),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.routeName);
                      },
                      child: Center(
                        child: Text(
                          'YOUR CART',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  ItemsProvider itemData;
  Future fetchedItems;
  String userID;
  bool isItemFetched = false;

  @override
  void initState() {
    super.initState();
    itemData = Provider.of<ItemsProvider>(context, listen: false);
    userID = Provider.of<Auth>(context, listen: false).userID;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String itemID = ModalRoute.of(context).settings.arguments;
    // ignore: unused_local_variable
    if (!isItemFetched) {
      final fetchedItem =
          itemData.findById(id: itemID, userID: userID).whenComplete(() {
        if (mounted) {
          setState(() {
            isCacheCleared = true;
            isItemFetched = true;
          });
          item = itemData.item;
        }
        //itemData.clear();
      });
    }
    //item = itemData.item;

    //print(widget.id.runtimeType);

    final size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: EdgeAppBar(
              listsearch: [],
              profile: false,
              cart: true,
              search: true,
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: (!isCacheCleared)
                ? Container(
                    height: size.height - kToolbarHeight - 24,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
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
                              TextSpan(text: '${item.subcategory}')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SafeArea(
                        child: Hero(
                          tag: itemID,
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
                                      zoomedBackgroundColor: Colors.transparent,
                                      image: CachedNetworkImage(
                                        imageUrl: item.images[index],
                                        fit: BoxFit.cover,
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
                                    );
                                  },
                                ),
                              ),
                              Container(
                                height: size.height / 1.5,
                                padding: const EdgeInsets.only(bottom: 18),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
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
                                ),
                              )
                            ],
                          ),
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
                              "\$${item.price}",
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
                                    onTap: () async {
                                      if (!isItemAdded) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await cart
                                            .addToCart(
                                                item: CartItem(
                                                    id: item.id,
                                                    image: item.images.first,
                                                    name: item.name,
                                                    price: item.price,
                                                    quantity: quantity,
                                                    selectedColor:
                                                        item.avilableColors[
                                                            selectedColor],
                                                    selectedSize: item
                                                        .sizes[selectedSize],
                                                    subCategory:
                                                        item.subcategory,
                                                    seller: item.seller),
                                                userID: Provider.of<Auth>(
                                                        context,
                                                        listen: false)
                                                    .userID)
                                            .whenComplete(() {
                                          setState(() {
                                            isLoading = false;
                                            isItemAdded = true;
                                          });
                                        });
                                        _showModalBottomSheet(
                                            size.height / 2.25, size.width);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      color: Colors.black,
                                      child: Center(
                                        child: isLoading
                                            ? AnimatedTextKit(
                                                animatedTexts: [
                                                  FlickerAnimatedText(
                                                    'Adding To Cart...',
                                                    speed: Duration(
                                                        milliseconds: 2000),
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )
                                            : Text(
                                                isItemAdded
                                                    ? 'ITEM ADDED'
                                                    : 'ADD TO CART',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                onPressed: () async {
                                  if (!isFavorite) {
                                    print('adding');
                                    await itemData
                                        .addToWishlist(
                                            item: item, userID: userID)
                                        .whenComplete(() {
                                      setState(() {
                                        isFavorite = true;
                                        print('Done');
                                      });
                                    });
                                  } else {
                                    itemData
                                        .removeWishlist(
                                            userID: userID, itemID: item.id)
                                        .whenComplete(() => print('removed'));
                                  }
                                },
                                icon: Icon(
                                  isFavorite
                                      ? Ionicons.heart
                                      : Ionicons.heart_outline,
                                  color: isFavorite ? Colors.red : Colors.black,
                                ),
                                label: Text(
                                  isFavorite
                                      ? 'ADDED TO YOUR WISHLIST'
                                      : 'ADD TO WISHLIST',
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
                              (item.description != null)
                                  ? item.description
                                  : "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
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
                                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
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
                                  "It is a short established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
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
