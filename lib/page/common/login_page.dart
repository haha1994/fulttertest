import 'package:flutter/material.dart';
import 'package:helloworld/extension/context.dart';
import 'package:helloworld/page/common/base_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../component/constant/app_router.dart';

class LoginPage extends HookConsumerWidget {
  static const String name = 'Login';
  static const String path = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Logger logger = Logger();
    final TextEditingController unameController = TextEditingController();
    final TextEditingController pwdController = TextEditingController();
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
                    autofocus: true,
                    controller: unameController,
                    decoration: InputDecoration(
                      labelText: context.l10n.username,
                      hintText: context.l10n.username_or_email,
                      icon: const Icon(Icons.person),
                    ),
                    // 校验用户名
                    validator: (v) {
                      return v!.trim().isNotEmpty
                          ? null
                          : context.l10n.username_can_not_be_empty;
                    },
                  ),
                  TextFormField(
                    controller: pwdController,
                    decoration: InputDecoration(
                      labelText: context.l10n.password,
                      hintText: context.l10n.your_password,
                      icon: const Icon(Icons.lock),
                    ),
                    obscureText: true,
                    //校验密码
                    validator: (v) {
                      return v!.trim().length > 5
                          ? null
                          : context.l10n.password_can_not_less_than_6;
                    },
                  ),
                  // 登录按钮
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(context.l10n.login),
                            ),
                            onPressed: () {
                              // 通过_formKey.currentState 获取FormState后，
                              // 调用validate()方法校验用户名密码是否合法，校验
                              // 通过后再提交数据。
                              if ((formKey.currentState as FormState)
                                  .validate()) {
                                //验证通过提交数据
                                logger.i(unameController.text);
                                logger.i(pwdController.text);
                                AppRouter.authenticatedNotifier.value = true;
                              }
                            },
                          ),
                        ),
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

    return BasePage(title: context.l10n.login, children: [
      SliverList(
          delegate: SliverChildListDelegate([
        content,
      ])),
    ]);
  }
}
