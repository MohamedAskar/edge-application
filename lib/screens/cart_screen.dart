import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/models/cart_item.dart';
import 'package:edge/provider/Cart_provider.dart';
import 'package:edge/provider/color_picker.dart';
import 'package:edge/screens/checkout_screen.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static final String routeName = 'Cart-Screen';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _couponFormKey = GlobalKey<FormBuilderState>();
  final _addressFormKey = GlobalKey<FormBuilderState>();
  bool _expanded = false;
  Map<String, CartItem> cartData;
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    cartData = Provider.of<CartProvider>(context, listen: false).cartItems;
    cartItems = cartData.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: EdgeAppBar(
            profile: true,
            cart: false,
            search: false,
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'YOUR SHOPPING CART',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            Divider(
              indent: 60,
              endIndent: 60,
            ),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              itemCount: cartItems.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      height: 160,
                      width: 145,
                      child: CachedNetworkImage(
                        imageUrl: cartItems[index].image,
                        fit: BoxFit.fitWidth,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Container(
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartItems[index].name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black26),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    child: Text(
                                      '${cartItems[index].quantity}',
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
                                          border:
                                              Border.all(color: Colors.black26),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: InkWell(
                                          child: Icon(
                                            Ionicons.add_outline,
                                            size: 22,
                                          ),
                                          onTap: () {
                                            if (cartItems[index].quantity <
                                                10) {
                                              setState(() {
                                                cartItems[index].quantity++;
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
                                          border:
                                              Border.all(color: Colors.black26),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: InkWell(
                                          child: Icon(
                                            Ionicons.remove_outline,
                                            size: 22,
                                          ),
                                          onTap: () {
                                            if (cartItems[index].quantity > 1) {
                                              setState(() {
                                                cartItems[index].quantity--;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                '${cartItems[index].price} LE',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              IconButton(
                                icon: Icon(Ionicons.close_outline),
                                onPressed: () {},
                              )
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 1.5,
                                            style: BorderStyle.solid)),
                                    child: CircleAvatar(
                                      backgroundColor: Color(ColorPicker()
                                          .hexColorToInt(
                                              cartItems[index].selectedColor)),
                                      radius: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${cartItems[index].selectedColor}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 1.5,
                                          style: BorderStyle.solid)),
                                  child: Center(
                                    child: Text(
                                      cartItems[index].selectedSize,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            FormBuilder(
              key: _couponFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: 'Coupon',
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            enableSuggestions: false,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              hintText: 'Coupon Code',
                              hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black12,
                          ),
                        ),
                        child: Text('APPLY COUPON',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black)))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Color(0xffEAEAEA),
                  child: Center(
                    child: Text(
                      'UPDATE CART',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xffF4F4F4),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'SHIPPING',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  FormBuilder(
                    key: _addressFormKey,
                    child: Column(
                      children: [
                        FormBuilderRadioGroup(
                          name: 'Shipping method',
                          decoration: InputDecoration(
                            fillColor: Colors.black38,
                            border: InputBorder.none,
                          ),
                          options: [
                            FormBuilderFieldOption(
                              value: 'Ground Shipping',
                              child: Text(
                                  'Ground Shipping - 2 to 5 business days. FREE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black)),
                            ),
                            FormBuilderFieldOption(
                              value: 'Express',
                              child: Text('Express - 2 to 3 days. \$10',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black)),
                            ),
                            FormBuilderFieldOption(
                              value: 'Overnight',
                              child: Text('Overnight - Next Day. \$25',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          title: Text('Calculate shipping',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black)),
                          trailing: InkWell(
                            child: Icon(
                              !_expanded
                                  ? Icons.expand_more_outlined
                                  : Icons.expand_less_outlined,
                              color: Colors.black,
                              size: 28,
                            ),
                            onTap: () {
                              setState(() {
                                _expanded = !_expanded;
                              });
                            },
                          ),
                        ),
                        if (_expanded)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 24,
                                ),
                                FormBuilderTextField(
                                  name: 'Country',
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  enabled: false,
                                  initialValue: 'Egypt',
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black54),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero),
                                    fillColor: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                FormBuilderTextField(
                                  name: 'Governorate',
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  enabled: true,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    hintText: 'Governorate',
                                    hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero),
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                FormBuilderTextField(
                                  name: 'City',
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  enabled: true,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    hintText: 'City',
                                    hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero),
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                FormBuilderTextField(
                                  name: 'Postcode',
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  enabled: true,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    hintText: 'ZIP/Postcode',
                                    hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    color: Color(0xffEAEAEA),
                                    child: Center(
                                      child: Text(
                                        'UPDATE',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Tax',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          '\$10',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          '\$100',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CheckoutScreen.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          'PROCEED TO CHECKOUT',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
