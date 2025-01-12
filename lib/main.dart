import 'package:flutter/material.dart' hide Page;
import 'package:helloworld/page/home/home.dart';
import 'package:helloworld/provider/user_preferences_provider.dart';
import 'package:helloworld/util/constant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'component/constant/app_router.dart';
import 'page/pages.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPreferences = ref.watch(userPreferencesProvider);
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Flutter Test',
      themeMode: userPreferences.themeMode,
      theme: ThemeData(
        colorSchemeSeed: userPreferences.accentColorScheme.color,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: userPreferences.accentColorScheme.color,
        brightness: Brightness.dark,
      ),
      routerConfig: appRouter,
      builder: (context, child) {
        child = ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: null
            // dragDevices: hasTouchSupport
            //     ? {
            //   PointerDeviceKind.touch,
            //   PointerDeviceKind.stylus,
            //   PointerDeviceKind.invertedStylus,
            // }
            //     : null,
          ),
          child: child!,
        );

        // if (kIsDesktop && !kIsMacOS) child = DragToResizeArea(child: child);

        return child;
      },
    );
  }
}

class _MyAppState extends State<MyApp> {
  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.teal;
  ColorImageProvider imageSelected = ColorImageProvider.leaves;
  ColorScheme? imageColorScheme = const ColorScheme.light();
  ColorSelectionMethod colorSelectionMethod = ColorSelectionMethod.colorSeed;

  bool get useLightMode => switch (themeMode) {
        ThemeMode.system =>
          View.of(context).platformDispatcher.platformBrightness ==
              Brightness.light,
        ThemeMode.light => true,
        ThemeMode.dark => false
      };

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelectionMethod = ColorSelectionMethod.colorSeed;
      colorSelected = ColorSeed.values[value];
    });
  }

  void handleImageSelect(int value) {
    final String url = ColorImageProvider.values[value].url;
    ColorScheme.fromImageProvider(provider: NetworkImage(url))
        .then((newScheme) {
      setState(() {
        colorSelectionMethod = ColorSelectionMethod.image;
        imageSelected = ColorImageProvider.values[value];
        imageColorScheme = newScheme;
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      themeMode: themeMode,
      theme: ThemeData(
        colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed
            ? colorSelected.color
            : null,
        colorScheme: colorSelectionMethod == ColorSelectionMethod.image
            ? imageColorScheme
            : null,
        useMaterial3: useMaterial3,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed
            ? colorSelected.color
            : imageColorScheme!.primary,
        useMaterial3: useMaterial3,
        brightness: Brightness.dark,
      ),
      home: const HomePage(
        title: "Home Page",
      ),
      routes: {
        "login": (context) => const LoginPage(),
        "search": (context) => const SearchPage(),
        "szdata": (context) => const InfiniteListView(),
        "home": (context) => Home(
            useLightMode: useLightMode,
            // useMaterial3: useMaterial3,
            colorSelected: colorSelected,
            handleBrightnessChange: handleBrightnessChange,
            handleColorSelect: handleColorSelect,
            handleImageSelect: handleImageSelect,
            colorSelectionMethod: colorSelectionMethod,
            imageSelected: imageSelected),
        "szDataView": (context) => const SzDataView(),
        //"/": (context) => const HomeView(title: 'Home Page'), //注册首页路由
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
