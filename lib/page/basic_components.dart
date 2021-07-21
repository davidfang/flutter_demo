import 'package:flutter/material.dart';
import 'package:flutter_demo/page/canvas/painting.dart';
import 'package:flutter_demo/page/canvas/signature.dart';
import 'package:flutter_demo/page/canvas/test.dart';

import 'canvas/base.dart';
import 'canvas/base2.dart';

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
            routeWidget: CanvasPainting(),
            url:
                'https://ptyagicodecamp.github.io/building-cross-platform-finger-painting-app-in-flutter.html'),
        _listItem(
            title: 'Canvas画板',
            subtitle: '简单的Canvas画板',
            description: '单纯的涂鸦板',
            routeWidget: Signature(),
            url: 'https://www.jianshu.com/p/647ad905e02c/'),
        _listItem(
            title: 'Canvas(一)基础上',
            subtitle: 'Canvas 基础',
            description:
                'drawColor 绘制背景色，drawPoints 绘制点/线，drawLine 绘制线，drawArc 绘制弧/饼，drawRect 绘制矩形，drawDRRect 绘制嵌套矩形，drawCircle 绘制圆形，drawOval 绘制椭圆，drawPath 绘制路径',
            routeWidget: CanvasBase(),
            url: 'https://www.jianshu.com/p/fcdf0bc553ee'),
        _listItem(
            title: 'Canvas(一)基础下',
            subtitle: 'Canvas 基础 续 drawPath 绘制路径',
            description: 'drawPath 绘制路径',
            routeWidget: CanvasBase2(),
            url: 'https://www.jianshu.com/p/fcdf0bc553ee'),
      ],
    ));
  }

  Widget _listItem(
      {required String title,
      required String subtitle,
      required String description,
      required Widget routeWidget,
      String? url}) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        icon: Icon(Icons.link),
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
