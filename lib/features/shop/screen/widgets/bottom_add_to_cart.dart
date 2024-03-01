import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? TColors.darkerGrey : TColors.light,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(TSizes.cardRadiusLg),
              topLeft: Radius.circular(TSizes.cardRadiusLg))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            TCircularIcon(
              icon: Iconsax.minus_copy,
              width: 40,
              height: 40,
              color: TColors.white,
              backgroundColor: TColors.darkGrey,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              '2',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            TCircularIcon(
              icon: Iconsax.add_copy,
              width: 40,
              height: 40,
              color: TColors.white,
              backgroundColor: TColors.primary,
            ),
          ]),
          ElevatedButton(
            onPressed: () {},
            child: Text('Add to Cart'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(20),
            ),
          )
        ],
      ),
    );
  }
}
