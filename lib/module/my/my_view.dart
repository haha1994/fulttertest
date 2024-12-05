import 'package:flutter/material.dart';

import '../setting/appearance.dart';

const Widget divider = SizedBox(height: 10);

const double narrowScreenWidthThreshold = 500;

class MyView extends StatelessWidget {
  const MyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < narrowScreenWidthThreshold) {
        return SingleChildScrollView(
          child: Column(
            children: [
              divider,
              const SettingsAppearanceSection(),
              divider,
              // schemeView(darkTheme),
            ],
          ),
        );
      } else {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SettingsAppearanceSection(),
                const SizedBox(height: 16),
                // const SettingsAppearanceSection(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }
    }));

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
