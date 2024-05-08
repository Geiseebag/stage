import 'package:app_stage/common/widgets/texts/product_title.dart';
import 'package:app_stage/features/shop/models/cart_item_model.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    Key? key,
    required this.cartItem,
  }) : super(key: key);
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        TRoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          padding: EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkGrey
              : TColors.light,
        ),

        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),

        /// Title, Price, & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TVerifiedTitle(title: cartItem.brandName ?? ''),
              Flexible(
                  child: TProductTitleText(title: cartItem.title, maxLines: 1)),

              /// Attributes
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {})
                      .entries
                      .map((e) => TextSpan(
                            children: [
                              TextSpan(
                                text: ' ${e.key} ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: '${e.value}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
