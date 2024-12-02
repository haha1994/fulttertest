import 'package:flutter/material.dart' hide Page;
import 'package:helloworld/module/home/home.dart';
import 'package:helloworld/module/home/home_view.dart';
import 'package:helloworld/module/szdata/szdata.dart';
import 'package:helloworld/module/szdata/szdata_view.dart';
import 'package:helloworld/util/constant.dart';
import './login.dart';
import './search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

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
      title: 'Flutter Demo',
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
      home: const HomeView(title: "Home Page",),
      routes: {
        "new_page": (context) => const NewRoute(text: "test"),
        "login": (context) => const FormTestRoute(),
        "search": (context) => const SearchRoute(),
        "szdata": (context) => const InfiniteListView(),
        "home": (context) => Home(useLightMode: useLightMode, useMaterial3: useMaterial3, colorSelected: colorSelected, handleBrightnessChange: handleBrightnessChange, handleColorSelect: handleColorSelect, handleImageSelect: handleImageSelect, colorSelectionMethod: colorSelectionMethod, imageSelected: imageSelected),
        "szDataView": (context) =>  const SzDataView(),
        //"/": (context) => const HomeView(title: 'Home Page'), //注册首页路由
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }


}
