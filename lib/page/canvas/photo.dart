import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///文档说明
///drawShadow 绘制阴影 drawImage 绘制图片  drawImageNine 绘制九图
///drawParagraph 绘制文字段落
///clipRect 裁剪矩形 clipRRect 裁剪圆角矩形

//方法1：获取网络图片 返回ui.Image
Future<ui.Image> getNetImage(String url, {width, height}) async {
  ByteData data = await NetworkAssetBundle(Uri.parse(url)).load(url);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width, targetHeight: height);
  ui.FrameInfo fi = await codec.getNextFrame();
  return fi.image;
}

//方法2.1：获取本地图片  返回ui.Image 需要传入BuildContext context
Future<ui.Image> getAssetImage2(String asset, BuildContext context,
    {width, height}) async {
  ByteData data = await DefaultAssetBundle.of(context).load(asset);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width, targetHeight: height);
  ui.FrameInfo fi = await codec.getNextFrame();
  return fi.image;
}

//方法2.2：获取本地图片 返回ui.Image 不需要传入BuildContext context
Future<ui.Image> getAssetImage(String asset, {width, height}) async {
  ByteData data = await rootBundle.load(asset);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width, targetHeight: height);
  ui.FrameInfo fi = await codec.getNextFrame();
  return fi.image;
}
//方法3：通过stream类型来获取ui.Image 待更新

class CanvasPhoto extends StatefulWidget {
  final GlobalKey globalKey = GlobalKey();
  static String routName = '/CanvasPhoto';

  @override
  _CanvasPhotoState createState() => new _CanvasPhotoState();
}

class _CanvasPhotoState extends State<CanvasPhoto> {
  ui.Image? _assetImageFrame; //本地图片
  ui.Image? _netImageFrame;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAssetImage();
    _getNetImage();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(CanvasPhoto oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  //获取本地图片
  _getAssetImage() async {
    ui.Image imageFrame =
        await getAssetImage('assets/images/team.jpg', width: 300, height: 300);
    setState(() {
      _assetImageFrame = imageFrame;
    });
  }

  // //获取网络图片
  _getNetImage() async {
    ui.Image imageFrame = await getNetImage(
        'https://bkimg.cdn.bcebos.com/pic/58ee3d6d55fbb2fb4316aea6150137a4462309f77679',
        width: 200,
        height: 300);
    setState(() {
      _netImageFrame = imageFrame;
    });
  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('CanvasPhoto Canvas'),
      ),
      body: _assetImageFrame == null || _netImageFrame == null
          ? Text('数据加载中')
          : CustomPaint(
              painter: PhotoPainter(_assetImageFrame!, _netImageFrame!),
              size: MediaQuery.of(context).size),
    );
  }
}

class PhotoPainter extends CustomPainter {
  ui.Image _assetImageFrame;
  ui.Image _netImageFrame;
  PhotoPainter(this._assetImageFrame, this._netImageFrame) : super();
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = 30;
    double eHeight = 30;

    //画背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb175); //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);

    //画网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black12
      ..strokeWidth = 1.0;

    for (int i = 0; i <= size.height / eHeight; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= size.width / eWidth; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    // drawShadow 绘制阴影
    // drawShadow 用于绘制阴影，
    //第一个参数时绘制一个图形 Path，第二个是设置阴影颜色，第三个为阴影范围，最后一个阴影范围是否填充满；
    canvas.drawShadow(
        Path()
          ..moveTo(30.0, 10.0)
          ..lineTo(120.0, 10.0)
          ..lineTo(120.0, 60.0)
          ..lineTo(30.0, 60.0)
          ..close(),
        Colors.blue,
        5,
        false);

    canvas.drawShadow(
        Path()
          ..moveTo(140.0, 10.0)
          ..lineTo(230.0, 10.0)
          ..lineTo(230.0, 60.0)
          ..lineTo(140.0, 60.0),
        Colors.blue,
        10,
        false);
    canvas.drawShadow(
        Path()
          ..moveTo(250.0, 10.0)
          ..lineTo(310.0, 10.0)
          ..lineTo(310.0, 60.0)
          ..lineTo(250.0, 60.0)
          ..close(),
        Colors.blue,
        3,
        true);

    canvas.drawPath(
        Path()
          ..moveTo(330.0, 10.0)
          ..lineTo(380.0, 10.0)
          ..lineTo(380.0, 60.0)
          ..lineTo(330.0, 60.0),
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke);

    // drawImage 绘制图片
    // drawImage 用于绘制图片，绘制图片是重点，此时的 Image 并非日常所用的图片加载，而是用的 dart.ui 类中的 ui.Image 并转换成字节流 ImageStream 方式传递，包括本地图片或网络图片

    Paint selfPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 30.0;
    canvas.drawImage(_assetImageFrame, Offset(5, 70), selfPaint);
    canvas.drawImage(_netImageFrame, Offset(10, 370), selfPaint);
  }

  @override
  bool shouldRepaint(PhotoPainter oldDelegate) => true;
}
