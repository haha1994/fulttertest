import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:helloworld/util/constant.dart';
import 'package:helloworld/provider/user_preferences_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ColorSchemePickerDialog extends HookConsumerWidget {
  const ColorSchemePickerDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final preferences = ref.watch(userPreferencesProvider);
    final preferencesNotifier = ref.watch(userPreferencesProvider.notifier);
    final scheme = preferences.accentColorScheme;
    final active = useState<String>(ColorSeed.values.firstWhere(
      (element) {
        return scheme.name == element.name;
      },
    ).name);

    onOk() {
      preferencesNotifier.setAccentColorScheme(
        ColorSeed.values.firstWhere(
          (element) => element.name == active.value,
        ),
      );
      Navigator.pop(context);
    }

    return AlertDialog(
      title: const Text("选择主题颜色"),
      actions: [
        OutlinedButton(
          child: const Text("取消"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FilledButton(
          onPressed: onOk,
          child: const Text("保存"),
        ),
      ],
      content: SizedBox(
        height: 300,
        width: 400,
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: ColorSeed.values.length,
          itemBuilder: (context, index) {
            final colorSeed = ColorSeed.values[index];
            return ColorTile(
              color: colorSeed.color,
              isActive: active.value == colorSeed.name,
              onPressed: () {
                active.value = colorSeed.name;
              },
              tooltip: colorSeed.label,
            );
          },
        ),
      ),
    );
  }
}

class ColorTile extends StatelessWidget {
  final Color color;
  final bool isActive;
  final void Function()? onPressed;
  final String? tooltip;
  final bool isCompact;

  const ColorTile({
    required this.color,
    this.isActive = false,
    this.onPressed,
    this.tooltip = "",
    this.isCompact = false,
    super.key,
  });

  factory ColorTile.compact({
    required Color color,
    bool isActive = false,
    void Function()? onPressed,
    String? tooltip = "",
    Key? key,
  }) {
    return ColorTile(
      color: color,
      isActive: isActive,
      onPressed: onPressed,
      tooltip: tooltip,
      isCompact: true,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final lead = Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: isActive
            ? Border.fromBorderSide(
                BorderSide(
                  color: Color.lerp(
                    theme.colorScheme.primary,
                    theme.colorScheme.onPrimary,
                    0.5,
                  )!,
                  width: 4,
                ),
              )
            : null,
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
    );

    if (isCompact) {
      return GestureDetector(
        onTap: onPressed,
        child: lead,
      );
    }

    final colorScheme = ColorScheme.fromSeed(seedColor: color);

    final palette = [
      colorScheme.primary,
      colorScheme.inversePrimary,
      colorScheme.primaryContainer,
      colorScheme.secondary,
      colorScheme.secondaryContainer,
      colorScheme.surface,
      colorScheme.surface,
      colorScheme.surfaceContainerHighest,
      colorScheme.onPrimary,
      colorScheme.onSurface,
    ];

    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              lead,
              const SizedBox(width: 10),
              Text(
                tooltip!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: [
              ...palette.map(
                (e) => Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: e,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
