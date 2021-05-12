import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/screens/item_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';

class ItemWidget extends StatelessWidget {
  final String id;
  final String itemName;
  final String image;
  final dynamic price;
  final dynamic discount;
  ItemWidget(
      {@required this.id,
      @required this.itemName,
      @required this.image,
      @required this.price,
      this.discount});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ItemDetailsPage.routeName, arguments: id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: id,
              child: CachedNetworkImage(
                width: (size.width - 32) / 2,
                height: size.height / 4,
                imageUrl: image,
                fit: BoxFit.fitWidth,
                progressIndicatorBuilder: (context, url, progress) => Container(
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
              height: 8,
            ),
            Text(
              itemName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '$price LE',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
