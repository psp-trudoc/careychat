import 'dart:io';

import 'package:flutter/material.dart';

Widget buildButtonLoader([Color? color]) {
  return SizedBox(
    width: 20, // Set your desired width
    height: 20, // Set your desired height
    child: CircularProgressIndicator.adaptive(
      strokeWidth: 2,
      valueColor: color != null
          ? AlwaysStoppedAnimation<Color>(color)
          : const AlwaysStoppedAnimation<Color>(Colors.white),
      backgroundColor: Platform.isIOS ? color ?? Colors.white : null,
    ),
  );
}
