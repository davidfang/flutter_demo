import 'package:flutter/material.dart';

class BasicComponents extends StatefulWidget {
  const BasicComponents({Key? key}) : super(key: key);
  static String routeName = '/basic_compoents';

  @override
  _BasicComponentsState createState() => _BasicComponentsState();
}

class _BasicComponentsState extends State<BasicComponents> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('基础组件')));
  }
}
