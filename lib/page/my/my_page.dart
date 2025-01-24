import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/component/constant/grid_menu.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../util/constant.dart';
import '../setting/appearance.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<GestureDetector> gridCells = gridMenus
        .map(
          (gridMenu) => GestureDetector(
            child: Icon(gridMenu.icon),
            onTap: () {
              //导航到新路由
              Navigator.pushNamed(context, gridMenu.route);
            },
          ),
        )
        .toList();

    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverLayoutBuilder(builder: (context, constraints) {
        if (constraints.crossAxisExtent < narrowScreenWidthThreshold) {
          return SliverGrid.count(
            crossAxisCount: 3,
            children: gridCells,
          );
        } else {
          return SliverGrid.count(
            crossAxisCount: 6,
            children: gridCells,
          );
        }
      }),
    );
  }
}

class MyPage extends HookConsumerWidget {
  static const String name = "my";
  static const String path = "/my";

  const MyPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return CustomScrollView(slivers: <Widget>[
      CupertinoSliverNavigationBar(
        largeTitle: Text('我的',
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontWeight: FontWeight.w600)),
        middle: Text(
          '我的',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        alwaysShowMiddle: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      SliverList(
        delegate: SliverChildListDelegate([const SettingsAppearanceSection(),])
      ),
      const SliverToBoxAdapter(
        child: SizedBox(
          height: 800,
          child: Center(child: Text('滚动内容区域'),),
        ),
      )
    ]);

    // const SettingsAccountSection(),
    // const SettingsLanguageRegionSection(),
    // SettingsAppearanceSection(),
    // const SettingsPlaybackSection(),
    // const SettingsDownloadsSection(),
    // if (kIsDesktop) const SettingsDesktopSection(),
    // if (!kIsWeb) const SettingsDevelopersSection(),
    // const SettingsAboutSection(),
    // Center(
    //   child: FilledButton(
    //     onPressed: preferencesNotifier.reset,
    //     child: Text(context.l10n.restore_defaults),
    //   ),
    // ),

  }
}
