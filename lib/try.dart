import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:edge/main.dart';
import 'package:edge/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';

class TestPage extends StatelessWidget {
  static const routeName = 'test-page';
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    final method = ModalRoute.of(context).settings.arguments;
    var size = MediaQuery.of(context).size;
    final auth = Provider.of<Auth>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('User ${auth.userID} $method'),
      ),
    );
  }
}
