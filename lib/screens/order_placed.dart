import 'package:edge/screens/home_screen.dart';
import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatelessWidget {
  static const routeName = 'order-placed';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/done.png',
          ),
          Text(
            'We Love you!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            ' You Order will be between your hands as fast as possible.',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
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
                              child: HomePage());
                        }));
                ;
              },
              child: Center(
                child: Text(
                  'CONTINUE SHOPPING',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
