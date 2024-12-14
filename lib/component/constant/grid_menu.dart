
import 'package:flutter/widgets.dart';
import 'package:helloworld/component/constant/system_icons.dart';

class GridMenu {
  const GridMenu(this.title, this.icon, this.route);
  final String title;
  final IconData icon;
  final String route;
}

const List<GridMenu> gridMenus = <GridMenu>[
  GridMenu('Home', SystemIcons.home, '/home'),
  GridMenu('About', SystemIcons.info, '/about'),
  GridMenu('Contact', SystemIcons.user, '/contact'),
  GridMenu('Settings', SystemIcons.settings, '/settings'),
  GridMenu('Message', SystemIcons.email, '/message'),
  GridMenu('Logout', SystemIcons.logout, '/logout'),
];
