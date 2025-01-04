import 'package:flutter/material.dart';

import 'package:helloworld/util/restart_util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../component/constant/route.dart';
import '../szdata/szdata.dart';

class HomePage extends HookConsumerWidget {
  static const String name = 'home';
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Column(
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
                        router.push("/szdata");
                      },
                    ),
                    GestureDetector(
                      child: const Icon(Icons.airport_shuttle),
                      onTap: () {
                        //导航到新路由
                        // Navigator.pushNamed(context, "home");
                        router.push("/home");
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
              router.push("/login");
            },
          ),
          TextButton(
            child: const Text("go to search"),
            onPressed: () {
              //导航到新路由
              // Navigator.pushNamed(context, "search");
              router.push("/search");
            },
          ),
          TextButton(
            child: const Text("open new route"),
            onPressed: () {
              //导航到新路由
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const NewRoute(text: "test");
                }),
              );
            },
          ),
          TextButton(
            child: const Text("深圳二手房成交数据"),
            onPressed: () {
              // Page page = Page("深圳二手房成交数据", const InfiniteListView());
              // page.openPage(context);
              //导航到新路由
              // Navigator.pushNamed(context, "szdata");
              router.push("/szdata");
            },
          ),
          TextButton(
            child: const Text("view"),
            onPressed: () {
              // Page page = Page("深圳二手房成交数据", const InfiniteListView());
              // page.openPage(context);
              //导航到新路由
              // Navigator.pushNamed(context, "szDataView");
              router.push("/szDataView");
            },
          ),
          // const Text(
          //   'You have pushed the button this many times:',
          // ),
          // Text(
          //   '$_counter',
          //   style: Theme.of(context).textTheme.headlineMedium,
          // ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _HomeViewState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
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
                        Navigator.pushNamed(context, "szdata");
                      },
                    ),
                    GestureDetector(
                      child: const Icon(Icons.airport_shuttle),
                      onTap: () {
                        //导航到新路由
                        Navigator.pushNamed(context, "home");
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
              Navigator.pushNamed(context, "login");
            },
          ),
          TextButton(
            child: const Text("go to search"),
            onPressed: () {
              //导航到新路由
              Navigator.pushNamed(context, "search");
            },
          ),
          TextButton(
            child: const Text("open new route"),
            onPressed: () {
              //导航到新路由
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const NewRoute(text: "test");
                }),
              );
            },
          ),
          TextButton(
            child: const Text("深圳二手房成交数据"),
            onPressed: () {
              // Page page = Page("深圳二手房成交数据", const InfiniteListView());
              // page.openPage(context);
              //导航到新路由
              Navigator.pushNamed(context, "szdata");
            },
          ),
          TextButton(
            child: const Text("view"),
            onPressed: () {
              // Page page = Page("深圳二手房成交数据", const InfiniteListView());
              // page.openPage(context);
              //导航到新路由
              Navigator.pushNamed(context, "szDataView");
            },
          ),
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewRoute extends StatelessWidget {
  const NewRoute({
    super.key,
    required this.text, // 接收一个text参数
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New route"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              const TextField(
                textInputAction: TextInputAction.search,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "用户名或邮箱",
                    prefixIcon: Icon(Icons.person)),
              ),
              const TextField(
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "您的登录密码",
                    prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              Text(text),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: const Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
