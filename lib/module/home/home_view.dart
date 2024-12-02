import 'package:flutter/material.dart';

import 'package:helloworld/util/restart_util.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: 72,
                child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
