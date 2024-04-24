import 'package:app_stage/common/widgets/shimmers/shimmers.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => SizedBox(
                width: TSizes.spaceBtwItems,
              ),
          itemCount: itemCount,
          itemBuilder: (_, __) {
            return TShimmerEffect(
              width: 55,
              height: 40,
              radius: 50,
              color: TColors.white,
            );
          }),
    );
  }
}
