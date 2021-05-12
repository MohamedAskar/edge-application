import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:edge/main.dart';
import 'package:edge/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'edge.',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 100,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 40,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Wavehaus',
                  shadows: [
                    Shadow(
                      blurRadius: 7.0,
                      color: Colors.white,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  onFinished: () => Navigator.of(context)
                      .pushReplacementNamed(HomePage.routeName),
                  animatedTexts: [
                    FlickerAnimatedText('you shop,',
                        speed: Duration(seconds: 5)),
                    TypewriterAnimatedText('we ship.'),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}