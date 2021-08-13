import 'package:flutter/material.dart';
import 'package:flutter_demo/page/idraw/component/color_select.dart';

import 'line_width_select.dart';

const List<Color> _kColorSupport = [
  Colors.black,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.orange,
  Colors.yellow,
  Colors.indigo,
  Colors.purple,
  Colors.pink
];

const List<double> _kWidthSupport = [
  1.0,
  3.0,
  5.0,
  6.0,
  7.0,
  8.0,
  9.0,
  12.0,
  15.0
];

class PaintSettingDialog extends StatelessWidget {
  final LineWidthCallback? onLineWidthSelect;
  final ColorSelectCallback? onColorSelect;
  final initColor;
  final initWidth;
  const PaintSettingDialog(
      {Key? key,
      @required this.onLineWidthSelect,
      @required this.onColorSelect,
      this.initColor = Colors.black,
      this.initWidth = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildColorSelect(),
                Divider(
                  height: 1,
                ),
                _buildLineWidthSelect(),
                Container(color: Colors.white.withOpacity(0.3), height: 10),
                _buildCancel(context)
              ],
            )));
  }

  Widget _buildCancel(BuildContext context) => Material(
      child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Ink(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.white,
              child: Center(
                  child: Text('取消',
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold))))));

  Widget _buildColorSelect() =>
      ColorSelect(colors: _kColorSupport, onColorSelect: onColorSelect);

  Widget _buildLineWidthSelect() => LineWidthSelect(
      numbers: _kWidthSupport, onLineWidthSelect: onLineWidthSelect);
}
