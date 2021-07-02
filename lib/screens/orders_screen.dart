import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/models/cart_item.dart';
import 'package:edge/models/orders.dart';
import 'package:edge/provider/auth.dart';
import 'package:edge/provider/orders_provider.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = 'orders-screen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OrdersProvider ordersData;
  String userID;
  List<Order> orders = [];
  bool check = false;

  @override
  void initState() {
    userID = Provider.of<Auth>(context, listen: false).userID;
    ordersData = Provider.of<OrdersProvider>(context, listen: false);
    final getOrders = ordersData.getUserOrders(userID: userID).whenComplete(() {
      check = true;
      orders = ordersData.orders;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orders.isEmpty ? Colors.white : Color(0xffF4F4F4),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: EdgeAppBar(cart: false, profile: false, search: false)),
      body: (!check)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (orders.isEmpty)
              ? Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/spaceman.gif',
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        AutoSizeText(
                          'Void!',
                          maxFontSize: 28,
                          minFontSize: 22,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView.builder(
                    itemCount: orders.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return OrderWidget(
                        orderID: orders[index].id,
                        date: orders[index].dateTime,
                        orderItems: orders[index].items,
                      );
                    },
                  ),
                ),
    );
  }
}

class OrderWidget extends StatelessWidget {
  final String orderID;
  final String date;
  final List<CartItem> orderItems;

  const OrderWidget({
    @required this.orderID,
    @required this.date,
    @required this.orderItems,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order $orderID',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'PLaced on $date',
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Text(
                      'View Details >',
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Divider(),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                    itemCount: orderItems.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.only(right: 14),
                          width: size.width / 1.7,
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                width: size.width / 4,
                                imageUrl: orderItems[index].image,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, progress) => Container(
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
                              SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderItems[index].name,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Shipped',
                                      style: TextStyle(
                                          color: Colors.yellow[700],
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
