import 'package:flutter/material.dart';
import 'package:helloworld/component/constant/grid_menu.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../setting/appearance.dart';

const double narrowScreenWidthThreshold = 500;

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
  static const name = "my";
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        // appBar: PageWindowTitleBar(
        //   title: Text(context.l10n.settings),
        //   centerTitle: true,
        //   automaticallyImplyLeading: true,
        // ),
        body: Scrollbar(
          // controller: controller,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1366),
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(scrollbars: false),
                child: ListView(
                  // controller: controller,
                  children: [
                    // const SettingsAccountSection(),
                    // const SettingsLanguageRegionSection(),
                    const SettingsAppearanceSection(),
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
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
