import 'dart:math';

import 'package:flutter/material.dart';

import 'coordinate_pro.dart';

///文档说明
///canvas path使用下
///https://juejin.cn/book/6844733827265331214/section/6844733827311468552

class CanvasPath extends StatefulWidget {
  static String routName = '/CanvasPath';

  @override
  _CanvasPathState createState() => new _CanvasPathState();
}

class _CanvasPathState extends State<CanvasPath> {
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
  void didUpdateWidget(CanvasPath oldWidget) {
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
          title: new Text('Canvas路径操作'),
        ),
        body: Container(
          child: CustomPaint(
              painter: PathPaint(), size: MediaQuery.of(context).size),
        ));
  }
}

class PathPaint extends CustomPainter {
  final Coordinate coordinate = Coordinate();
  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    // 1.close、reset、shift
    //path#close ：用于将路径尾点和起点，进行路径封闭。
    // path#reset ：用于将路径进行重置，清除路径内容。
    // path#shift ：指定点Offset将路径进行平移，且返回一条新的路径。
    Path path = new Path();
    Paint paint = new Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path
      ..lineTo(100, 100)
      ..relativeLineTo(0, -50)
      ..close();
    canvas.drawPath(path, paint);
    canvas.drawPath(
        path.shift(Offset(100, 0)), paint..color = Colors.greenAccent);
    canvas.drawPath(path.shift(Offset(-100, 0)), paint);
    //2. contains和getBounds
    //Paint#contains可以判断点Offset在不在路径之内(如下图紫色区域)，
    // 这是个非常好用的方法，可以根据这个方法做一些触点判断或简单的碰撞检测。
    // Paint#getBounds可以获取当前路径所在的矩形区域，(如下橙色区域)
    path.reset();
    paint
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.fill;
    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 130)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();
    canvas.drawPath(path, paint);
    print(path.contains(Offset(0, 20))); //在path之内
    print(path.contains(Offset(30, 30))); //不在path之内
    Rect bound = path.getBounds();
    canvas.drawRect(
        bound,
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke);
    //3.Path#transform: 路径变换
    //对于对称性图案，当已经有一部分单体路径，可以根据一个4*4的矩阵对路径进行变换。
    //可以使用Matrix4对象进行辅助生成矩阵。能很方便进行旋转、平移、缩放、斜切等变换效果。
    canvas.translate(0, -160);
    for (var i = 0; i < 8; i++) {
      canvas.drawPath(
          path.transform(Matrix4.rotationZ(i * pi / 4).storage), paint);
    }

    //4. combine: 路径联合
    //Patn#combine用于结合两个路径，并生成新路径，可用于生成复杂的路径。
    //一共有如下五种联合方式，效果如下图:
    canvas.translate(0, 160 + 160);
    Path pathOval = Path()
      ..addOval(Rect.fromCenter(center: Offset(0, 0), width: 60, height: 60));
    canvas.drawPath(
        Path.combine(PathOperation.difference, path, pathOval), paint);
    _drawLableText(canvas, 'difference');
    canvas.translate(80, 0);
    canvas.drawPath(
        Path.combine(PathOperation.intersect, path, pathOval), paint);
    _drawLableText(canvas, 'intersect');
    canvas.translate(80, 0);
    canvas.drawPath(Path.combine(PathOperation.union, path, pathOval), paint);
    _drawLableText(canvas, 'union');
    canvas.translate(-80 * 3, 0);
    canvas.drawPath(Path.combine(PathOperation.xor, path, pathOval), paint);
    _drawLableText(canvas, 'xor');
    canvas.translate(-80, 0);
    canvas.drawPath(
        Path.combine(PathOperation.reverseDifference, path, pathOval), paint);
    canvas.translate(20, -40);
    _drawLableText(canvas, 'reverseDifference');
  }

  //画下面的标示文字
  _drawLableText(Canvas canvas, String str) {
    TextPainter text = TextPainter(
        text: TextSpan(
            text: str, style: TextStyle(fontSize: 15, color: Colors.black)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    text.layout();
    Size size = text.size;
    text.paint(canvas, Offset(-size.width / 2, 130));
  }

  @override
  shouldRepaint(PathPaint oldDelegate) => true;
}
