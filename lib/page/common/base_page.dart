import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BasePage extends HookConsumerWidget {
  final String title;
  final List<Widget> children;

  const BasePage({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.w600)),
          middle: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          alwaysShowMiddle: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        ...children,
        // SliverList(delegate: SliverChildListDelegate([child])),
      ]),
    );
  }
}
