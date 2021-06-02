import 'package:flutter/material.dart';

class ExpansionComponents extends StatefulWidget {
  const ExpansionComponents({Key? key}) : super(key: key);
  static String routeName = '/expansion_components';

  @override
  _ExpansionComponentsState createState() => _ExpansionComponentsState();
}

class _ExpansionComponentsState extends State<ExpansionComponents> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('扩展组件')));
  }
}
