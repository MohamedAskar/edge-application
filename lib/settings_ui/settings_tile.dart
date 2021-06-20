import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'cupertino_settings_item.dart';

enum _SettingsTileType { simple, switchTile }

class SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon leading;
  final Widget trailing;
  final VoidCallback onTap;
  final Function(bool value) onToggle;
  final bool switchValue;
  final bool enabled;
  final _SettingsTileType _tileType;

  const SettingsTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.enabled = true,
  })  : _tileType = _SettingsTileType.simple,
        onToggle = null,
        switchValue = null,
        super(key: key);

  const SettingsTile.switchTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    this.enabled = true,
    this.trailing,
    @required this.onToggle,
    @required this.switchValue,
  })  : _tileType = _SettingsTileType.switchTile,
        onTap = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || Platform.isIOS) {
      return iosTile();
    } else {
      return androidTile();
    }
  }

  Widget iosTile() {
    if (_tileType == _SettingsTileType.switchTile) {
      return CupertinoSettingsItem(
        enabled: enabled,
        type: SettingsItemType.toggle,
        label: title,
        leading: leading,
        switchValue: switchValue,
        onToggle: onToggle,
      );
    } else {
      return CupertinoSettingsItem(
        enabled: enabled,
        type: SettingsItemType.modal,
        label: title,
        value: subtitle,
        trailing: trailing,
        hasDetails: false,
        leading: leading,
        onPress: onTap,
      );
    }
  }

  Widget androidTile() {
    if (_tileType == _SettingsTileType.switchTile) {
      return SwitchListTile(
        secondary: leading,
        value: switchValue,
        onChanged: enabled ? onToggle : null,
        title: Text(
          title,
          style: TextStyle(
              fontFamily: 'Wavehaus',
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
      );
    } else {
      return ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontFamily: 'Wavehaus',
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        leading: leading,
        enabled: enabled,
        trailing: (trailing == null)
            ? Icon(
                Icons.chevron_right,
                color: Color(0xFFC7C7CC),
                size: 26,
              )
            : trailing,
        onTap: onTap,
      );
    }
  }
}
