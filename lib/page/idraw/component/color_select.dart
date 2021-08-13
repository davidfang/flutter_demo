import 'package:flutter/material.dart';

typedef ColorSelectCallback = void Function(Color color);

class ColorSelect extends StatefulWidget {
  final List<Color>? colors;
  final double radius;
  final ColorSelectCallback? onColorSelect;
  final Color? defaultColor;

  final Color? currentColor;

  ColorSelect(
      {this.colors,
      this.radius = 25,
      this.defaultColor,
      this.currentColor,
      @required this.onColorSelect});
  @override
  _ColorSelectState createState() => _ColorSelectState();
}

class _ColorSelectState extends State<ColorSelect> {
  int _selectIndex = 0;
  Color get activeColor => widget.colors![_selectIndex];

  @override
  void initState() {
    super.initState();

    if (widget.currentColor != null) {
      _selectIndex = widget.colors!.indexOf(widget.defaultColor!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      child: Wrap(
        spacing: 20,
        children: widget.colors!
            .map((e) => GestureDetector(
                  onTap: () => _doSelectColor(e),
                  child: _buildItem(e),
                ))
            .toList(),
      ),
    );
  }

  // 构建圆圈
  _buildItem(Color color) => Container(
      width: widget.radius,
      height: widget.radius,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: activeColor == color ? _buildActiveIndicator() : null);
  //构建白圆圈指示器
  _buildActiveIndicator() => Container(
      width: widget.radius * 0.6,
      height: widget.radius * 0.6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ));
  //执行选中方法，触发回调
  _doSelectColor(Color color) {
    int index = widget.colors!.indexOf(color);
    if (index == _selectIndex) return;
    setState(() {
      _selectIndex = index;
    });
    widget.onColorSelect?.call(color);
  }
}
