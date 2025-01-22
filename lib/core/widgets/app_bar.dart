import 'package:carey/core/constants/config.dart';
import 'package:carey/core/constants/image_assets.dart';
import 'package:carey/core/constants/size.dart';
import 'package:carey/core/extensions/build_context.dart';
import 'package:carey/core/widgets/base_app_bar.dart';
import 'package:carey/core/widgets/gap.dart';
import 'package:carey/core/widgets/td_touchable.dart';
import 'package:carey/flavor/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CareyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CareyAppBar({
    super.key,
    this.trailing,
    this.isAppBarDividerVisible = true,
    this.title = "",
  });

  final Widget? trailing;
  final bool isAppBarDividerVisible;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TdAppBar(
      showAppBarDivider: isAppBarDividerVisible,
      showLeading: false,
      title: Row(
        children: [
          const LeadingIcon(),
          const Gap(
            width: 10,
          ),
          Text(
            F.title + " " + "$title",
            style: context.theme.textTheme.headlineSmall!
                .copyWith(fontSize: SizeUnit.size18),
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 1,
          ),
        ],
      ),
      actions: [trailing ?? const TrailingIcon(icon: navBack)],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + appbarDividerHeight);
}

class TrailingIcon extends StatelessWidget {
  final String? icon;
  final GestureTapCallback? onPressed;

  const TrailingIcon({super.key, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TdTouchable(
      onTap: onPressed ??
          () {
            print("s");
          },
      child: SvgPicture.asset(
        icon ?? navBack,
        width: 40,
        height: 40,
      ),
    );
  }
}

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      navBack,
      width: 20,
      height: 20,
    );
  }
}
