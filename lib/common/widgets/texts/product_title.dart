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
          ? Theme.of(context).textTheme.bodyLarge
          : Theme.of(context).textTheme.titleSmall,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
