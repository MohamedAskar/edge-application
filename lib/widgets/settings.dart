import 'package:edge/screens/orders_screen.dart';
import 'package:edge/screens/wishlist_screen.dart';
import 'package:edge/settings_ui/settings_list.dart';
import 'package:edge/settings_ui/settings_section.dart';
import 'package:edge/settings_ui/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: 'My Account',
          tiles: [
            SettingsTile(
              enabled: true,
              onTap: () {
                Navigator.pushNamed(context, OrdersScreen.routeName);
              },
              title: 'My Orders',
              leading: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black87,
              ),
            ),
            SettingsTile(
              title: 'ًWishlist',
              enabled: true,
              onTap: () {
                Navigator.pushNamed(context, WishListScreen.routeName);
              },
              leading: Icon(
                Ionicons.heart_outline,
                color: Colors.black87,
              ),
            ),
            SettingsTile(
              title: 'Addresses',
              enabled: true,
              onTap: () {},
              leading: Icon(
                Icons.location_history_outlined,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SettingsSection(
          title: 'Settings  (We are not there yet!)',
          tiles: [
            SettingsTile(
              title: 'Country',
              leading: Icon(
                Icons.location_city_outlined,
                color: Colors.black87,
              ),
              trailing: Text('EG'),
            ),
            SettingsTile(
              title: 'Language',
              leading: Icon(
                Icons.language_outlined,
                color: Colors.black87,
              ),
              trailing: Text('English'),
            ),
            SettingsTile.switchTile(
              leading: Icon(
                Icons.notifications_active_outlined,
                color: Colors.black87,
              ),
              title: 'Notification',
              switchValue: true,
              onToggle: (value) {},
            )
          ],
        ),
        SettingsSection(
          title: 'Reach out to us  (We are not there yet!)',
          tiles: [
            SettingsTile(
              title: 'Store Locations',
              enabled: true,
              leading: Icon(
                Icons.storefront_outlined,
                color: Colors.black87,
              ),
              onTap: () {},
            ),
            SettingsTile(
              title: 'Feedback',
              enabled: true,
              leading: Icon(
                Icons.feedback_outlined,
                color: Colors.black87,
              ),
            ),
            SettingsTile(
              onTap: () async {},
              title: 'Help',
              enabled: true,
              leading: Icon(
                Icons.live_help_outlined,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SettingsSection(
          title: 'About  (We are not there yet!)',
          tiles: [
            SettingsTile(
              title: 'About us',
              enabled: true,
              leading: Icon(
                Icons.info_outline,
                color: Colors.black87,
              ),
              onTap: () {},
            )
          ],
        )
      ],
    );
  }
}
