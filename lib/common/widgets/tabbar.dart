import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/device/device_utility.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({
    super.key,
    required this.tabs,
  });
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? TColors.black : TColors.white,
      child: TabBar(
          isScrollable: true,
          unselectedLabelColor: TColors.darkGrey,
          indicatorColor: TColors.primary,
          labelColor: THelperFunctions.isDarkMode(context)
              ? TColors.white
              : TColors.black,
          tabs: tabs),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
