import 'package:flutter/material.dart';
import 'package:helloworld/component/constant/side_bar_tiles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomNavigationBar extends HookConsumerWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    List<Widget> appDestinations = navbarTileList.map((e) {
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

    return NavigationBar(
      destinations: appDestinations,
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        GoRouter.of(context).goNamed(navbarTileList[index].name);
      }
    );
  }
}
