import 'package:flutter/material.dart';
import 'package:helloworld/component/constant/grid_menu.dart';

import '../setting/appearance.dart';

const Widget divider = SizedBox(height: 10);

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

class MyView extends StatelessWidget {
  const MyView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < narrowScreenWidthThreshold) {
        // 小屏幕
        return const SingleChildScrollView(
          child: Column(
            children: [
              divider,
              // CustomScrollView(
              //   slivers: [MenuGrid()],
              // ),
              SettingsAppearanceSection(),
              divider,
              // schemeView(darkTheme),
            ],
          ),
        );
      } else {
        // 大屏幕
        return const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                SettingsAppearanceSection(),
                SizedBox(height: 16),
                // const SettingsAppearanceSection(),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      }
    });

    // return Expanded(
    //   child: CustomScrollView(slivers: [
    //     SliverToBoxAdapter(
    //       child: Padding(
    //         padding: const EdgeInsets.fromLTRB(16.0, 20, 16.0, 0),
    //         child: Text(
    //           'My View',
    //           style: Theme.of(context).textTheme.titleLarge,
    //         ),
    //       ),
    //     )
    //   ]),
    // );
  }
}
