import 'package:app_stage/common/widgets/shimmers/shimmers.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TverticalProductShimmer extends StatelessWidget {
  const TverticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return TGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => SizedBox(
              width: 188,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TShimmerEffect(width: 180, height: 188),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TShimmerEffect(width: 168, height: 15),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TShimmerEffect(width: 110, height: 15),
                ],
              ),
            ));
  }
}
