import 'package:flutter/material.dart';
import 'package:carey/core/widgets/pip/flutter_in_app_pip.dart';

class PiPParams {
  final double bottomSpace;
  final double leftSpace;
  final double rightSpace;
  final double topSpace;
  final double pipWindowWidth;
  final double pipWindowHeight;
  final PIPViewCorner initialCorner;
  final bool resizable;
  final bool movable;
  final Size minSize;
  final Size maxSize;
  const PiPParams({
    this.bottomSpace = 16,
    this.leftSpace = 16,
    this.rightSpace = 16,
    this.topSpace = 16,
    this.pipWindowWidth = 350,
    this.pipWindowHeight = 250,
    this.initialCorner = PIPViewCorner.bottomRight,
    this.resizable = false,
    this.movable = true,
    this.minSize = const Size(200, 100),
    this.maxSize = const Size(350, 250),
  });
}
