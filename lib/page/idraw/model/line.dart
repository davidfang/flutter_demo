import 'dart:ui';

import 'package:flutter/material.dart';

import 'point.dart';

enum PaintState { doing, done, hide, edit }

class Line {
  List<Point> points = [];
  PaintState state;
  double strokeWidth;
  Color color;
  Path _linePath = Path();
  Path? _recodePath;
  Size? paperSize;
  Line({
    this.color = Colors.black,
    this.strokeWidth = 1,
    this.state = PaintState.doing,
  });
  Path get path => _linePath;
  void paint(Canvas canvas, Size size, Paint paint, Matrix4 matrix) {
    Size paperSize = size;
    paint
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = strokeWidth;

    if (state == PaintState.doing) {
      _linePath = formPath();
      final Matrix4 result = Matrix4.identity();
      result.translate(paperSize.width / 2, paperSize.height / 2);
      result.multiply(matrix);
      result.translate(-paperSize.width / 2, -paperSize.height / 2);
      result.invert();
      _linePath = path.transform(result.storage);
    }
    //画路径顺滑的线
    canvas.drawPath(_linePath, paint);
    //加移动辅助线框
    if (state == PaintState.edit) {
      Paint paint1 = Paint()
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke
        ..color = Colors.deepPurpleAccent;
      canvas.drawRect(
          Rect.fromCenter(
              center: _linePath.getBounds().center,
              width: _linePath.getBounds().width + strokeWidth,
              height: _linePath.getBounds().height + strokeWidth),
          paint1);
    }

    //加两个侧面修饰线
    // Path p1 =
    //     _linePath.shift(Offset(paint.strokeWidth / 2, paint.strokeWidth / 2));
    // Path p2 =
    //     _linePath.shift(Offset(-paint.strokeWidth / 2, -paint.strokeWidth / 2));
    // Paint paint1 = Paint()
    //   ..strokeWidth = 1
    //   ..style = PaintingStyle.stroke;
    // canvas.drawPath(p1, paint1);
    // canvas.drawPath(p2, paint1);
    //画点连成的线
    // canvas.drawPoints(PointMode.polygon,
    //     points.map<Offset>((e) => e.toOffset()).toList(), paint);
  }

  void recode() {
    _recodePath = path.shift(Offset.zero);
  }

  void translate(Offset offset) {
    if (_recodePath == null) return;
    _linePath = _recodePath!.shift(offset);
  }

  bool contains(Offset offset, [Matrix4? _matrix]) {
    final Matrix4 result = Matrix4.identity();
    result.translate(paperSize!.width / 2, paperSize!.height / 2);
    result.multiply(_matrix!);
    result.translate(-paperSize!.width / 2, -paperSize!.height / 2);
    Path judgePath = path.transform(result.storage);
    return judgePath.getBounds().contains(offset);
  }

  Path formPath() {
    Path path = new Path();
    for (int i = 0; i < points.length - 1; i++) {
      Point current = points[i];
      Point next = points[i + 1];
      if (i == 0) {
        path.moveTo(current.x!, current.y!);
        path.lineTo(next.x!, next.y!);
      } else if (i <= points.length - 2) {
        double xc = (points[i].x! + points[i + 1].x!) / 2;
        double yc = (points[i].y! + points[i + 1].y!) / 2;
        Point p2 = points[i];
        path.quadraticBezierTo(p2.x!, p2.y!, xc, yc);
      } else {
        path.moveTo(current.x!, current.y!);
        path.lineTo(next.x!, next.y!);
      }
    }

    return path;
  }
}
