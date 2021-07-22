import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

///文档说明
///drawShadow 绘制阴影 drawImage 绘制图片  drawImageNine 绘制九图
///drawParagraph 绘制文字段落
///clipRect 裁剪矩形 clipRRect 裁剪圆角矩形

class CanvasPhoto extends StatefulWidget {
  final GlobalKey globalKey = GlobalKey();
  static String routName = '/CanvasPhoto';

  @override
  _CanvasPhotoState createState() => new _CanvasPhotoState();
}

class _CanvasPhotoState extends State<CanvasPhoto> {
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
  void didUpdateWidget(CanvasPhoto oldWidget) {
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
        title: new Text('CanvasPhoto Canvas'),
      ),
      body: CustomPaint(
          painter: PhotoPainter(), size: MediaQuery.of(context).size),
    );
  }
}

class PhotoPainter extends CustomPainter {
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
    // 获取图片 本地为false 网络为true

    // canvas.drawImage(this.image, ui.Offset(120.0, 540.0), Paint());
    // canvas.drawImage(this.image2, ui.Offset(60.0, 60.0), Paint());
  }

//   Future<ui.Image> _loadImage(var path, bool isUrl) async {
//     ImageStream stream;
//     if (isUrl) {
//       stream = NetworkImage(path).resolve(ImageConfiguration.empty);
//     } else {
//       stream = AssetImage(path, bundle: rootBundle)
//           .resolve(ImageConfiguration.empty);
//     }
//     Completer<ui.Image> completer = Completer<ui.Image>();
//     void listener(ImageInfo frame, bool synchronousCall) {
//       final ui.Image image = frame.image;
//       completer.complete(image);
//       stream.removeListener(listener);
//     }

//     stream.addListener(listener);
//     return completer.future;
//   }

// // 加载图片
//   _prepareImg() {
//     _loadImage('images/icon_hzw02.jpg', false).then((image1) {
//       _image1 = image1;
//     }).whenComplete(() {
//       _loadImage(
//               'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=703702342,1604162245&fm=26&gp=0.jpg',
//               true)
//           .then((image2) {
//         _image2 = image2;
//       }).whenComplete(() {
//         _prepDone = true;
//         if (this.mounted) {
//           setState(() {});
//         }
//       });
//     });
//   }

  @override
  bool shouldRepaint(PhotoPainter oldDelegate) => true;
}
