import 'dart:io';

import 'package:edge/provider/auth.dart';
import 'package:edge/screens/manage_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ManageUsersScreen extends StatefulWidget {
  static const routename = 'manage-users';
  final bool isOrders;
  ManageUsersScreen({this.isOrders});
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  List<User> users;
  bool isLoading = true;

  @override
  void initState() {
    final auth = Provider.of<Auth>(context, listen: false);
    try {
      auth.getAllUsers().whenComplete(() {
        print('done');
        users = auth.users;
        isLoading = false;
      });
    } on HttpException {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('An error occurred!',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              content: Text(
                'Something went wrong! Please try again later.',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay',
                      style: Theme.of(context).textTheme.bodyText1),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            );
          });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'edge.',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Ionicons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: (isLoading)
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : AnimationLimiter(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, i) {
                    return AnimationConfiguration.staggeredList(
                      position: i,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: InkWell(
                            onTap: widget.isOrders
                                ? () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            transitionDuration: const Duration(
                                                milliseconds: 150),
                                            opaque: false,
                                            pageBuilder: (_, animation1, __) {
                                              return SlideTransition(
                                                  position: Tween(
                                                          begin:
                                                              Offset(1.0, 0.0),
                                                          end: Offset(0.0, 0.0))
                                                      .animate(animation1),
                                                  child: ManageOrdersPage(
                                                    userID: users[i].id,
                                                  ));
                                            }));
                                  }
                                : null,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                          text: 'User ID:  ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87),
                                          children: [
                                            TextSpan(
                                              text: users[i].id,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800),
                                            )
                                          ]),
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Ionicons.person_outline,
                                          size: 42,
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${users[i].name}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              '${users[i].email}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
