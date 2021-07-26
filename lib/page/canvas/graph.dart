import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'coordinate_pro.dart';

///文档说明
///创建拆线图和平滑的拆线图
///https://cloud.tencent.com/developer/inventory/7011/article/1760347
///https://github.com/toly1994328/idraw/blob/master/lib/p14_bezier/s05_bezier_line/paper.dart

class CanvasGraph extends StatefulWidget {
  static String routName = '/CanvasGraph';

  @override
  _CanvasGraphState createState() => new _CanvasGraphState();
}

class _CanvasGraphState extends State<CanvasGraph> {
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
  void didUpdateWidget(CanvasGraph oldWidget) {
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
          title: new Text('折线图和平滑折线图'),
        ),
        body: Container(
          child: CustomPaint(
            size: MediaQuery.of(context).size,
            painter: GraphPainter(), // 背景
          ),
        ));
  }
}

class GraphPainter extends CustomPainter {
  final Coordinate coordinate = Coordinate();
  List<Offset> points1 = [
    Offset(0, 20),
    Offset(40, 40),
    Offset(80, -20),
    Offset(120, -40),
    Offset(160, -80),
    Offset(200, -20),
    Offset(240, -40),
  ];
  List<Offset> points2 = [
    Offset(0, 0),
    Offset(40, -20) ,
    Offset(80, -40),
    Offset(120, -80),
    Offset(160, -40),
    Offset(200, 20),
    Offset(240, 40),
  ];

  Paint _helpPaint = Paint();
  Paint _mainPaint = Paint();
  Path _linePath = Path();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    // 画布原点 移到 屏幕中心
    canvas.translate(size.width / 2, size.height / 2);
    
    // 绘制辅助点线
    _drawHelp(canvas);

    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    
    Path path = Path();
    addBezierPathWithPoints(path, points2);
    canvas.drawPath(path, paint);

    addBezierPathWithPoints(_linePath, points1);
    canvas.drawPath(_linePath, paint..color=Colors.orange);
  }

  void _drawHelp(Canvas canvas) {
    _helpPaint..style = PaintingStyle.stroke;
    // 绘制点
    points1.forEach((element) {
      canvas.drawCircle(
          element,
          2,
          _helpPaint
            ..strokeWidth = 1
            ..color = Colors.orange);
    });
    // 绘制折线
    canvas.drawPoints(
        PointMode.polygon,
        points1,
        _helpPaint
          ..strokeWidth = 0.5
          ..color = Colors.red);
  }

  void addBezierPathWithPoints(Path path, List points) {
    for (int i = 0; i < points.length - 1; i++) {
      Offset current = points[i];
      Offset next = points[i + 1];
      if (i == 0) {
        path.moveTo(current.dx, current.dy);
        // 控制点
        double ctrlX = current.dx + (next.dx - current.dx) / 2;
        double ctrlY = next.dy;
        path.quadraticBezierTo(ctrlX, ctrlY, next.dx, next.dy);
      } else if (i < points.length - 2) {
        // 控制点 1
        double ctrl1X = current.dx + (next.dx - current.dx) / 2;
        double ctrl1Y = current.dy;
        // 控制点 2
        double ctrl2X = ctrl1X;
        double ctrl2Y = next.dy;
        path.cubicTo(ctrl1X, ctrl1Y, ctrl2X, ctrl2Y, next.dx, next.dy);
      } else {
        path.moveTo(current.dx, current.dy);
        // 控制点
        double ctrlX = current.dx + (next.dx - current.dx) / 2;
        double ctrlY = current.dy;
        path.quadraticBezierTo(ctrlX, ctrlY, next.dx, next.dy);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
