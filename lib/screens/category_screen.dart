import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'cart_screen.dart';

class CategoryScreen extends StatelessWidget {
  static final String routeName = 'Category-Screen';

  @override
  Widget build(BuildContext context) {
    final String cateogry = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(cateogry,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Ionicons.search),
            onPressed: () {},
          ),
          Badge(
            badgeColor: Colors.black,
            toAnimate: true,
            alignment: Alignment.center,
            animationType: BadgeAnimationType.scale,
            badgeContent: Text(
              '3',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
            position: BadgePosition.topEnd(end: 6, top: 8),
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
      body: Center(
        child: Text(
          'To be implemented',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
