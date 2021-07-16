import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/screens/Edit_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AdminItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String price;
  AdminItem(
      {@required this.title, @required this.imageUrl, @required this.price});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: CachedNetworkImageProvider(imageUrl)),
                        borderRadius: BorderRadius.circular(6)),
                    height: 120,
                    width: 100,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title.trimRight(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('\$${price.toString()}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            )),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton.icon(
                                onPressed: () {
                                  showDialog<Null>(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text(
                                        'Alert',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                        'Sorry, we restrict editing items right now. We do not want to mess the data up.',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      actions: <Widget>[
                                        // ignore: deprecated_member_use

                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text(
                                              'Okay',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            )),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  'Edit Item',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                                )),
                            TextButton.icon(
                                onPressed: () {
                                  showDialog<Null>(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text(
                                        'Are you sure ?',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                        'If this item is deleted, it will disapear from your database.',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      actions: <Widget>[
                                        // ignore: deprecated_member_use
                                        Row(
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Toast.show(
                                                    'Deleting...',
                                                    context,
                                                    duration: 2,
                                                    gravity: Toast.CENTER,
                                                  );
                                                  // Provider.of<Products>(context,
                                                  //         listen: false)
                                                  //     .deleteProduct(
                                                  //         product.id);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Yes',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text(
                                                  'No',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.delete_outlined,
                                  color: Colors.red,
                                ),
                                label: Text(
                                  'Remove Item',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
