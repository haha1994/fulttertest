import 'package:flutter/material.dart';

class RestartUtil extends StatefulWidget {
  final Widget child;


  const RestartUtil(this.child, {super.key});

  static restartApp(BuildContext context) {
    final _RestartUtilState? state = context.findAncestorStateOfType<_RestartUtilState>();
    state?.restartApp();
  }

  @override
  State<StatefulWidget> createState() => _RestartUtilState();
}

class _RestartUtilState extends State<RestartUtil> {
  Key key = UniqueKey();

  void restartApp () {
    setState(() {
      key = UniqueKey();//重新生成key导致控件重新build
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(key: key, child: widget.child,);
  }
}