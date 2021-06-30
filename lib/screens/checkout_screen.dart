import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/models/cart_item.dart';
import 'package:edge/provider/Cart_provider.dart';
import 'package:edge/provider/auth.dart';
import 'package:edge/provider/orders_provider.dart';
import 'package:edge/screens/order_placed.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = '/checkout-screen';

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _paymenFormKey = GlobalKey<FormBuilderState>();
  bool isCard = true;
  bool option = true;

  CartProvider cartData;
  List<CartItem> cartItems;
  String userID;
  OrdersProvider ordersProvider;

  @override
  void initState() {
    userID = Provider.of<Auth>(context, listen: false).userID;
    ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    cartData = Provider.of<CartProvider>(context, listen: false);
    cartItems = cartData.cartItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: EdgeAppBar(
          cart: false,
          profile: false,
          search: false,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SHIPPING ADDRESS:',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              InkWell(
                                child: Text(
                                  'Change Address',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue[800],
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Icon(Ionicons.home_outline),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'HOME',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Mohamed Askar',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Tanta Qism 1, Gharbia, Egypt',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '+20 106 9292 154',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PAYMENT METHOD',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isCard = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: isCard
                                              ? Colors.black
                                              : Colors.black12,
                                          width: 1),
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Ionicons.card_outline,
                                        size: 28,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Pay With Card',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isCard = false;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: !isCard
                                              ? Colors.black
                                              : Colors.black12,
                                          width: 1),
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Ionicons.wallet_outline,
                                        size: 28,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Pay With Cash',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DELIVERY OPTIONS',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      FlutterSwitch(
                                        activeColor: Colors.black,
                                        value: option,
                                        onToggle: (value) {
                                          setState(() {
                                            option = !option;
                                          });
                                        },
                                        height: 26,
                                        width: 48,
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Leave At My Door',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              'It is a short established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      FlutterSwitch(
                                        activeColor: Colors.black,
                                        value: option,
                                        onToggle: (value) {
                                          setState(() {
                                            option = !option;
                                          });
                                        },
                                        height: 26,
                                        width: 48,
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Get It Tomorrow',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              'It is a short established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  OrderSummary(
                    total: cartData.totalAmount,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ReviewYourOrder(
                    cartItems: cartItems,
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            child: InkWell(
              onTap: () async {
                await Provider.of<OrdersProvider>(context, listen: false)
                    .placeOrder(
                        userID: userID,
                        cart: cartItems,
                        totalAmount: cartData.totalAmount);
                Navigator.pushReplacementNamed(
                    context, OrderPlacedScreen.routeName);
                Provider.of<CartProvider>(context, listen: false).clearCart();
              },
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'PLACE ORDER',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReviewYourOrder extends StatelessWidget {
  final List<CartItem> cartItems;
  ReviewYourOrder({@required this.cartItems});
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REVIEW SHIPMENT',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
          ),
          SizedBox(
            height: 18,
          ),
          ListView.builder(
            itemCount: cartItems.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${cartItems[index].seller}',
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                cartItems[index].name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                '${cartItems[index].price} LE',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'QTY: ${cartItems[index].quantity}',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: 'Free Delivery. ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Order now and get it by ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${DateFormat("EEE, MMM dd").format(DateTime.now().add(Duration(days: 2)))}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        CachedNetworkImage(
                          height: deviceSize.width / 3,
                          width: deviceSize.width / 3,
                          imageUrl: cartItems[index].image,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) =>
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
                      ],
                    ),
                    if (index < cartItems.length - 1) Divider()
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final double total;
  OrderSummary({@required this.total});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORDER SUMMARY',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black54),
                  ),
                  Text(
                    '\$$total',
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping Fee',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black54),
                  ),
                  Text(
                    'Free',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black54),
                  ),
                  Text(
                    '-\$0',
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              )
            ],
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Estimated VAT included (%14)',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.black54),
              ),
              Text(
                '\$0',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '\$$total',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 18),
              )
            ],
          ),
        ],
      ),
    );
  }
}
