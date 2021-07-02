import 'package:flutter/cupertino.dart';

import 'cart_item.dart';

class Order with ChangeNotifier {
  final String id;
  //final Address address;
  final dynamic totalPrice;
  final String dateTime;
  //final String orderStatus;
  final List<CartItem> items;
  //final Payment paymentMethod;
  final String email;
  final String coupon;

  Order({
    this.email,
    this.coupon,
    @required this.id,
    @required this.items,
    //@required this.address,
    @required this.dateTime,
    @required this.totalPrice,
    //@required this.orderStatus,
    //@required this.paymentMethod,
  });
}
