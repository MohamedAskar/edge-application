import 'package:badges/badges.dart';
import 'package:edge/models/item.dart';
import 'package:edge/provider/Cart_provider.dart';
import 'package:edge/screens/cart_screen.dart';
import 'package:edge/screens/home_screen.dart';
import 'package:edge/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class EdgeAppBar extends StatelessWidget {
  const EdgeAppBar(
      {this.listsearch,
      @required this.cart,
      @required this.profile,
      this.addItem,
      @required this.search});

  final List<ItemSummary> listsearch;
  final bool cart;
  final bool search;
  final bool profile;
  final bool addItem;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text('edge.', style: Theme.of(context).textTheme.headline1),
      actions: [
        if (search)
          IconButton(
            icon: Icon(Ionicons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: DataSearch(data: listsearch, context: context));
            },
          ),
        if (cart)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: InkWell(
              child: Consumer<CartProvider>(
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
                    position: BadgePosition.topEnd(end: 0, top: 6),
                    child: child,
                  );
                },
                child: Icon(
                  Ionicons.bag_handle_outline,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 150),
                        opaque: false,
                        pageBuilder: (_, animation1, __) {
                          return SlideTransition(
                              position: Tween(
                                      begin: Offset(1.0, 0.0),
                                      end: Offset(0.0, 0.0))
                                  .animate(animation1),
                              child: CartScreen());
                        }));
              },
            ),
          ),
        if (profile)
          IconButton(
            icon: Icon(
              Ionicons.person_outline,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 150),
                      opaque: false,
                      pageBuilder: (_, animation1, __) {
                        return SlideTransition(
                            position: Tween(
                                    begin: Offset(1.0, 0.0),
                                    end: Offset(0.0, 0.0))
                                .animate(animation1),
                            child: ProfileScreen());
                      }));
            },
          ),
        // if (addItem)
        //   IconButton(
        //       icon: Icon(
        //         Ionicons.add_outline,
        //         color: Colors.black,
        //       ),
        //       onPressed: () {})
      ],
    );
  }
}
