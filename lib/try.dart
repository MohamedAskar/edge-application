import 'package:badges/badges.dart';
import 'package:edge/provider/Cart_provider.dart';
import 'package:edge/provider/auth.dart';
import 'package:edge/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class TestPage extends StatelessWidget {
  static const routeName = 'test-page';
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    final auth = Provider.of<Auth>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('edge.', style: Theme.of(context).textTheme.headline1),
        actions: [
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
        ],
      ),
      body: Center(
        child: Text('User ${auth.userID}'),
      ),
    );
  }
}
