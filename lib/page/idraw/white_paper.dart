import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component/paint_setting_dialog.dart';
import 'model/line.dart';
import 'model/paint_model.dart';
import 'model/point.dart';
import 'paper_painter.dart';

///文档说明
///绘画的白纸

enum TransformType {
  none, //绘制
  translate, //移动
  rotate, //旋转
  scale, //缩放
}

class WhitePaper extends StatefulWidget {
  static String routName = '/WhitePaper';

  @override
  _WhitePaperState createState() => new _WhitePaperState();
}

class _WhitePaperState extends State<WhitePaper> {
  final PaintModel paintModel = PaintModel();
  Color lineColor = Colors.black;
  double strokeWidth = 1;
  ValueNotifier<TransformType> type =
      ValueNotifier<TransformType>(TransformType.none);
  Matrix4 recodeMatrix = Matrix4.identity();
  Offset _offset = Offset.zero;

  static const List<IconData> icons = [
    Icons.edit, //编辑
    Icons.api, //移动
    Icons.rotate_90_degrees_ccw, //旋转
    Icons.expand, //缩放
  ];

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

  Widget _buildTools() {
    return ValueListenableBuilder(
        valueListenable: type,
        builder: (BuildContext context, TransformType typeValue, __) => Row(
              mainAxisSize: MainAxisSize.min,
              children: icons.asMap().keys.map((index) {
                bool active = typeValue == TransformType.values[index];
                return IconButton(
                    onPressed: () => type.value = TransformType.values[index],
                    icon: Icon(icons[index],
                        color: active ? Colors.blue : Colors.black54));
              }).toList(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('空白画纸'),
        ),
        body: Stack(
          children: [
            GestureDetector(
              onTap: _showSettingDialog,
              // onPanDown: _initLineData,
              // onPanUpdate: _collectPoint,
              // onPanEnd: _doneAline,
              // onPanCancel: _cancel,

              onScaleStart: _onScaleStart, // 开始
              onScaleUpdate: _onScaleUpdate, // 更新
              onScaleEnd: _onScaleEnd, // 抬起

              onLongPressStart: _activateEdit, //长按开始移动
              onLongPressUp: _cancelEdit, // 长按抬起
              onLongPressMoveUpdate: _moveEdit, //长按移动

              onDoubleTap: _clear,

              child: CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: PaperPainter(model: paintModel)),
            ),
            Positioned(
              child: _buildTools(),
              right: 20,
              top: 10,
            )
          ],
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

  void _clear() {
    paintModel.clear();
  }

  //弹出设置
  void _showSettingDialog() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => PaintSettingDialog(
            initColor: lineColor,
            initWidth: strokeWidth,
            onLineWidthSelect: _selectWidth,
            onColorSelect: _selectColor));
  }

  void _selectWidth(double width) {
    strokeWidth = width;
  }

  void _selectColor(Color color) {
    lineColor = color;
  }

  void _activateEdit(LongPressStartDetails details) {
    paintModel.activeEditLine(Point.fromOffset(details.localPosition));
  }

  void _cancelEdit() {
    paintModel.cancelEditLine();
  }

  void _moveEdit(LongPressMoveUpdateDetails details) {
    paintModel.moveEditLine(details.offsetFromOrigin);
  }

  void _onScaleStart(ScaleStartDetails details) {
    switch (type.value) {
      case TransformType.none:
        Line line = Line(color: lineColor, strokeWidth: strokeWidth);
        paintModel.pushLine(line);
        break;
      case TransformType.translate:
        if (details.pointerCount == 1) {
          _offset = details.focalPoint;
        }
        break;
      case TransformType.rotate:
        break;
      case TransformType.scale:
        break;
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    switch (type.value) {
      case TransformType.none:
        paintModel.pushPoint(Point.fromOffset(details.localFocalPoint));
        break;
      case TransformType.translate:
        paintModel.matrix = Matrix4.translationValues(
                (details.focalPoint.dx - _offset.dx),
                (details.focalPoint.dy - _offset.dy),
                1)
            .multiplied(recodeMatrix);
        break;
      case TransformType.rotate:
        paintModel.matrix =
            recodeMatrix.multiplied(Matrix4.rotationZ(details.rotation));
        break;
      case TransformType.scale:
        if (details.scale == 1.0) return;
        paintModel.matrix = recodeMatrix.multiplied(
            Matrix4.diagonal3Values(details.scale, details.scale, 1));
        break;
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    switch (type.value) {
      case TransformType.none:
        paintModel.doneLine();
        paintModel.removeEmpty();
        break;
      case TransformType.translate:
      case TransformType.rotate:
      case TransformType.scale:
        recodeMatrix = paintModel.matrix;
        break;
    }
  }
}
