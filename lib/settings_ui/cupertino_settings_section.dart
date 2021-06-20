import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'settings_tile.dart';

class CupertinoSettingsSection extends StatelessWidget {
  const CupertinoSettingsSection(
    this.items, {
    this.header,
    this.footer,
  }) : assert(items != null);

  final List<Widget> items;

  final Widget header;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    final List<Widget> columnChildren = [];
    if (header != null) {
      columnChildren.add(DefaultTextStyle(
        style: Theme.of(context).textTheme.headline2,
        child: header,
      ));
    }

    List<Widget> itemsWithDividers = [];
    for (int i = 0; i < items.length; i++) {
      final leftPadding =
          (items[i] as SettingsTile).leading == null ? 15.0 : 54.0;
      if (i < items.length - 1) {
        itemsWithDividers.add(items[i]);
        itemsWithDividers.add(Divider(
          height: 0.3,
          indent: leftPadding,
        ));
      } else {
        itemsWithDividers.add(items[i]);
      }
    }

    columnChildren.add(
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? CupertinoColors.white
              : Color.fromRGBO(28, 28, 30, 1),
          border: Border(
            top: const BorderSide(
              color: Color(0xFFBCBBC1),
              width: 0.3,
            ),
            bottom: const BorderSide(
              color: Color(0xFFBCBBC1),
              width: 0.3,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: itemsWithDividers,
        ),
      ),
    );

    if (footer != null) {
      columnChildren.add(DefaultTextStyle(
        style: TextStyle(
          color: Color(0xFF777777),
          fontSize: 13.0,
          letterSpacing: -0.08,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 7.5,
          ),
          child: footer,
        ),
      ));
    }

    return Padding(
      padding: EdgeInsets.only(
        top: header == null ? 35.0 : 22.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnChildren,
      ),
    );
  }
}
