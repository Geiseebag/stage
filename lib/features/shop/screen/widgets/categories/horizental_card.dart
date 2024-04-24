import 'package:app_stage/common/widgets/texts/product_title.dart';
import 'package:app_stage/features/shop/controllers/product_controller.dart';
import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/product_details.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/enums.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({Key? key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(
            product: product,
          )),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.lightContainer,
        ),
        child: Row(
          children: [
            //thumbnail
            TRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.white,
              child: Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Center(
                      child: TRoundedImage(
                        imageUrl: product.thumbnail,
                        applyImageRadius: true,
                      ),
                    ),
                  ),
                  //sale tag
                  if (product.salePrice > 0)
                    Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, // Changed from smw to sm
                          vertical: TSizes.xs,
                        ),
                        child: Text(
                          '${salePercentage}%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black),
                        ),
                      ),
                    ),
                  const Positioned(
                      top: 0,
                      right: 0,
                      child: TCircularIcon(
                        icon: CupertinoIcons.heart,
                        color: TColors.primary,
                      ))
                ],
              ),
            ),
            SizedBox(
                width: 172,
                child: Padding(
                  padding: EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TProductTitleText(
                            title: product.title,
                            smallSizes:
                                true, // Changed from smallSizes to smallSize
                          ),
                          SizedBox(height: TSizes.spaceBtwItems / 2),
                          TVerifiedTitle(title: product.brand!.name),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //price
                          Flexible(
                            child: Column(
                              children: [
                                if (product.productType ==
                                        ProductType.single.toString() &&
                                    product.salePrice > 0)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: TSizes.sm),
                                    child: Text(
                                      product.price.toString() + "€",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .apply(
                                              decoration:
                                                  TextDecoration.lineThrough),
                                    ),
                                  ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: TSizes.sm),
                                  child: Text(
                                    controller.getProductPrice(product) + "€",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: TColors.dark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(TSizes.cardRadiusMd),
                                bottomRight:
                                    Radius.circular(TSizes.productImageRadius),
                              ),
                            ),
                            child: const SizedBox(
                              width: TSizes.iconLg * 1.2,
                              height: TSizes.iconLg * 1.2,
                              child: Center(
                                child: Icon(
                                  CupertinoIcons.add,
                                  color: TColors.white,
                                  size: 19,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
