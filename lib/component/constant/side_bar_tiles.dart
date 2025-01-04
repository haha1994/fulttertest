import 'package:flutter/material.dart';

import '../../module/home/home_page.dart';
import '../../module/message/message_page.dart';
import '../../module/my/my_page.dart';
import '../../search.dart';
import 'system_icons.dart';

class SideBarTiles {
  final IconData icon;
  final String title;
  final String id;
  final String name;

  SideBarTiles({
    required this.icon,
    required this.title,
    required this.id,
    required this.name,
  });
}

/// 侧边栏
// List<SideBarTiles> getSidebarTileList(AppLocalizations l10n) => [
List<SideBarTiles> getSidebarTileList() => [
  SideBarTiles(
    id: "home",
    name: HomePage.name,
    icon: SystemIcons.home,
    title: HomePage.name,
  ),
  SideBarTiles(
    id: "search",
    name: SearchPage.name,
    icon: SystemIcons.search,
    title: SearchPage.name,
  ),
  SideBarTiles(
    id: "Message",
    name: MessagePage.name,
    icon: SystemIcons.library,
    title: MessagePage.name,
  ),
  SideBarTiles(
    id: "my",
    name: MyPage.name,
    icon: SystemIcons.music,
    title: MyPage.name,
  ),
  // SideBarTiles(
  //   id: "stats",
  //   name: StatsPage.name,
  //   icon: SystemIcons.chart,
  //   title: l10n.stats,
  // ),
];

/// 底部导航栏
// List<SideBarTiles> getNavbarTileList(AppLocalizations l10n) => [
List<SideBarTiles> getNavbarTileList() => [
  SideBarTiles(
    id: "home",
    name: HomePage.name,
    icon: SystemIcons.home,
    title: HomePage.name,
  ),
  SideBarTiles(
    id: "search",
    name: SearchPage.name,
    icon: SystemIcons.search,
    title: SearchPage.name,
  ),
  SideBarTiles(
    id: "Message",
    name: MessagePage.name,
    icon: SystemIcons.library,
    title: MessagePage.name,
  ),
  SideBarTiles(
    id: "my",
    name: MyPage.name,
    icon: SystemIcons.music,
    title: MyPage.name,
  ),
];
