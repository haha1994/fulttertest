import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FormTestRoute extends StatefulWidget {
  const FormTestRoute({super.key});

  @override
  FormTestRouteState createState() => FormTestRouteState();
}

class FormTestRouteState extends State<FormTestRoute> {
  final Logger logger = Logger();
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey, //设置globalKey，用于后面获取FormState
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      controller: _unameController,
                      decoration: const InputDecoration(
                        labelText: "用户名",
                        hintText: "用户名或邮箱",
                        icon: Icon(Icons.person),
                      ),
                      // 校验用户名
                      validator: (v) {
                        return v!.trim().isNotEmpty ? null : "用户名不能为空";
                      },
                    ),
                    TextFormField(
                      controller: _pwdController,
                      decoration: const InputDecoration(
                        labelText: "密码",
                        hintText: "您的登录密码",
                        icon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      //校验密码
                      validator: (v) {
                        return v!.trim().length > 5 ? null : "密码不能少于6位";
                      },
                    ),
                    // 登录按钮
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            // 通过Builder来获取ElevatedButton所在widget树的真正context(Element)
                              child: Builder(builder: (context) {
                                return ElevatedButton(
                                  //padding: const EdgeInsets.all(16.0),
                                  child: const Text("登录"),
                                  onPressed: () {
                                    //由于本widget也是Form的子代widget，所以可以通过下面方式获取FormState
                                    if (Form.of(context).validate()) {
                                      //验证通过提交数据
                                      logger.i(_unameController.text);
                                      logger.i(_pwdController.text);
                                    }
                                  },
                                );
                              })
                          ),
                          Expanded(
                            child: ElevatedButton(
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text("登录"),
                              ),
                              onPressed: () {
                                // 通过_formKey.currentState 获取FormState后，
                                // 调用validate()方法校验用户名密码是否合法，校验
                                // 通过后再提交数据。
                                if ((_formKey.currentState as FormState).validate()) {
                                  //验证通过提交数据
                                  logger.i(_unameController.text);
                                  logger.i(_pwdController.text);
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
      ),
    );
  }
}
