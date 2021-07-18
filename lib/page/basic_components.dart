import 'package:flutter/material.dart';
import 'package:flutter_demo/page/canvas/painting.dart';
import 'package:flutter_demo/page/canvas/signature.dart';
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
        _listItem(
            title: 'canvas',
            subtitle: '初始canvas',
            description: '简单的canvas Demo',
            routeWidget: CanvasTest()),
        _listItem(
            title: 'Canvas Painting',
            subtitle: 'Canvas画笔画板',
            description: '可以设置画笔颜色、粗细、透明度等',
            routeWidget: CanvasPainting()),
        _listItem(
            title: 'Canvas画板',
            subtitle: '简单的Canvas画板',
            description: '单纯的涂鸦板',
            routeWidget: Signature()),
      ],
    ));
  }

  Widget _listItem(
      {required String title,
      required String subtitle,
      required String description,
      required Widget routeWidget}) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          color: Colors.grey[200],
          child: ListTile(
              onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return routeWidget;
                  })),
              isThreeLine: true,
              title: Text(title, style: TextStyle(fontSize: 20)),
              subtitle: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        subtitle * 10,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        icon: Icon(Icons.slideshow),
                        onPressed: () => Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return routeWidget;
                            }))),
                    SizedBox(width: 2),
                    IconButton(
                        icon: Icon(Icons.code),
                        onPressed: () => Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return routeWidget;
                            })))
                  ])
                ],
              )),
        ),
        // Divider(
        //   color: Colors.blue,
        // )
      ],
    );
  }
}
