import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterPage<T> extends MaterialPage<T> {
  const RouterPage({required super.child});
}

class RouterSlidePage extends CustomTransitionPage {
  RouterSlidePage({
    required super.child,
    super.key,
  }) : super(
          reverseTransitionDuration: const Duration(milliseconds: 150),
          transitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
