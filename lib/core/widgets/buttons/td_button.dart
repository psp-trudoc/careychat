import 'package:carey/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TdButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String icon;

  const TdButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width:  44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.orderPlacedBg, // Orange color
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              icon,
              colorFilter:
                  ColorFilter.mode(context.colors.white, BlendMode.srcIn),
            ),
          )
          ),
    );
  }
}
