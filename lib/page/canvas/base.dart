import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///文档说明
///canvas based  
///https://www.jianshu.com/p/fcdf0bc553ee

class CanvasBase extends StatefulWidget {
  static String routName = '/CanvasBase';

  @override
  _CanvasBaseState createState() => new _CanvasBaseState();
}

class _CanvasBaseState extends State<CanvasBase> {
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
  void didUpdateWidget(CanvasBase oldWidget) {
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
          title: new Text('Canvas Base'),
        ),
        body: Container(
          child: CustomPaint(painter: BasePainter(), size: Size.infinite),
        ));
  }
}

class BasePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.pinkAccent, BlendMode.srcIn); //drawColor 绘制背景色
    //drawPoints 绘制点/线
    canvas.drawPoints(
        PointMode.points,
        [
          Offset(30.0, 30.0),
          Offset(60.0, 30.0),
          Offset(90.0, 30.0),
          Offset(90.0, 60.0),
          Offset(60.0, 60.0),
          Offset(30.0, 60.0)
        ],
        Paint()..strokeWidth = 4.0);

    canvas.drawPoints(
        PointMode.points,
        [
          Offset(230, 30),
          Offset(260, 30),
          Offset(280, 30),
          Offset(310, 30),
          Offset(230, 60),
          Offset(260, 60),
          Offset(280, 60),
          Offset(310, 60),
        ],
        Paint()
          ..strokeWidth = 18.0
          ..strokeCap = StrokeCap.round
          ..color = Colors.yellow);
    // 绘制线
    canvas.drawPoints(
        PointMode.lines,
        [
          Offset(30.0, 100.0),
          Offset(60.0, 100.0),
          Offset(90.0, 100.0),
          Offset(90.0, 130.0),
          Offset(60.0, 130.0),
          Offset(30.0, 130.0)
        ],
        Paint()
          ..strokeWidth = 4.0
          ..strokeCap = StrokeCap.round);
    // 绘制多边形
    canvas.drawPoints(
        PointMode.polygon,
        [
          Offset(160.0, 100.0),
          Offset(190.0, 100.0),
          // Offset(220.0, 100.0),
          Offset(220.0, 130.0),
          // Offset(190.0, 130.0),
          Offset(160.0, 130.0),
          Offset(160.0, 100.0),
        ],
        Paint()
          ..strokeWidth = 14.0
          ..strokeCap = StrokeCap.round);

    //drawLine 绘制线
    canvas.drawLine(
        Offset(0, 150),
        Offset(640, 150),
        Paint()
          ..strokeWidth = 1
          ..color = Colors.white);

    //drawArc 绘制弧/饼
    //drawArc 可以用来绘制圆弧甚至配合 Paint 绘制饼状图；drawArc 的第一个参数为矩形范围，即圆弧所在的圆的范围，若非正方形则圆弧所在的圆会拉伸；第二个参数为起始角度，0.0 为坐标系 x 轴正向方形；第三个参数为终止角度，若超过 2PI，则为一个圆；第四个参数为是否由中心出发，false* 时只绘制圆弧，true 时绘制圆饼；第五个参数即 Paint 画笔，可通过 PaintingStyle 属性绘制是否填充等；
    //画扇形
    canvas.drawArc(
        Rect.fromLTRB(20, 150, 100, 230),
        0,
        1.5 * pi,
        true,
        Paint()
          ..strokeWidth = 4
          ..color = Colors.white54);
    //画弧线
    canvas.drawArc(
        Rect.fromCircle(center: Offset(130.0, 150.0), radius: 60.0),
        0.0,
        pi / 2,
        false,
        Paint()
          ..color = Colors.white
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(200.0, 150.0), radius: 60.0),
        0.0,
        pi / 2,
        false,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.fill);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(320.0, 210.0), radius: 60.0),
        60.0,
        pi * 4 / 5,
        true,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(60.0, 300.0), radius: 60.0),
        60.0,
        pi * 2 / 3,
        true,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.fill);
    canvas.drawArc(
        Rect.fromLTWH(100.0, 230.0, 60.0, 60.0),
        0.0,
        5.0,
        true,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill);
    canvas.drawArc(
        Rect.fromPoints(Offset(160.0, 230.0), Offset(220.0, 290.0)),
        0.0,
        5.0,
        true,
        Paint()
          ..color = Colors.yellow
          ..style = PaintingStyle.fill);
    //drawLine 绘制线
    canvas.drawLine(
        Offset(0, 300),
        Offset(640, 300),
        Paint()
          ..strokeWidth = 1
          ..color = Colors.white);
    // drawRect 绘制矩形
    //   drawRect 用来绘制矩形，Flutter 提供了多种绘制矩形方法：
    //  1. Rect.fromPoints 根据两个点(左上角点/右下角点)来绘制；
    canvas.drawRect(
        Rect.fromPoints(Offset(10.0, 310.0), Offset(110.0, 360.0)),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke);

    canvas.drawRect(
        Rect.fromPoints(Offset(130.0, 310.0), Offset(230.0, 360.0)),
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill);
    //  2. Rect.fromLTRB 根据以屏幕左上角为坐标系圆点，分别设置上下左右四个方向距离；
    canvas.drawRect(Rect.fromLTRB(240.0, 310.0, 340.0, 360.0),
        Paint()..color = Colors.yellow);
    //   Rect.fromLTWH 根据设置左上角的点与矩形宽高来绘制；
    canvas.drawRect(
        Rect.fromLTWH(10.0, 370.0, 100.0, 60.0), Paint()..color = Colors.blue);
    //   Rect.fromCircle 最特殊，根据圆形绘制正方形；
    canvas.drawRect(
        Rect.fromCircle(center: Offset(150.0, 400.0), radius: 30.0),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke);

    //drawLine 绘制线
    canvas.drawLine(
        Offset(0, 440),
        Offset(640, 440),
        Paint()
          ..strokeWidth = 1
          ..color = Colors.white);

    // drawRRect 绘制圆角矩形
    //       drawRRect 绘制圆角矩形，Flutter 提供了多种绘制方法：

    // 1.RRect.fromLTRBXY 前四个参数用来绘制矩形位置，剩余两个参数绘制固定 x/y 弧度；
    // RRect.fromLTRBXY 方式
    canvas.drawRRect(
        RRect.fromLTRBXY(10.0, 445.0, 100.0, 505.0, 8.0, 8.0),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke);
    canvas.drawRRect(
        RRect.fromLTRBXY(110.0, 445.0, 200.0, 505.0, 18.0, 18.0),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke);
    // 2.RRect.fromLTRBR 前四个参数用来绘制矩形位置，最后一个参数绘制 Radius 弧度；
    // RRect.fromLTRBR 方式
    canvas.drawRRect(
        RRect.fromLTRBR(210.0, 445.0, 300.0, 505.0, Radius.circular(10.0)),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke);
    // 3.RRect.fromLTRBAndCorners 前四个参数用来绘制矩形位置，剩余四个可选择参数，根据需求设置四个角 Radius 弧度，可不同；
    // RRect.fromLTRBAndCorners 方式
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(310.0, 445.0, 400.0, 505.0,
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(20.0)),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke);
    // 4.RRect.fromRectAndCorners第一个参数绘制矩形，可以用上面介绍的多种矩形绘制方式，剩余四个可选择参数，根据需求设置四个角 Radius 弧度，最为灵活。
    //   RRect.fromRectAndCorners 方式
    canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromLTWH(10.0, 510.0, 90.0, 60.0),
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(20.0)),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke);

    // 5.RRect.fromRectAndRadius 第一个参数绘制矩形，可以用上面介绍的多种矩形绘制方式，最后一个参数绘制 Radius 弧度；
    // RRect.fromRectAndRadius 方式
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(110.0, 510.0, 90.0, 60.0),
            Radius.elliptical(8.0, 18.0)),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke);
    // 6.RRect.fromRectXY 第一个参数绘制矩形，可以用上面介绍的多种矩形绘制方式，剩余两个参数绘制固定 x/y 弧度；
    // RRect.fromRectXY 方式
    canvas.drawRRect(
        RRect.fromRectXY(
            Rect.fromCircle(center: Offset(240.0, 540.0), radius: 30.0),
            8.0,
            8.0),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke);
    //圆角矩形套着圆角矩形
    //外面矩形
    canvas.drawRRect(
        RRect.fromRectXY(
            Rect.fromCircle(center: Offset(310.0, 540.0), radius: 30.0),
            8.0,
            8.0),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4.0
          ..style = PaintingStyle.stroke);
    //内部矩形
    canvas.drawRRect(
        RRect.fromRectXY(
            Rect.fromCircle(center: Offset(310.0, 540.0), radius: 25.0),
            8.0,
            8.0),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke);
    //drawLine 绘制线
    canvas.drawLine(
        Offset(0, 575),
        Offset(640, 575),
        Paint()
          ..strokeWidth = 2
          ..color = Colors.white);

    // drawDRRect 绘制嵌套矩形
    // drawDRRect 绘制嵌套矩形，第一个参数为外部矩形，第二个参数为内部矩形，可用上述多种设置圆角矩形方式；最后一个参数为 Paint 画笔，且 PaintingStyle 为 fill 时填充的是两个矩形之间的范围。
    canvas.drawDRRect(
        RRect.fromRectXY(
            Rect.fromCircle(center: Offset(50.0, 620.0), radius: 40.0),
            8.0,
            8.0),
        RRect.fromRectXY(
            Rect.fromCircle(center: Offset(55.0, 625.0), radius: 34.0),
            8.0,
            8.0),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke);

    canvas.drawDRRect(
        RRect.fromRectXY(
            Rect.fromCircle(center: Offset(140.0, 620.0), radius: 40.0),
            8.0,
            8.0),
        RRect.fromRectXY(
            Rect.fromCircle(center: Offset(140.0, 620.0), radius: 34.0),
            8.0,
            8.0),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3.0
          ..style = PaintingStyle.fill);

    //drawCircle 绘制圆形
    //drawCircle 绘制圆形，仅需设置原点及半径即可；
    canvas.drawCircle(
        Offset(220.0, 620.0),
        30.0,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke);
    canvas.drawCircle(
        Offset(285.0, 620.0),
        30.0,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3.0
          ..style = PaintingStyle.fill);
    //drawOval 绘制椭圆
    //drawOval 绘制椭圆方式很简单，主要绘制一个矩形即可；
    canvas.drawOval(
        Rect.fromLTRB(330.0, 580.0, 380.0, 610.0),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke);
    canvas.drawOval(
        Rect.fromLTRB(330.0, 620.0, 380.0, 650.0),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3.0
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(BasePainter oldDelegate) => false;
}

class Sky extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    const RadialGradient gradient = RadialGradient(
      center: Alignment(0.7, -0.6),
      radius: 0.2,
      colors: <Color>[Color(0xFFFFFF00), Color(0xFF0099FF)],
      stops: <double>[0.4, 1.0],
    );
    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      // Annotate a rectangle containing the picture of the sun
      // with the label "Sun". When text to speech feature is enabled on the
      // device, a user will be able to locate the sun on this picture by
      // touch.
      Rect rect = Offset.zero & size;
      final double width = size.shortestSide * 0.4;
      rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
      return <CustomPainterSemantics>[
        CustomPainterSemantics(
          rect: rect,
          properties: const SemanticsProperties(
            label: 'Sun',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(Sky oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(Sky oldDelegate) => false;
}
