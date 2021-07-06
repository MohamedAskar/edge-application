import 'package:edge/provider/auth.dart';
import 'package:edge/screens/sign_in_screen.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:edge/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: EdgeAppBar(
            listsearch: [],
            profile: false,
            cart: true,
            search: true,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Hero(
                        tag: 'profile',
                        child: CircleAvatar(
                          radius: 75.0,
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/images/avatar.png'),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    user.userName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Colors.black,
                          ),
                          label: Text(
                            'Edit Profile',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          )),
                      TextButton.icon(
                          onPressed: () {
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Toast.show(
                                            'Logging out...',
                                            context,
                                            duration: 3,
                                            gravity: Toast.BOTTOM,
                                          );
                                          Provider.of<Auth>(context,
                                                  listen: false)
                                              .logout();
                                          Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 150),
                                                  opaque: false,
                                                  pageBuilder:
                                                      (_, animation1, __) {
                                                    return SlideTransition(
                                                        position: Tween(
                                                                begin: Offset(
                                                                    1.0, 0.0),
                                                                end: Offset(
                                                                    0.0, 0.0))
                                                            .animate(
                                                                animation1),
                                                        child: SignInScreen());
                                                  }));
                                        },
                                        child: Text(
                                          'Yes',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        )),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          label: Text(
                            'Logout',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Settings(),
            )
          ],
        ),
      ),
    );
  }
}
