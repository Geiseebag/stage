import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TProductQuantityWithRemoverButton extends StatelessWidget {
  const TProductQuantityWithRemoverButton({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });
  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      TCircularIcon(
        onPressed: remove,
        icon: Iconsax.minus_copy,
        width: 32,
        height: 32,
        size: TSizes.md,
        color: THelperFunctions.isDarkMode(context)
            ? TColors.white
            : TColors.black,
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkerGrey
            : TColors.light,
      ), //TCircularIcon
      const SizedBox(width: TSizes.spaceBtwItems),
      Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
      const SizedBox(width: TSizes.spaceBtwItems),
      TCircularIcon(
        onPressed: add,
        icon: Iconsax.add_copy,
        width: 32,
        height: 32,
        size: TSizes.md,
        color: TColors.white,
        backgroundColor: TColors.primary,
      ), //TCircularIcon
// Row
    ]);
  }
}
