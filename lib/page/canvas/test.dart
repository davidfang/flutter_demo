import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:ui';

///文档说明
///canvas test

class CanvasTest extends StatefulWidget {
  static String routName = '/CanvasTest';

  @override
  _CanvasTestState createState() => new _CanvasTestState();
}

class _CanvasTestState extends State<CanvasTest> {
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
  void didUpdateWidget(CanvasTest oldWidget) {
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
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: CustomPaint(
          painter: CanvasPainter(),
          foregroundPainter: ForegroundPainter(),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 5),
            ),
            child: Stack(
              children: <Widget>[
                Text("我是CustomPaint的child"),
                Center(
                  child: Text(
                    "96",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.black;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    canvas.drawColor(Colors.green, Paint().blendMode);
    // canvas.drawLine(Offset(30, 30), Offset(50, 50), paint);
    canvas.drawCircle(Offset(70, 70), 5, paint);
    canvas.drawRect(Rect.fromLTRB(100, 100, 200, 200), paint);
    paint.color = Colors.red;
    canvas.drawOval(Rect.fromLTRB(100, 100, 200, 200), paint);

    paint.color = Colors.yellow;
    canvas.drawArc(Rect.fromCircle(center: Offset(50, 250), radius: 20),
        0 * (pi / 180), 90 * (pi / 180), true, paint);
    canvas.drawArc(Rect.fromCircle(center: Offset(100, 250), radius: 20),
        60 * (pi / 180), -300 * (pi / 180), true, paint);
    ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: 18,
    ))
      ..addText("width: ${size.width} height: ${size.height}");
    ParagraphConstraints pc = ParagraphConstraints(width: 100);
    Paragraph paragraph = pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, Offset(30, 30));

    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;
    paint.strokeCap = StrokeCap.round;
    paint.color = Colors.white;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: 70),
        -240 * (pi / 180),
        300 * (pi / 180),
        false,
        paint);
    paint.strokeWidth = 2;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: 65),
        -240 * (pi / 180),
        300 * (pi / 180),
        false,
        paint);
    paint.strokeWidth = 4;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: 60),
        -240 * (pi / 180),
        300 * (pi / 180),
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ForegroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Color(0x22FFC107), Paint().blendMode);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
