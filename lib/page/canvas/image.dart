import 'dart:developer';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///文档说明
///CanvasImage

class CanvasImage extends StatefulWidget {
  CanvasImage({Key? key}) : super(key: key);

  @override
  _CanvasImageState createState() => _CanvasImageState();
}

class _CanvasImageState extends State<CanvasImage> {
  ui.Image? _image;
  bool _loaded = false;

  /// 通过assets路径，获取资源图片
  load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    Size size = MediaQuery.of(context).size;
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: size.width.toInt(), targetHeight: size.height.toInt());
    ui.FrameInfo fi = await codec.getNextFrame();
    if (mounted) {
      setState(() {
        _image = fi.image;
        _loaded = true;
      });
    }
    log('我是图片:$_image');
  }

  @override
  void initState() {
    super.initState();
    load("assets/images/team.jpg");
  }

  @override
  Widget build(BuildContext context) {
    print('build   ');
    // TODO: implement build

    // var paint =  CustomPaint(
    //         size: Size(300, 300),
    //         painter: TestPainter(_image),
    //       )
    //     ;
    return Scaffold(
      appBar: AppBar(
        title: Text("Canvas Image"),
      ),
      body: Container(
          child: Column(children: [
        TextButton(
            child: Text('点击加载'),
            onPressed: () => load('assets/images/team.jpg')),
        _loaded
            ? CustomPaint(
                size: Size(600, 600),
                painter: TestPainter(_image!),
              )
            : Text('加载中'),
        _loaded ? Text('加载完成') : Text('加载中……'),
      ])),
    );
  }
}

class TestPainter extends CustomPainter {
  Paint _paint = new Paint()
    ..color = Colors.blueAccent // 画笔颜色
    ..strokeCap = StrokeCap.round //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..strokeWidth = 6.0 //画笔的宽度
    ..style = PaintingStyle.stroke // 样式
    ..blendMode = BlendMode.darken; // 模式

  ui.Image _image;

  TestPainter(this._image) {
    this._image = _image;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    // if (_image != null) {
    canvas.drawImage(_image, Offset(0, 0), _paint);
    canvas.drawImageRect(
        _image,
        Offset(0.0, 0.0) &
            Size(_image.width.toDouble(), _image.height.toDouble()),
        Offset(0.0, 0.0) & Size(200, 200),
        _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    ///是否需要重绘
    return false;
  }
}
