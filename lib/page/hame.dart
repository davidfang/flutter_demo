import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static String routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Container(
      height: 100,
      child: Column(
        children: [Text('首页'), CloseButton(onPressed: _closePressed)],
      ),
    )));
  }

  void _closePressed() {
    print('close pressed');
  }
}
