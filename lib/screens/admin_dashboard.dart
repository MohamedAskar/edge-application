import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/fade_animation.dart';
import 'package:edge/screens/manage_products_screen.dart';
import 'package:edge/screens/manage_users.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: EdgeAppBar(
            cart: false,
            profile: true,
            search: false,
            addItem: false,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admin Dashboard',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 26),
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Opacity(
                      opacity: 0.8,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        height: (size.width - 64) / 2,
                        width: (size.width - 64) / 2,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  "https://images8.alphacoders.com/809/809459.jpg",
                                ),
                                fit: BoxFit.fill)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'MANAGE PRODUCTS',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                        context, ManageProductsScreen.routeName);
                    // Navigator.push(
                    //     context,
                    //     PageRouteBuilder(
                    //         transitionDuration:
                    //             const Duration(milliseconds: 150),
                    //         opaque: false,
                    //         pageBuilder: (_, animation1, __) {
                    //           return SlideTransition(
                    //               position: Tween(
                    //                       begin: Offset(1.0, 0.0),
                    //                       end: Offset(0.0, 0.0))
                    //                   .animate(animation1),
                    //               child: ManageProductsScreen());
                    //         }));
                  },
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Opacity(
                      opacity: 0.8,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        height: (size.width - 64) / 2,
                        width: (size.width - 64) / 2,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    "https://images3.alphacoders.com/809/809460.jpg"),
                                fit: BoxFit.fill)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'MANAGE USERS',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, ManageUsersScreen.routename);
                    // Navigator.push(
                    //     context,
                    //     PageRouteBuilder(
                    //         transitionDuration:
                    //             const Duration(milliseconds: 150),
                    //         opaque: false,
                    //         pageBuilder: (_, animation1, __) {
                    //           return SlideTransition(
                    //               position: Tween(
                    //                       begin: Offset(1.0, 0.0),
                    //                       end: Offset(0.0, 0.0))
                    //                   .animate(animation1),
                    //               child: ManageUsersScreen());
                    //         }));
                  },
                ),
              ],
            ),
            InkWell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    height: (size.width - 32) / 2,
                    width: size.width,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                'https://cdn.pixabay.com/photo/2017/07/08/09/49/gradient-2483939_960_720.jpg'),
                            fit: BoxFit.fill)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'MANAGE ORDERS',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}
