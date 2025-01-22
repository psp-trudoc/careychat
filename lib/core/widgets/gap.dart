import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gap extends StatelessWidget {
  /// Creates a gap with the given dimensions.
  const Gap({
    this.height,
    this.width,
    super.key,
  });

  /// The height of the gap, in logical pixels.
  final double? height;

  /// The width of the gap, in logical pixels.
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
    );
  }
}
