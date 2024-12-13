import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:helloworld/util/constant.dart';

final userPreferencesProvider =
    StateNotifierProvider<UserPreferencesNotifier, UserPreferences>(
        (ref) => UserPreferencesNotifier());

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier() : super(UserPreferences.defaults());

  void setThemeMode(ThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
  }

  void setAccentColorScheme(ColorSeed accentColorScheme) {
    state = state.copyWith(accentColorScheme: accentColorScheme);
  }

  void setLocale(Locale locale) {
    state = state.copyWith(locale: locale);
  }

  void setDownloadLocation(String downloadLocation) {
    state = state.copyWith(downloadLocation: downloadLocation);
  }

  void setCheckUpdate(bool checkUpdate) {
    state = state.copyWith(checkUpdate: checkUpdate);
  }
}

class UserPreferences {
  int id;
  ThemeMode themeMode;
  ColorSeed accentColorScheme;
  Locale locale;
  String downloadLocation;
  bool checkUpdate;

  UserPreferences({
    required this.id,
    required this.themeMode,
    required this.accentColorScheme,
    required this.locale,
    required this.downloadLocation,
    required this.checkUpdate,
  });

  UserPreferences copyWith({
    int? id,
    ThemeMode? themeMode,
    ColorSeed? accentColorScheme,
    Locale? locale,
    String? downloadLocation,
    bool? checkUpdate,
  }) {
    return UserPreferences(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      accentColorScheme: accentColorScheme ?? this.accentColorScheme,
      locale: locale ?? this.locale,
      downloadLocation: downloadLocation ?? this.downloadLocation,
      checkUpdate: checkUpdate ?? this.checkUpdate,
    );
  }

  static UserPreferences defaults() {
    return UserPreferences(
      id: 0,
      themeMode: ThemeMode.system,
      accentColorScheme: ColorSeed.baseColor,
      locale: const Locale('en', 'US'),
      downloadLocation: '/storage/emulated/0/Download',
      checkUpdate: true,
    );
  }
}
