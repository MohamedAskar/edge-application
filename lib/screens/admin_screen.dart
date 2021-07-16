import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/provider/auth.dart';
import 'package:edge/screens/manage_products_screen.dart';
import 'package:edge/screens/manage_users.dart';
import 'package:edge/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AdminPage extends StatefulWidget {
  static const routeName = 'admin-dashboard';
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.black);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      setState(() {
        isLoaded = true;
      });
    }
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
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
            icon: Icon(
              Ionicons.log_out_outline,
              color: Colors.white,
            ),
            onPressed: () async {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      'Do you want to logout?',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'No',
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                      TextButton(
                          onPressed: () {
                            Toast.show(
                              'Logging out...',
                              context,
                              duration: 3,
                              gravity: Toast.BOTTOM,
                            );
                            Provider.of<Auth>(context, listen: false).logout();
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 150),
                                    opaque: false,
                                    pageBuilder: (_, animation1, __) {
                                      return SlideTransition(
                                          position: Tween(
                                                  begin: Offset(1.0, 0.0),
                                                  end: Offset(0.0, 0.0))
                                              .animate(animation1),
                                          child: SignInScreen());
                                    }));
                          },
                          child: Text(
                            'Yes',
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
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
                    // Navigator.pushNamed(
                    //     context, ManageProductsScreen.routeName);
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 150),
                            opaque: false,
                            pageBuilder: (_, animation1, __) {
                              return SlideTransition(
                                  position: Tween(
                                          begin: Offset(1.0, 0.0),
                                          end: Offset(0.0, 0.0))
                                      .animate(animation1),
                                  child: ManageProductsScreen());
                            }));
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
                    // Navigator.pushNamed(context, ManageUsersScreen.routename,
                    //     arguments: false);
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 150),
                            opaque: false,
                            pageBuilder: (_, animation1, __) {
                              return SlideTransition(
                                  position: Tween(
                                          begin: Offset(1.0, 0.0),
                                          end: Offset(0.0, 0.0))
                                      .animate(animation1),
                                  child: ManageUsersScreen(
                                    isOrders: false,
                                  ));
                            }));
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
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 150),
                        opaque: false,
                        pageBuilder: (_, animation1, __) {
                          return SlideTransition(
                              position: Tween(
                                      begin: Offset(1.0, 0.0),
                                      end: Offset(0.0, 0.0))
                                  .animate(animation1),
                              child: ManageUsersScreen(
                                isOrders: true,
                              ));
                        }));
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}
