import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:helloworld/module/root/custom_navigation_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../component/constant/side_bar_tiles.dart';
import '../../util/constant.dart';
import '../../util/platform.dart';

/// RootApp
class RootApp extends HookConsumerWidget {
  final Widget child;

  const RootApp({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);

    var animationController = useAnimationController(
        duration: Duration(milliseconds: transitionLength.toInt() * 2));

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    int screenIndex = ScreenSelected.component.value;

    useEffect(() {
      // 启动动画
      animationController.repeat();
      return () => animationController.dispose(); // 清理资源
    }, []);

    final scaffold = Scaffold(
      key: scaffoldKey,
      body: child,
      extendBody: true,
      drawerScrimColor: Colors.transparent,
      // endDrawer: kIsDesktop
      //     ? Container(
      //     constraints: const BoxConstraints(maxWidth: 800),
      //     decoration: BoxDecoration(
      //       boxShadow: theme.brightness == Brightness.light
      //           ? null
      //           : kElevationToShadow[8],
      //     ),
      //     margin: const EdgeInsets.only(
      //       top: 40,
      //       bottom: 100,
      //     ),
      //     child: Consumer(
      //         builder: (context, ref, _) {
      //           return Drawer(
      //             child: const CustomDrawer(),
      //           );
      //         }
      //     );
      // )
      //     : null,
      // 桌面端显示抽屉
      bottomNavigationBar: const CustomNavigationBar(),
    );

    final routerState = GoRouterState.of(context);

    final navbarTileList = getNavbarTileList();
    // final navbarTileList = useMemoized(
    //       () => getNavbarTileList(context.l10n),
    //   [context.l10n],
    // );

    // 选中项
    final selectedIndex = useMemoized(() {
      final index = navbarTileList.indexWhere(
        (e) => routerState.namedLocation(e.name) == routerState.matchedLocation,
      );

      return index == -1 ? 0 : index;
    }, [navbarTileList, routerState.matchedLocation]);

    List<NavigationDestination> appDestinations = navbarTileList.map((e) {
      return NavigationDestination(
        tooltip: e.title,
        label: e.title,
        icon: Badge(
            isLabelVisible: true,
            label: const Text('10'),
            child: Icon(
              e.icon,
              color: Theme.of(context).colorScheme.primary,
            )),
      );
    }).toList();

    var layout = AdaptiveLayout(
      primaryNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig?>{
        Breakpoints.medium: SlotLayout.from(
            key: const Key('primaryNavigation'),
            builder: (_) {
              return AdaptiveScaffold.standardNavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  GoRouter.of(context).goNamed(navbarTileList[index].name);
                },
                destinations:
                    appDestinations.map((NavigationDestination destination) {
                  return AdaptiveScaffold.toRailDestination(destination);
                }).toList(),
              );
            }),
        Breakpoints.mediumLarge: SlotLayout.from(
            key: const Key('MediumLarge primaryNavigation'),
            builder: (_) {
              return AdaptiveScaffold.standardNavigationRail(
                // 展开label
                extended: true,
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  GoRouter.of(context).goNamed(navbarTileList[index].name);
                },
                destinations:
                    appDestinations.map((NavigationDestination destination) {
                  return AdaptiveScaffold.toRailDestination(destination);
                }).toList(),
              );
            }),
        Breakpoints.large: SlotLayout.from(
            key: const Key('Large primaryNavigation'),
            builder: (_) {
              return AdaptiveScaffold.standardNavigationRail(
                extended: true,
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  GoRouter.of(context).goNamed(navbarTileList[index].name);
                },
                destinations:
                    appDestinations.map((NavigationDestination destination) {
                  return AdaptiveScaffold.toRailDestination(destination);
                }).toList(),
              );
            }),
        Breakpoints.extraLarge: SlotLayout.from(
            key: const Key('ExtraLarge primaryNavigation'),
            builder: (_) {
              return AdaptiveScaffold.standardNavigationRail(
                extended: true,
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  GoRouter.of(context).goNamed(navbarTileList[index].name);
                },
                destinations:
                    appDestinations.map((NavigationDestination destination) {
                  return AdaptiveScaffold.toRailDestination(destination);
                }).toList(),
              );
            })
      }),
      bottomNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig?>{
        Breakpoints.small: SlotLayout.from(
          key: const Key('bottomNavigation'),
          // You can define inAnimations or outAnimations to override the
          // default offset transition.
          outAnimation: AdaptiveScaffold.topToBottom,
          builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
            currentIndex: selectedIndex,
            onDestinationSelected: (index) {
              GoRouter.of(context).goNamed(navbarTileList[index].name);
            },
            destinations: appDestinations,
          ),
        )
      }),
      body: SlotLayout(config: <Breakpoint, SlotLayoutConfig?>{
        Breakpoints.standard: SlotLayout.from(
          key: const Key('body'),
          builder: (_) => const Text("test1"),
        ),
      }),
      secondaryBody: SlotLayout(config: <Breakpoint, SlotLayoutConfig?>{
        Breakpoints.mediumAndUp: SlotLayout.from(
          // This overrides the default behavior of the secondaryBody
          // disappearing as it is animating out.
          outAnimation: AdaptiveScaffold.stayOnScreen,
          key: const Key('Secondary Body'),
          builder: (_) => SafeArea(
            child: Text("test2"),
            // child: _DetailTile(item: _allItems[selected ?? 0]),
          ),
        )
      }),
    );

    return layout;
  }
}
