import 'dart:ui';

import 'package:flutter/material.dart';

import 'coordinate_pro.dart';

///文档说明
///Canvas (三)
///https://www.jianshu.com/p/548ee2e35a0f
///drawVertices 绘制顶点
///画布操作：scale 缩放，translate 平移，rotate 旋转，skew 斜切，save/restore 保存/恢复

class CanvasPhoto3 extends StatefulWidget {
  static String routName = '/CanvasPhoto3';

  @override
  _CanvasPhoto3State createState() => new _CanvasPhoto3State();
}

class _CanvasPhoto3State extends State<CanvasPhoto3> {
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
  void didUpdateWidget(CanvasPhoto3 oldWidget) {
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
          title: new Text('Canvas (三)'),
        ),
        body: Container(
          child: CustomPaint(
              painter: Photo3Painter(), size: MediaQuery.of(context).size),
        ));
  }
}

class Photo3Painter extends CustomPainter {
  final Coordinate coordinate = Coordinate();
  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(-200, -400);
    // drawVertices 绘制顶点
    Paint _paint = Paint()..color = Colors.red;
    canvas.drawVertices(
        Vertices(VertexMode.triangles, [
          Offset(30, 30),
          Offset(30, 60),
          Offset(60, 60),
          Offset(90, 60),
          Offset(120, 60),
          Offset(120, 30),
          Offset(60, 90),
          Offset(60, 120),
          Offset(90, 120),
        ]),
        BlendMode.colorBurn,
        _paint);

    canvas.drawVertices(
        Vertices(VertexMode.triangleStrip, [
          Offset(210, 30),
          Offset(210, 60),
          Offset(240, 60),
          Offset(270, 60),
          Offset(300, 60),
          Offset(300, 30),
          Offset(240, 90),
          Offset(240, 120),
          Offset(270, 120),
        ]),
        BlendMode.colorBurn,
        Paint()..color = Colors.green);

    canvas.drawVertices(
        Vertices(VertexMode.triangleFan, [
          Offset(120, 150),
          Offset(120, 180),
          Offset(150, 180),
          Offset(180, 180),
          Offset(210, 180),
          Offset(210, 150),
          Offset(150, 210),
          Offset(150, 240),
          Offset(180, 240),
        ]),
        BlendMode.colorBurn,
        Paint()..color = Colors.blue);

    canvas.drawRect(
        Rect.fromLTWH(60, 60, 90, 50),
        Paint()
          ..color = Colors.red
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke);

    canvas.scale(2);
    canvas.drawRect(
        Rect.fromLTWH(60, 60, 90, 50),
        Paint()
          ..color = Colors.red
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke);
    //translate 平移
    canvas.scale(0.5);
    canvas.drawLine(
        Offset(0, 0),
        Offset(50, 50),
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 2);
    canvas.drawRect(
        Rect.fromLTWH(50, 50, 90, 150),
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke);
    // 平移
    canvas.translate(100, 350);

    canvas.drawLine(
        Offset(0, 0),
        Offset(0, 600),
        Paint()
          ..color = Colors.blueGrey
          ..strokeWidth = 2);
    canvas.drawLine(
        Offset(0, 0),
        Offset(400, 0),
        Paint()
          ..color = Colors.blueGrey
          ..strokeWidth = 2);
    canvas.drawLine(
        Offset(0, 0),
        Offset(50, 50),
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 2);
    canvas.drawRect(
        Rect.fromLTWH(50, 50, 90, 50),
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke);

    // 以当前原点旋转 90 度
    canvas.rotate(-90);
    canvas.drawLine(
        Offset(0, 0),
        Offset(50, 50),
        Paint()
          ..color = Colors.blue.shade200
          ..strokeWidth = 2);
    canvas.drawRect(
        Rect.fromLTWH(50, 50, 90, 50),
        Paint()
          ..color = Colors.blue.shade200
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke);
    canvas.rotate(90); //回归原位
    // 水平方向斜近 30 度，竖直方向不变
    canvas.skew(0.6, 0);
    canvas.drawRect(
        Rect.fromLTWH(50, 50, 90, 50),
        Paint()
          ..color = Colors.red
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke);

    //为文字设置画笔样式
    Paint textPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: 'Flutter Demo Powered by Google星空',
            style: TextStyle(foreground: textPaint, fontSize: 40)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: 280); // 进行布局
    Size textPainterSize = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(canvas,
        Offset(-textPainterSize.width / 2 + 100, -textPainterSize.height / 2));

    canvas.drawArc(
        Rect.fromLTWH(
            -textPainterSize.width / 2 + 100,
            -textPainterSize.height / 2,
            textPainterSize.width,
            textPainterSize.height),
        90,
        250,
        true,
        Paint()..color = Colors.blue.withAlpha(33));
  }

  @override
  shouldRepaint(Photo3Painter oldDelegate) => true;
}
