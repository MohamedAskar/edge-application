import 'package:auto_size_text/auto_size_text.dart';
import 'package:edge/models/orders.dart';
import 'package:edge/provider/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'orders_screen.dart';

class ManageOrdersPage extends StatefulWidget {
  static const routename = 'manage-orders';
  final String userID;

  ManageOrdersPage({@required this.userID});

  @override
  _ManageOrdersPageState createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<ManageOrdersPage> {
  OrdersProvider ordersData;
  String userID;
  List<Order> orders = [];
  bool check = false;

  @override
  void initState() {
    ordersData = Provider.of<OrdersProvider>(context, listen: false);
    final getOrders =
        ordersData.getUserOrders(userID: widget.userID).whenComplete(() {
      setState(() {
        check = true;
      });
      orders = ordersData.orders;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orders.isEmpty ? Colors.white : Color(0xffF4F4F4),
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
      ),
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
