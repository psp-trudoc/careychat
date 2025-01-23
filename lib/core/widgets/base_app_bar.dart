import 'package:auto_route/auto_route.dart';
import 'package:carey/core/constants/config.dart';
import 'package:carey/core/theme/app_colors.dart';
import 'package:carey/core/theme/app_text_theme.dart';
import 'package:carey/core/widgets/gap.dart';
import 'package:flutter/material.dart';

class TdAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeading;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool? centerTitle;
  final double? elevation;
  final IconThemeData? iconTheme;
  final Color? surfaceTintColor;
  final bool showAppBarDivider;

  const TdAppBar({
    super.key,
    this.title,
    this.leading = const AutoLeadingButton(),
    this.actions,
    this.backgroundColor,
    this.centerTitle,
    this.elevation,
    this.iconTheme,
    this.surfaceTintColor,
    this.showLeading = true,
    this.showAppBarDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final appBarActions = (actions != null && actions!.isNotEmpty)
        ? [...actions!, const Gap(width: 8)]
        : null;
    return Column(
      children: [
        AppBar(
          leading: showLeading ? leading : null,
          actions: appBarActions,
          backgroundColor: backgroundColor,
          scrolledUnderElevation: 0.0,
          title: title,
          centerTitle: centerTitle,
          elevation: elevation,
          iconTheme: iconTheme,
          automaticallyImplyLeading: false,  // Hides the back button
        ),
        if (showAppBarDivider)
          Container(
            height: appbarDividerHeight,
            color: context.colors.appbarDividerColor,
          )
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + appbarDividerHeight);
}
