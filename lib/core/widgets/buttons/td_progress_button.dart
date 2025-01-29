import 'package:carey/core/theme/app_colors.dart';
import 'package:carey/core/widgets/buttons/button_loader.dart';
import 'package:flutter/material.dart';

class TdProgressButton extends StatefulWidget {
  final Future<void> Function() onPressed;
  final bool isLoading;
  final double size;
  final IconData icon;

  const TdProgressButton(
      {super.key,
      required this.onPressed,
      this.isLoading = false,
      this.size = 60.0,
      required this.icon});

  @override
  TdProgressButtonState createState() => TdProgressButtonState();
}

class TdProgressButtonState extends State<TdProgressButton> {
  void _handlePress() async {
    if (widget.isLoading) return;

    try {
      await widget.onPressed();
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handlePress,
      child: Container(
        width: widget.size - 14,
        height: widget.size - 14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor().orderPlacedBg, // Orange color
        ),
        child: widget.isLoading
            ? Center(
                child: SizedBox(
                    height: 22,
                    width: 22,
                    child: buildButtonLoader(Colors.white)),
              )
            : Icon(
                widget.icon,
                color: Colors.white,
                size: 30.0,
              ),
      ),
    );
  }
}
