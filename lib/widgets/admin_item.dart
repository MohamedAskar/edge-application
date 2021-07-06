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
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 160,
                    width: 145,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                      InkWell(
                        onTap: () {},
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(price.toString() + ' LE',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                // Navigator.of(context).pushNamed(
                                //     EditProduct.routeName,
                                //     arguments: product.id);
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
                                    fontSize: 10),
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
                                        'If this item is deleted, it will disapear from your database.'),
                                    actions: <Widget>[
                                      // ignore: deprecated_member_use
                                      Row(
                                        children: [
                                          FlatButton(
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
                                              child: Text('Yes',
                                                  style: TextStyle(
                                                      color: Colors.black))),
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Colors.black),
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
                                    fontSize: 10),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
              thickness: 0.3,
            )
          ],
        ));
  }
}
