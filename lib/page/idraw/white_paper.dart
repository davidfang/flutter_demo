import 'package:flutter/material.dart';

import 'model/line.dart';
import 'model/paint_model.dart';
import 'model/point.dart';
import 'paper_painter.dart';

///文档说明
///绘画的白纸

class WhitePaper extends StatefulWidget {
  static String routName = '/WhitePaper';

  @override
  _WhitePaperState createState() => new _WhitePaperState();
}

class _WhitePaperState extends State<WhitePaper> {
  final PaintModel paintModel = PaintModel();
  Color lineColor = Colors.black;
  double strokeWidth = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    paintModel.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(WhitePaper oldWidget) {
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
          title: new Text('空白画纸'),
        ),
        body: GestureDetector(
          onPanDown: _initLineData,
          onPanUpdate: _collectPoint,
          onPanEnd: _doneAline,
          onPanCancel: _cancel,
          onDoubleTap: _clear,
          child: CustomPaint(
              size: MediaQuery.of(context).size,
              painter: PaperPainter(model: paintModel)),
        ));
  }

  //拖动按下时执行 _initLineData 方法，逻辑很简单，就是创建一个 Line 对象，然后通过 pushLine 维护到 paintModel 中，注意Line 默认状态是 doing 。
  void _initLineData(DragDownDetails details) {
    Line line = Line(color: lineColor, strokeWidth: strokeWidth);
    paintModel.pushLine(line);
  }

  //拖动更新时执行 _collectPoint 方法；paintModel.pushPoint 方法会将一个 Point 对象加入到状态是 doing 的线中，也就是按下时创建的那个线对象。再执行 notifyListeners 触发画板重绘，我们就可以看到线在随着触点的移动而被绘制出来。
  void _collectPoint(DragUpdateDetails details) {
    paintModel.pushPoint(Point.fromOffset(details.localPosition));
  }

  //拖动结束时执行 _doneALine 方法；执行 paintModel.doneLine 将 doing 状态的那个线置为 done 。这是保证移动时只有一个 doing 状态线对象的前提。
  void _doneAline(DragEndDetails details) {
    paintModel.doneLine();
  }

  //另外有一个非常容易忽略的地方，点击立刻抬起不会触发 onPanEnd ，而是 onPanCancel 。这样会让 doing 状态的线存活下来，这是不允许的，所以在 _cancel 中对点集为空的线进行清除。
  void _cancel() {
    paintModel.removeEmpty();
  }

  void _clear() {}
}
