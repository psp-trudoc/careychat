import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TdTouchable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double radius;
  final Color? androidHighlightColor;
  final double? iOSminSize;

  const TdTouchable({
    super.key,
    required this.child,
    required this.onTap,
    this.radius = 0.0,
    this.androidHighlightColor,
    this.iOSminSize,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
        minSize: iOSminSize ?? kMinInteractiveDimensionCupertino,
        onPressed: onTap,
        padding: EdgeInsets.zero,
        child: child,
      );
    }
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      highlightColor: androidHighlightColor,
      onTap: onTap,
      child: child,
    );
  }
}
