import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TSearchBar extends StatelessWidget {
  const TSearchBar(
      {super.key,
      this.padding = TSizes.defaultSpace,
      required this.text,
      this.icon = CupertinoIcons.search,
      required this.backgroundOpacity,
      this.showBorder = true,
      this.borderColor = TColors.white});
  final String text;
  final IconData? icon;
  final double backgroundOpacity;
  final bool showBorder;
  final Color borderColor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        width: TDeviceUtils.getScreenWidth(context),
        padding: EdgeInsets.all(TSizes.sm + 3),
        decoration: BoxDecoration(
            color: TColors.grey.withOpacity(backgroundOpacity),
            borderRadius: BorderRadius.circular(50),
            border: showBorder ? Border.all(color: borderColor) : null),
        child: Row(
          children: [
            Icon(
              icon,
              color: TColors.darkerGrey,
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: TColors.darkerGrey, // Set the text color to black
                  ),
            )
          ],
        ),
      ),
    );
  }
}
