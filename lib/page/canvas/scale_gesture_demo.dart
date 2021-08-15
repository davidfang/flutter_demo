import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///文档说明
///基于手势的缩放

class ScaleGestureDemo extends StatefulWidget {
  static String routName = '/ScaleGestureDemo';

  @override
  _ScaleGestureDemoState createState() => new _ScaleGestureDemoState();
}

class _ScaleGestureDemoState extends State<ScaleGestureDemo> {
  final ValueNotifier<Matrix4> matrix =
      ValueNotifier<Matrix4>(Matrix4.identity());

  Matrix4 recodeMatrix = Matrix4.identity();
  Offset _offset = Offset.zero;
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
  void didUpdateWidget(ScaleGestureDemo oldWidget) {
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
        title: new Text('基于手势的缩放'),
      ),
      body: Container(
          height: 300 * 0.75,
          width: 300,
          color: Colors.cyanAccent.withOpacity(0.1),
          child: GestureDetector(
              onScaleStart: _onScaleStart,
              onScaleUpdate: _onScaleUpdate,
              onScaleEnd: _onScaleEnd,
              child: CustomPaint(
                painter: GesturePainter(matrix: matrix),
              ))),
    );
  }

  void _onScaleStart(ScaleStartDetails details) {
    if (details.pointerCount == 1) {
      _offset = details.focalPoint;
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (details.pointerCount == 1) {
      matrix.value = Matrix4.translationValues(
              (details.focalPoint.dx - _offset.dx),
              (details.focalPoint.dy - _offset.dy),
              1)
          .multiplied(recodeMatrix);
    } else {
      if ((details.rotation * 180 / pi).abs() > 15) {
        matrix.value =
            recodeMatrix.multiplied(Matrix4.rotationZ(details.rotation));
      } else {
        if (details.scale == 1.0) return;

        matrix.value = recodeMatrix.multiplied(
            Matrix4.diagonal3Values(details.scale, details.scale, 1));
      }
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    recodeMatrix = matrix.value;
  }
}

class GesturePainter extends CustomPainter {
  Paint girdPaint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.stroke;

  Path girdPath = Path();
  final ValueListenable<Matrix4>? matrix;
  ValueListenable<Matrix4>? get Matrix => matrix;
  GesturePainter({this.matrix}) : super(repaint: matrix);

  @override
  void paint(Canvas canvas, Size size) {
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.transform(matrix!.value.storage);
    drawSomething(canvas, size);
  }

  @override
  bool shouldRepaint(covariant GesturePainter oldDelegate) =>
      oldDelegate.matrix != matrix;

  void drawSomething(Canvas canvas, Size size) {
    canvas.drawCircle(Offset.zero, 10, Paint());
    girdPath.reset();
    girdPath.moveTo(-size.width / 2, 0);
    girdPath.relativeLineTo(size.width, 0);
    girdPath.moveTo(0, -size.height / 2);
    girdPath.relativeLineTo(0, size.height);
    canvas.drawPath(girdPath, girdPaint);
    canvas.drawCircle(
        Offset.zero.translate(4, 4), 1, Paint()..color = Colors.white);
    canvas.drawCircle(
        Offset.zero.translate(-4, -4), 1, Paint()..color = Colors.white);
    canvas.drawCircle(
        Offset.zero.translate(4, -4), 1, Paint()..color = Colors.white);
  }
}
