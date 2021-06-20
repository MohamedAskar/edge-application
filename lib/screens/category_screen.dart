import 'package:edge/widgets/edge_appbar.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  static final String routeName = 'Category-Screen';

  @override
  Widget build(BuildContext context) {
    final String cateogry = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: EdgeAppBar(
            listsearch: [],
            profile: true,
            cart: true,
            search: true,
          )),
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
