import 'package:edge/provider/Cart_provider.dart';
import 'package:edge/provider/auth.dart';
import 'package:edge/provider/items_provider.dart';
import 'package:edge/provider/orders_provider.dart';
import 'package:edge/screens/Edit_item_screen.dart';
import 'package:edge/screens/admin_screen.dart';

import 'package:edge/screens/home_screen.dart';
import 'package:edge/screens/manage_products_screen.dart';
import 'package:edge/screens/manage_users.dart';

import 'package:edge/screens/sign_up_screen.dart';
import 'package:edge/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String routeMe(bool isLogged, bool isAdmin) {
    String route;
    if (isLogged) {
      if (isAdmin) {
        route = AdminPage.routeName;
      } else
        route = HomePage.routeName;
    } else
      route = SignUpScreen.routeName;
    return route;
  }

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ItemsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrdersProvider(),
        ),
      ],
      child: Consumer<Auth>(builder: (context, auth, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "edge.",
          themeMode: ThemeMode.light,
          theme: ThemeData(
            canvasColor: Colors.transparent,
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black),
            primaryColor: Colors.black,
            backgroundColor: Colors.white,
            accentColor: Colors.black,
            textSelectionTheme: TextSelectionThemeData(
                selectionHandleColor: Colors.black,
                cursorColor: Colors.black,
                selectionColor: Colors.black.withOpacity(0.15)),
            indicatorColor: Colors.black,
            splashColor: Colors.black12,
            appBarTheme: AppBarTheme(
                brightness: Brightness.light,
                elevation: 0,
                centerTitle: true,
                color: Colors.white),
            fontFamily: 'Wavehaus',
            textTheme: TextTheme(
                headline1: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                bodyText1: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black54)),
          ),
          home: FutureBuilder(
              future: auth.tryAutologin(),
              builder: (context, authResult) {
                return SplashScreen(
                    route: !authResult.hasData
                        ? ''
                        : routeMe(authResult.data, auth.isAdmin));
              }),
          builder: (context, child) => ResponsiveWrapper.builder(child,
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(480, name: MOBILE),
                ResponsiveBreakpoint.autoScale(600),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
              background: Container(color: Colors.white)),
          routes: {
            HomePage.routeName: (ctx) => HomePage(),
            SignUpScreen.routeName: (ctx) => SignUpScreen(),
            ManageProductsScreen.routeName: (ctx) => ManageProductsScreen(),
            ManageUsersScreen.routename: (ctx) => ManageUsersScreen(),
            EditItemScreen.routeName: (ctx) => EditItemScreen(),
            AdminPage.routeName: (ctx) => AdminPage(),
          },
        );
      }),
    );
  }
}
