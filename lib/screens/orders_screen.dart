import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = 'orders-screen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: EdgeAppBar(cart: false, profile: false, search: false)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Card(
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order NAESHSS545643',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'PLaced on Jun 21, 2021',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    InkWell(
                      child: Text(
                        'View Details >',
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                      itemCount: 2,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, __) => Container(
                            padding: const EdgeInsets.only(right: 14),
                            width: size.width / 1.7,
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  width: size.width / 4,
                                  imageUrl:
                                      "https://res.cloudinary.com/djtpiagbk/image/upload/v1624209166/Men/Summer/14/4241552711_2_3_8_rzkeam.webp",
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Container(
                                    height: 60,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'STWD logo T-shirt - ecologically grown cotton',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Shipped',
                                        style: TextStyle(
                                            color: Colors.yellow[700],
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _horizontalListView() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Order NAESHSS545643',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(
              'PLaced on Jun 21,2021',
              style: TextStyle(color: Colors.black87),
            ),
            InkWell(
              child: Text(
                'View Details >',
                style: TextStyle(color: Colors.blue, fontSize: 13),
              ),
              onTap: () {},
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, __) => Row(
                    children: [
                      Image(
                          image: NetworkImage(
                              'https://gungorkaya.com/en/wp-content/uploads/2020/03/tergan-casual-shoes-300x300.jpg')),
                      Column(
                        children: [
                          Text('Black SHoes size 43 and \nhave white line'),
                          SizedBox(
                            height: 10,
                          ),
                          Text('35 LE'),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Shipped',
                            style: TextStyle(color: Colors.yellow[600]),
                          )
                        ],
                      )
                    ],
                  )),
        ),
        Divider(
          indent: 30,
          endIndent: 30,
        )
      ],
    );
  }

  Widget _buildBox() => Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Order ORDSSHSS500643',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                'PLaced on May 21,2021',
                style: TextStyle(color: Colors.black87),
              ),
              InkWell(
                child: Text(
                  'View Details >',
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                ),
                onTap: () {},
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, __) => Row(
                children: [
                  Image(
                      image: NetworkImage(
                          'https://gungorkaya.com/en/wp-content/uploads/2020/03/tergan-casual-shoes-300x300.jpg')),
                  Column(
                    children: [
                      Text('Black SHoes size 46 and \nhave white line'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('45 LE'),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'DELIVERED',
                        style: TextStyle(color: Colors.green[600]),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(
            indent: 30,
            endIndent: 30,
          )
        ],
      );
}
