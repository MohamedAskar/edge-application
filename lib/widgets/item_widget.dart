import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/screens/item_details_page.dart';
import 'package:flutter/material.dart';

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
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 150),
                opaque: false,
                pageBuilder: (_, animation1, __) {
                  return SlideTransition(
                      position:
                          Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                              .animate(animation1),
                      child: ItemDetailsPage(
                        itemID: id,
                      ));
                }));
        ;
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  width: (size.width - 32) / 2,
                  height: size.height / 4,
                  imageUrl: image,
                  fit: BoxFit.fitWidth,
                  filterQuality: FilterQuality.none,
                  fadeInCurve: Curves.easeInOut,
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
              ],
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
              '\$$price',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
