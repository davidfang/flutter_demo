import 'package:flutter/material.dart';
import 'package:flutter_demo/page/canvas/draw.dart';
import 'package:flutter_demo/page/canvas/graph.dart';
import 'package:flutter_demo/page/canvas/home_demo.dart';
import 'package:flutter_demo/page/canvas/line.dart';
import 'package:flutter_demo/page/canvas/painting.dart';
import 'package:flutter_demo/page/canvas/path.dart';
import 'package:flutter_demo/page/canvas/photo.dart';
import 'package:flutter_demo/page/canvas/photo3.dart';
import 'package:flutter_demo/page/canvas/signature.dart';
import 'package:flutter_demo/page/canvas/test.dart';
import 'package:flutter_demo/page/idraw/white_paper.dart';

import 'canvas/base.dart';
import 'canvas/base2.dart';
import 'canvas/image.dart';

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
        _listItem(
            title: 'canvas(二)图片处理',
            subtitle: '绘制阴影 绘制图片 绘制文字段落 裁剪矩形 裁剪圆角矩形',
            description:
                'drawShadow 绘制阴影 drawImage 绘制图片  drawImageNine 绘制九图 drawParagraph 绘制文字段落  clipRect 裁剪矩形 clipRRect 裁剪圆角矩形',
            routeWidget: CanvasPhoto()),
        _listItem(
            title: 'canvas基础 带封装',
            subtitle: '基本功能,封装值得参考',
            description: '可以看看封装,参考一下写法',
            routeWidget: CanvasLine(),
            url:
                'https://www.jianshu.com/p/0a618296fd63?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation'),
        _listItem(
            title: 'Canvas涂雅板',
            subtitle: '使用CustomPainter在Flutter中绘图',
            description: '使用CustomPainter在Flutter中绘图',
            routeWidget: CanvasDraw(),
            url: 'https://www.jianshu.com/p/8fc32ea0df07'),
        _listItem(
            title: 'Canvas Home Demo 雷达图',
            subtitle: 'Flutter 绘图部分详解  雷达图',
            description: 'Flutter 绘图部分详解  雷达图',
            routeWidget: CanvasHomeDemo(),
            url: 'https://www.jianshu.com/p/36fc171fde1e'),
        _listItem(
            title: 'Canvas Home Demo 绘图片',
            subtitle: 'Flutter 绘图部分详解 绘图片',
            description: 'Flutter 绘图部分详解 绘图片',
            routeWidget: CanvasHomeDrawDemo(),
            url: 'https://www.jianshu.com/p/36fc171fde1e'),
        _listItem(
            title: 'Canvas  图片 ',
            subtitle: 'Flutter 绘图部分详解 绘图片',
            description: 'Flutter 绘图部分详解 绘图片',
            routeWidget: CanvasImage(),
            url: 'https://blog.csdn.net/qq_34476727/article/details/107519603'),
        _listItem(
            title: '折线图和平滑折线图',
            subtitle: '用canvas画折线图和平滑折线图',
            description: '用canvas画折线图和平滑折线图',
            routeWidget: CanvasGraph(),
            url:
                'https://cloud.tencent.com/developer/inventory/7011/article/1760347'),
        _listItem(
            title: 'Canvas(3)',
            subtitle:
                'drawVertices 绘制顶点,画布操作：scale 缩放，translate 平移，rotate 旋转，skew 斜切，save/restore 保存/恢复',
            description:
                'drawVertices 绘制顶点,画布操作：scale 缩放，translate 平移，rotate 旋转，skew 斜切，save/restore 保存/恢复',
            routeWidget: CanvasPhoto3(),
            url: 'https://www.jianshu.com/p/548ee2e35a0f'),
        _listItem(
            title: 'Canvas path路径操作',
            subtitle: 'Canvas path路径操作',
            description: 'Canvas path路径操作',
            routeWidget: CanvasPath(),
            url:
                'https://juejin.cn/book/6844733827265331214/section/6844733827311468552'),
        _listItem(
            title: '集合画布',
            subtitle: '集合各种操作',
            description: '将各种操作都集合到一起',
            routeWidget: WhitePaper())
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
