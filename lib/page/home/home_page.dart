import 'package:flutter/material.dart';
import 'package:helloworld/component/constant/app_router.dart';

import 'package:helloworld/util/restart_util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/base_page.dart';

class HomePage extends HookConsumerWidget {
  static const String name = 'Home';
  static const String path = '/home';

  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 72,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.0,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.blue[(index * 100) % 900],
                child: const Icon(Icons.all_inclusive),
              );
            },
          ),
        ),
        SizedBox(
            height: 72,
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, //横轴三个子widget
                    childAspectRatio: 1.0 //宽高比为1时，子widget
                    ),
                children: <Widget>[
                  GestureDetector(
                    child: const Icon(Icons.ac_unit),
                    onTap: () {
                      //导航到新路由
                      // Navigator.pushNamed(context, "szdata");
                      appRouter.push("/szdata");
                    },
                  ),
                  GestureDetector(
                    child: const Icon(Icons.airport_shuttle),
                    onTap: () {
                      //导航到新路由
                      // Navigator.pushNamed(context, "home");
                      appRouter.push("/home");
                    },
                  ),
                  const Icon(Icons.all_inclusive),
                  const Icon(Icons.beach_access),
                  GestureDetector(
                    child: const Icon(Icons.cake),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String tmp = "test";
                            return AlertDialog(
                              title: const Text('提示'),
                              content: Text(tmp),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('稍后我自己重启'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('现在重启'),
                                  onPressed: () {
                                    RestartUtil.restartApp(context);
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    },
                  )
                ])),
        TextButton(
          child: const Text("go to login"),
          onPressed: () {
            //导航到新路由
            // Navigator.pushNamed(context, "login");
            appRouter.push("/login");
          },
        ),
        TextButton(
          child: const Text("go to search"),
          onPressed: () {
            //导航到新路由
            // Navigator.pushNamed(context, "search");
            appRouter.push("/search");
          },
        ),
        TextButton(
          child: const Text("深圳二手房成交数据"),
          onPressed: () {
            //导航到新路由
            // Navigator.pushNamed(context, "szdata");
            appRouter.push("/szdata");
          },
        ),
        TextButton(
          child: const Text("view"),
          onPressed: () {
            //导航到新路由
            // Navigator.pushNamed(context, "szDataView");
            appRouter.push("/szDataView");
          },
        ),
      ],
    );

    return BasePage(title: name, children: [
      SliverList(delegate: SliverChildListDelegate([content])),
    ]);
  }
}
