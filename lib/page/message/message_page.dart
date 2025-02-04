import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessagePage extends HookConsumerWidget {
  static const String name = 'Message';
  static const String path = '/message';

  const MessagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text(name,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.w600)),
          middle: Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          alwaysShowMiddle: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text('Item ${index + 1}'),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}
