import 'package:flutter/material.dart';
import 'package:flutter_demo/page/canvas/painting.dart';
import 'package:flutter_demo/page/canvas/test.dart';

class BasicComponents extends StatefulWidget {
  const BasicComponents({Key? key}) : super(key: key);
  static String routeName = '/basic_compoents';

  @override
  _BasicComponentsState createState() => _BasicComponentsState();
}

class _BasicComponentsState extends State<BasicComponents> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        ListTile(title: Text('canvas'), onTap: () => _onTap(CanvasTest())),
        ListTile(
            title: Text('CanvasPainting'),
            onTap: () => _onTap(CanvasPainting())),
      ],
    ));
  }

  _onTap(Widget canvasTest) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return canvasTest;
    }));
  }
}
