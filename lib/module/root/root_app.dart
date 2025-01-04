import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:helloworld/module/root/custom_navigation_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../util/constant.dart';

/// RootApp
class RootApp extends HookConsumerWidget {
  final Widget child;

  const RootApp({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
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
      bottomNavigationBar: const CustomNavigationBar(),
    );

    return scaffold;
  }
}
