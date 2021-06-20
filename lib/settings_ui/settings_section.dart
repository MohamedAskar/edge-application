import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'cupertino_settings_section.dart';

// ignore: must_be_immutable
class SettingsSection extends StatelessWidget {
  final String title;
  final List<dynamic> tiles;
  bool showBottomDivider = false;

  SettingsSection({
    Key key,
    this.tiles,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || Platform.isIOS)
      return iosSection();
    else if (Platform.isAndroid)
      return androidSection(context);
    else
      return androidSection(context);
  }

  Widget iosSection() {
    return CupertinoSettingsSection(tiles,
        header: title == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Wavehaus',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87),
                ),
              ));
  }

  Widget androidSection(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      title == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: 'Wavehaus',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.7)),
              ),
            ),
      ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: tiles.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1),
        itemBuilder: (BuildContext context, int index) {
          return tiles[index];
        },
      ),
      if (showBottomDivider) Divider(height: 1)
    ]);
  }
}
