import 'package:flutter/material.dart';

class MyView extends StatelessWidget {
  const MyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 20, 16.0, 0),
            child: Text(
              'My View',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        )
      ]),
    );
  }
}
