import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:helloworld/extension/context.dart';
import 'package:helloworld/page/common/base_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

class SearchPage extends HookConsumerWidget {
  static const String name = 'Search';
  static const String path = '/search';

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Logger logger = Logger();
    final TextEditingController searchController = TextEditingController();
    final GlobalKey formKey = GlobalKey<FormState>();

    Widget content = Padding(
      padding: const EdgeInsets.all(18),
      child: Center(
        child: Column(
          children: <Widget>[
            Form(
              key: formKey, //设置globalKey，用于后面获取FormState
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    // fixme
                    // autofocus: true,
                    controller: searchController,
                    decoration: InputDecoration(
                      // labelText: "搜索",
                      hintText: context.l10n.search,
                    ),
                    // 校验
                    validator: (v) {
                      return v!.trim().isNotEmpty ? null : "搜索条件不能为空";
                    },
                  ),
                  // 搜索按钮
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            // 通过Builder来获取ElevatedButton所在widget树的真正context(Element)
                            child: Builder(builder: (context) {
                          return ElevatedButton(
                            // padding: const EdgeInsets.all(16.0),
                            child: Text(context.l10n.search),
                            onPressed: () async {
                              //由于本widget也是Form的子代widget，所以可以通过下面方式获取FormState
                              if (Form.of(context).validate()) {
                                //验证通过提交数据
                                // logger.i(_searchController.text);
                                Dio dio = Dio();
                                Response response;
                                String searchText = searchController.text;

                                try {
                                  response = await dio.get(
                                      // 'https://api.github.com/orgs/flutterchina/repos'
                                      'https://baidu.com');
                                } on Exception catch (e) {
                                  logger.e(e);
                                  return;
                                }

                                // logger.i(response.data);
                                // List githubList = json.decode(response.data.toString());
                                final SnackBar snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  width: 350.0,
                                  content: Text(response.data
                                      .toString()
                                      .substring(0, 50)),
                                  action: SnackBarAction(
                                    label: 'close',
                                    onPressed: () {},
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                          );
                        })),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

    return BasePage(title: context.l10n.search, children: [
      SliverList(delegate: SliverChildListDelegate([content])),
    ]);
  }
}
