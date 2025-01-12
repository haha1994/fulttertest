import 'package:flutter/material.dart';
import 'package:helloworld/page/szdata/dto/second_hand_deal.dart';

//import 'package:english_words/english_words.dart';
import 'package:helloworld/page/szdata/szdata_api.dart';
import 'package:logger/logger.dart';

class InfiniteListView extends StatefulWidget {
  static const String name = "szdata";
  static const String path = "/szdata";
  const InfiniteListView({super.key});

  @override
  State<InfiniteListView> createState() => InfiniteListViewState();
}

class InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##"; //表尾标记
  final words = <String>[loadingTag];
  var szApi = SzdataApi();
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    //_retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("深圳二手房交易数据"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(18),
            child: ListView.builder(
              itemCount: words.length,
              itemBuilder: (context, index) {
                //如果到了表尾
                if (words[index] == loadingTag) {
                  //不足100条，继续获取数据
                  if (words.length - 1 < 200) {
                    //获取数据
                    _retrieveData();
                    //加载时显示loading
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: const SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    );
                  } else {
                    //已经加载了100条数据，不再获取数据。
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      child: const Text(
                        "没有更多了",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                }
                //显示单词列表项
                return ListTile(title: Text(words[index]));
              },
              //separatorBuilder: (context, index) => const Divider(height: .0),
            )));
    // return ListView.separated(
    //   itemCount: _words.length,
    //   itemBuilder: (context, index) {
    //     //如果到了表尾
    //     if (_words[index] == loadingTag) {
    //       //不足100条，继续获取数据
    //       if (_words.length - 1 < 100) {
    //         //获取数据
    //         _retrieveData();
    //         //加载时显示loading
    //         return Container(
    //           padding: const EdgeInsets.all(16.0),
    //           alignment: Alignment.center,
    //           child: const SizedBox(
    //             width: 24.0,
    //             height: 24.0,
    //             child: CircularProgressIndicator(strokeWidth: 2.0),
    //           ),
    //         );
    //       } else {
    //         //已经加载了100条数据，不再获取数据。
    //         return Container(
    //           alignment: Alignment.center,
    //           padding: const EdgeInsets.all(16.0),
    //           child: const Text(
    //             "没有更多了",
    //             style: TextStyle(color: Colors.grey),
    //           ),
    //         );
    //       }
    //     }
    //     //显示单词列表项
    //     return ListTile(title: Text(_words[index]));
    //   },
    //   separatorBuilder: (context, index) => const Divider(height: .0),
    // );
  }

  void _retrieveData() {
    int rows = 10;
    int page = 6800 + words.length ~/ rows;
    Map<String, dynamic> queryParameter = {'page': page, 'rows': rows};
    szApi.findSecondHandDeal(
        queryParameters: queryParameter,
        requestCallBack: (data) {
          setState(() {
            try {
              List<SecondHandDeal>? list = data.data;
              var zones = list
                  ?.map((data) => data.toDisplayString())
                  .toList()
                  .cast<String>();
              words.insertAll(words.length - 1, zones as Iterable<String>);
            } catch (e) {
              logger.e(e);
            }
          });
        });
    // Future.delayed(const Duration(seconds: 2)).then((e) {
    //   setState(() {
    //     //重新构建列表
    //     _words.insertAll(
    //       _words.length - 1,
    //       //每次生成20个单词
    //       generateWordPairs().take(20).map((e) => e.asPascalCase).toList(),
    //     );
    //   });
    // });
  }
}
