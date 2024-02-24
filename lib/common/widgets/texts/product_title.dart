import 'package:app_stage/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TProductTitleText extends StatelessWidget {
  const TProductTitleText(
      {super.key,
      required this.title,
      this.smallSizes = false,
      this.maxLines = 2,
      this.textAlign = TextAlign.left});
  final String title;
  final bool smallSizes;
  final int maxLines;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSizes
          ? Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black)
          : Theme.of(context).textTheme.titleSmall!.apply(color: TColors.black),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
