import 'package:edge/provider/Cart_provider.dart';
import 'package:edge/provider/auth.dart';
import 'package:edge/provider/items_provider.dart';
import 'package:edge/screens/cart_screen.dart';
import 'package:edge/screens/category_screen.dart';
import 'package:edge/screens/checkout_screen.dart';
import 'package:edge/screens/home_screen.dart';
import 'package:edge/screens/item_details_page.dart';
import 'package:edge/screens/orders_screen.dart';
import 'package:edge/screens/sign_in_screen.dart';
import 'package:edge/screens/sign_up_screen.dart';
import 'package:edge/screens/profile_screen.dart';
import 'package:edge/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        )
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
                        : authResult.data
                            ? HomePage.routeName
                            : SignInScreen.routeName);
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
            CartScreen.routeName: (ctx) => CartScreen(),
            HomePage.routeName: (ctx) => HomePage(),
            ItemDetailsPage.routeName: (ctx) => ItemDetailsPage(),
            CategoryScreen.routeName: (ctx) => CategoryScreen(),
            SignInScreen.routeName: (ctx) => SignInScreen(),
            SignUpScreen.routeName: (ctx) => SignUpScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            CheckoutScreen.routeName: (ctx) => CheckoutScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
          },
        );
      }),
    );
  }
}
