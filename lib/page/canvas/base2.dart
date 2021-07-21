import 'dart:math';

import 'package:flutter/material.dart';

///文档说明
///Canas base2 https://www.jianshu.com/p/fcdf0bc553ee

class CanvasBase2 extends StatefulWidget {
  static String routName = '/CanasBase2';

  @override
  _CanvasBase2State createState() => new _CanvasBase2State();
}

class _CanvasBase2State extends State<CanvasBase2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(CanvasBase2 oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Canas Base 2'),
        ),
        body: Container(
            child: CustomPaint(painter: BasePainter2(), size: Size.infinite)));
  }
}

class BasePainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.pinkAccent, BlendMode.srcIn); //drawColor 绘制背景色
    // drawPath 绘制路径
    // drawPath 用来绘制路径，Flutter 提供了众多路径方法，小菜尝试几种常用的方法：
    // moveTo() 即从当前坐标点开始，不设置时默认为屏幕左上角位置；
    // lineTo() 即从起点绘制到设置的新的点位；
    // close() 即最后的点到起始点连接，但对于中间绘制矩形/弧等时最后不会相连；
    // reset() 即清空连线；
    // addRect() 添加矩形连线；
    // addOval() 添加弧线，即贝塞尔(二阶)曲线；
    // cubicTo() 添加弧线，即贝塞尔(三阶)曲线；
    // relativeMoveTo() 相对于移动到当前点位，小菜认为与 moveTo 相比整个坐标系移动；
    // relativeLineTo() 相对连接到当前点位，并将坐标系移动到当前点位；

    canvas.drawPath(
        Path()
          ..moveTo(10.0, 10.0)
          ..lineTo(120.0, 10.0)
          ..lineTo(10.0, 30.0)
          ..lineTo(140.0, 30.0),
        // ..close(),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke);
    canvas.drawPath(
        Path()
          ..moveTo(150.0, 10.0)
          ..lineTo(250.0, 10.0)
          ..lineTo(160.0, 30.0)
          ..lineTo(250.0, 30.0)
          ..close(),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3.0
          ..style = PaintingStyle.fill);
    canvas.drawPath(
        Path()
          ..moveTo(260.0, 10.0)
          ..lineTo(360.0, 10.0)
          ..lineTo(260.0, 30.0)
          ..lineTo(360.0, 30.0)
          ..addRect(Rect.fromLTWH(10.0, 40.0, 100.0, 70.0))
          ..addOval(Rect.fromLTWH(10.0, 40.0, 100.0, 70.0))
          ..moveTo(130.0, 40.0)
          ..lineTo(220.0, 100.0)
          ..close(),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke);
    canvas.drawPath(
        Path()
          ..arcTo(Rect.fromCircle(center: Offset(225, 60), radius: 40), -pi / 6,
              pi * 2 / 3, false),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke);
    canvas.drawPath(
        Path()
          ..moveTo(270.0, 40.0)
          ..cubicTo(310.0, 190.0, 330.0, 100.0, 360.0, 40.0),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke);

    canvas.drawPath(
        Path()
          ..relativeMoveTo(10.0, 130.0)
          ..relativeLineTo(100.0, 30.0)
          ..relativeLineTo(90.0, 60.0)
          ..relativeLineTo(180.0, 60.0),
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke);
    canvas.drawPath(
        Path()
          ..moveTo(10.0, 130.0)
          ..lineTo(100.0, 30.0)
          ..lineTo(90.0, 60.0)
          ..lineTo(180.0, 60.0),
        Paint()
          ..color = Colors.orange
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke);

    //绘制四个不同颜色的矩形
    canvas.drawRect(
        Rect.fromLTWH(50, 300, 150, 300), Paint()..color = Colors.green);
    canvas.drawRect(
        Rect.fromLTWH(150, 310, 150, 300), Paint()..color = Colors.yellow);
    canvas.drawRect(
        Rect.fromLTWH(200, 320, 150, 300), Paint()..color = Colors.indigo);
    // maskFilter -> 模糊遮照效果
    // 模糊效果包括：
    // nomal 内外模糊；
    // solid 内部填充外边模糊，类似于荧光灯效果；
    // outer 内部透明外边模糊；
    // inner 内部模糊，外边正常；
    // 建议大家多尝试效果；

    canvas.drawLine(
        Offset(30.0, 330.0),
        Offset(430.0, 330.0),
        Paint()
          ..strokeWidth = 8.0
          ..strokeCap = StrokeCap.round
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3.0));
    canvas.drawLine(
        Offset(30.0, 350.0),
        Offset(430.0, 350.0),
        Paint()
          ..strokeWidth = 8.0
          ..strokeCap = StrokeCap.round
          ..maskFilter = MaskFilter.blur(BlurStyle.outer, 3.0));
    canvas.drawLine(
        Offset(30.0, 370.0),
        Offset(430.0, 370.0),
        Paint()
          ..strokeWidth = 8.0
          ..strokeCap = StrokeCap.round
          ..maskFilter = MaskFilter.blur(BlurStyle.solid, 3.0));
    canvas.drawLine(
        Offset(30.0, 390.0),
        Offset(430.0, 390.0),
        Paint()
          ..strokeWidth = 8.0
          ..strokeCap = StrokeCap.round
          ..maskFilter = MaskFilter.blur(BlurStyle.inner, 3.0));

// blendMode -> 颜色混合模式，类型很多
// colorFilter -> 颜色渲染模式，一般是矩阵效果来改变
//颜色混合与颜色渲染是两个很神奇的属性，可以通过众多模式调整颜色叠加效果，并与背景色衔接，小菜还无法准确的说明其中叠加的原理；
    canvas.drawLine(
        Offset(30.0, 400.0),
        Offset(430.0, 400.0),
        Paint()
          ..strokeWidth = 8.0
          // ..blendMode = BlendMode.exclusion
          ..colorFilter = ColorFilter.mode(Colors.white, BlendMode.exclusion));
    canvas.drawLine(
        Offset(30.0, 430.0),
        Offset(430.0, 430.0),
        Paint()
          ..strokeWidth = 8.0
          // ..blendMode = BlendMode.exclusion
          ..colorFilter = ColorFilter.mode(Colors.yellow, BlendMode.exclusion));
    canvas.drawLine(
        Offset(30.0, 460.0),
        Offset(430.0, 460.0),
        Paint()
          ..strokeWidth = 8.0
          // ..blendMode = BlendMode.exclusion
          ..colorFilter = ColorFilter.mode(Colors.red, BlendMode.hardLight));
    canvas.drawLine(
        Offset(30.0, 490.0),
        Offset(430.0, 490.0),
        Paint()
          ..strokeWidth = 8.0
          //..blendMode = BlendMode.colorBurn
          // ..blendMode = BlendMode.exclusion
          ..colorFilter = ColorFilter.mode(Colors.green, BlendMode.difference));
  }

  @override
  bool shouldRepaint(BasePainter2 oldDelegate) => true;
}
