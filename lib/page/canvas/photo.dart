import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

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
  ui.Image? _chatImageFrame; //聊天框图片
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
        await getAssetImage('assets/images/cup.jpg', width: 300, height: 300);
    ui.Image chatImageFrame =
        await getAssetImage('assets/images/right_chat.png');
    setState(() {
      _chatImageFrame = chatImageFrame;
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
              painter: PhotoPainter(
                  _assetImageFrame!, _netImageFrame!, _chatImageFrame!),
              size: MediaQuery.of(context).size),
    );
  }
}

class PhotoPainter extends CustomPainter {
  ui.Image _assetImageFrame;
  ui.Image _netImageFrame;
  ui.Image _chatImageFrame;
  PhotoPainter(this._assetImageFrame, this._netImageFrame, this._chatImageFrame)
      : super();
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
    // canvas.drawImage(_netImageFrame, Offset(10, 370), selfPaint);
    canvas.drawImageRect(_assetImageFrame, Rect.fromLTWH(100, 100, 150, 150),
        Rect.fromLTWH(310, 70, 100, 100), Paint());
    canvas.drawImageNine(_assetImageFrame, Rect.fromLTWH(100, 50, 120, 70),
        Rect.fromLTWH(10, 380, 350, 420), Paint());

    //画微信聊天框
    canvas.drawImage(_chatImageFrame, Offset(100, 150), Paint());
    canvas.drawImageNine(
        _chatImageFrame,
        Rect.fromCenter(
            center:
                Offset(_chatImageFrame.width / 2, _chatImageFrame.height - 6),
            width: _chatImageFrame.width - 20,
            height: 2),
        Rect.fromCenter(center: Offset(100, 150), width: 100, height: 40)
            .translate(50, 100),
        Paint());

    //绘制文字
    ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
        textAlign: TextAlign.left, fontSize: 25, fontWeight: FontWeight.w700))
      ..pushStyle(ui.TextStyle(color: Colors.green))
      ..addText(
          'Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。 Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。');
    ParagraphConstraints pc = ParagraphConstraints(width: 300);
    Paragraph paragraph = pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, Offset(30, 400));
    //裁切图片
    canvas.clipRRect(RRect.fromRectXY(Rect.fromLTWH(30, 300, 190, 250), 30, 30),
        doAntiAlias: false);
    canvas.drawImage(_netImageFrame, ui.Offset(30, 300), Paint());

    Path path = Path()
      ..moveTo(30, 340)
      ..lineTo(60, 450)
      ..lineTo(90, 380)
      ..lineTo(140, 360);
    canvas.drawPath(path, Paint()..color = Colors.red);
    // canvas.clipPath(path);
    // canvas.drawImage(_netImageFrame, ui.Offset(10, 90), Paint());
  }

  @override
  bool shouldRepaint(PhotoPainter oldDelegate) => true;
}
