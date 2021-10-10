import 'package:flutter/material.dart';

import 'line.dart';
import 'point.dart';

class PaintModel extends ChangeNotifier {
  List<Line?> _lines = [];
  List<Line?> get lines => _lines;
  final double tolerance = 5.0;

  Matrix4 _matrix = Matrix4.identity();

  set matrix(Matrix4 value) {
    _matrix = value;
    notifyListeners();
  }

  Matrix4 get matrix => _matrix;

  Line? get activeLine =>
      _lines.singleWhere((element) => element?.state == PaintState.doing,
          orElse: () => null);

  Line? get editLine =>
      _lines.singleWhere((element) => element?.state == PaintState.edit,
          orElse: () => null);
  void activeEditLine(Point point) {
    List<Line?> lines = _lines
        .where((line) => line!.path.getBounds().contains(point.toOffset()))
        .toList();

    // List<Line?> lines = _lines
    //     .where((line) => line!.contains(point.toOffset(), _matrix)) //<---
    //     .toList();

    print(lines.length);
    if (lines.isNotEmpty) {
      lines[0]!.state = PaintState.edit;
      lines[0]!.recode();
      notifyListeners();
    }
  }

  void cancelEditLine() {
    _lines.forEach((element) => element!.state = PaintState.done);
    notifyListeners();
  }

  void moveEditLine(Offset offset) {
    if (editLine == null) return;
    editLine!.translate(offset);
    notifyListeners();
  }

  void pushLine(Line line) {
    _lines.add(line);
  }

  void pushPoint(Point point, {bool force = false}) {
    if (activeLine == null) return;
    if (activeLine!.points.isNotEmpty && !force) {
      if ((point - activeLine!.points.last).distance < tolerance) return;
    }
    activeLine?.points.add(point);
    notifyListeners();
  }

  void doneLine() {
    if (activeLine == null) return;
    activeLine?.state = PaintState.done;
    notifyListeners();
  }

  void clear() {
    _lines.forEach((line) => line?.points.clear());
    _lines.clear();
    notifyListeners();
  }

  void removeEmpty() {
    _lines.removeWhere((element) => element?.points.length == 0);
  }
}
