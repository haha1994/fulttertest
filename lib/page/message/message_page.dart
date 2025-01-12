import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessagePage extends HookConsumerWidget {
  static const String name = 'message';
  static const String path = '/message';
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Expanded(
      child: ListView(
          children: const <Widget>[
            SizedBox(height: 7),
            Text("消息")
          ]),
    );
  }
}
