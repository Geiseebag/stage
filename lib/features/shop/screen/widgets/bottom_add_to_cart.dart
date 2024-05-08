import 'package:app_stage/features/shop/controllers/cart_controller.dart';
import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
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
          Obx(
            () => Row(children: [
              TCircularIcon(
                onPressed: () => controller.productQuantityInCart.value < 1
                    ? null
                    : controller.productQuantityInCart.value -= 1,
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
                controller.productQuantityInCart.value.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              TCircularIcon(
                onPressed: () => controller.productQuantityInCart.value += 1,
                icon: Iconsax.add_copy,
                width: 40,
                height: 40,
                color: TColors.white,
                backgroundColor: TColors.black,
              ),
            ]),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.addToCart(product),
              child: Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
