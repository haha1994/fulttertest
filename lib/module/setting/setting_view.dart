import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'appearance.dart';

const double narrowScreenWidthThreshold = 400;

class SettingView extends HookConsumerWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    void openDialog(BuildContext context) {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('What is a dialog?'),
          content: const Text(
              'A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Restart'),
              onPressed: () {
                // TODO
                //RestartWidget.restartApp();
                Navigator.of(context).pop();
              },
            ),
            FilledButton(
              child: const Text('Okay'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }

    final controller = useScrollController();

    return SafeArea(
        bottom: false,
        child: Scaffold(
          // appBar: PageWindowTitleBar(
          //   title: Text(context.l10n.settings),
          //   centerTitle: true,
          //   automaticallyImplyLeading: true,
          // ),
          body: Scrollbar(
            controller: controller,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1920),
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(scrollbars: false),
                  child: ListView(
                    controller: controller,
                    children: [
                      // const SettingsAccountSection(),
                      // const SettingsLanguageRegionSection(),
                      const SettingsAppearanceSection(),
                      // const SettingsPlaybackSection(),
                      // const SettingsDownloadsSection(),
                      // if (kIsDesktop) const SettingsDesktopSection(),
                      // if (!kIsWeb) const SettingsDevelopersSection(),
                      // const SettingsAboutSection(),
                      Center(
                        child: FilledButton(
                          // onPressed: preferencesNotifier.reset,
                          // child: Text("context.l10n.restore_defaults"),
                          onPressed: () {  },
                          child: const Text("恢复默认值"),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}

class ColorGroup extends StatelessWidget {
  const ColorGroup({super.key, required this.children});

  final List<ColorChip> children;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class ColorChip extends StatelessWidget {
  const ColorChip({
    super.key,
    required this.color,
    required this.label,
    this.onColor,
  });

  final Color color;
  final Color? onColor;
  final String label;

  static Color contrastColor(Color color) =>
      switch (ThemeData.estimateBrightnessForColor(color)) {
        Brightness.dark => Colors.white,
        Brightness.light => Colors.black
      };

  @override
  Widget build(BuildContext context) {
    final Color labelColor = onColor ?? contrastColor(color);

    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(child: Text(label, style: TextStyle(color: labelColor))),
          ],
        ),
      ),
    );
  }
}
