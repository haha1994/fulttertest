import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:helloworld/component/adaptive/adaptive_select_tile.dart';
import 'package:helloworld/module/setting/section_card_with_heading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../component/constant/system_icons.dart';
import '../../main.dart';
import 'color_scheme_picker_dialog.dart';

class SettingsAppearanceSection extends HookConsumerWidget {
  final bool isGettingStarted;

  const SettingsAppearanceSection({
    super.key,
    this.isGettingStarted = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    // 直接使用 ref 来监听和读取状态
    final themeMode = ref.watch(themeModeProvider);

    final pickColorScheme = useCallback(() {
      return () => showDialog(
          context: context,
          builder: (context) {
            return const ColorSchemePickerDialog();
          });
    }, []);

    final children = [
      // AdaptiveSelectTile<LayoutMode>(
      //   secondary: const Icon(SpotubeIcons.dashboard),
      //   title: Text(context.l10n.layout_mode),
      //   subtitle: Text(context.l10n.override_layout_settings),
      //   value: preferences.layoutMode,
      //   onChanged: (value) {
      //     if (value != null) {
      //       preferencesNotifier.setLayoutMode(value);
      //     }
      //   },
      //   options: [
      //     DropdownMenuItem(
      //       value: LayoutMode.adaptive,
      //       child: Text(context.l10n.adaptive),
      //     ),
      //     DropdownMenuItem(
      //       value: LayoutMode.compact,
      //       child: Text(context.l10n.compact),
      //     ),
      //     DropdownMenuItem(
      //       value: LayoutMode.extended,
      //       child: Text(context.l10n.extended),
      //     ),
      //   ],
      // ),
      AdaptiveSelectTile<ThemeMode>(
        secondary: const Icon(SystemIcons.darkMode),
        title: Text("主题"),
        // title: Text(context.l10n.theme),
        value: themeMode,
        options: [
          DropdownMenuItem(
            value: ThemeMode.dark,
            // child: Text(context.l10n.dark),
            child: Text("深色"),
          ),
          DropdownMenuItem(
            value: ThemeMode.light,
            // child: Text(context.l10n.light),
            child: Text("浅色"),
          ),
          DropdownMenuItem(
            value: ThemeMode.system,
            // child: Text(context.l10n.system),
            child: Text("系统"),
          ),
        ],
        onChanged: (value) {
          if (value != null) {
            ref.read(themeModeProvider.notifier).state = value;
          }
        },
      ),
      ListTile(
        leading: const Icon(SystemIcons.palette),
        title: Text("主题颜色"),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        trailing: ColorTile.compact(
          color: Colors.red,
          onPressed: pickColorScheme(),
          isActive: true,
        ),
        onTap: pickColorScheme(),
      ),
    ];

    if (isGettingStarted) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final child in children) ...[
            child,
            const Gap(16),
          ],
        ],
      );
    }

    return SectionCardWithHeading(
      heading: "外观",
      children: children,
    );
  }
}
