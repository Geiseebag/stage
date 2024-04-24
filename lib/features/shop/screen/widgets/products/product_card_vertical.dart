import 'package:app_stage/common/styles/shadows.dart';
import 'package:app_stage/common/widgets/texts/product_title.dart';
import 'package:app_stage/features/shop/controllers/product_controller.dart';
import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/product_details.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/enums.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical(
      {Key? key, this.favourite = false, required this.product});
  final bool favourite;
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
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Added
                children: [
                  //thumbnail
                  TRoundedContainer(
                    height: 180,
                    width: 180,
                    padding: const EdgeInsets.all(TSizes.sm),
                    backgroundColor: dark ? TColors.dark : TColors.light,
                    child: Stack(
                      children: [
                        //thumbnail image
                        Center(
                          child: TRoundedImage(
                            imageUrl: product.thumbnail,
                            applyImageRadius: true,
                          ),
                        ),

                        //Sale tag
                        salePercentage != null
                            ? Positioned(
                                top: 3,
                                child: TRoundedContainer(
                                  radius: TSizes.sm,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: TSizes.sm,
                                    vertical: TSizes.xs,
                                  ),
                                  backgroundColor:
                                      TColors.secondary.withOpacity(0.8),
                                  child: Text(
                                    "$salePercentage%",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .apply(color: TColors.black),
                                  ),
                                ),
                              )
                            : Container(),
                        //favorite icon button
                        Positioned(
                          top: 0,
                          right: 0,
                          child: TCircularIcon(
                            backgroundColor: dark
                                ? TColors.black.withOpacity(0.7)
                                : TColors.white.withOpacity(0.7),
                            icon: favourite
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            color: Color.fromARGB(255, 252, 145, 154),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems / 2),

                  //details
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TProductTitleText(
                          title: product.title,
                          smallSizes: true,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems / 2),
                        TVerifiedTitle(
                          title: product.brand!.name,
                          textColor:
                              dark ? TColors.darkGrey : TColors.darkerGrey,
                        ),
                      ],
                    ),
                  ),

                  //price row
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
                                padding: const EdgeInsets.only(left: TSizes.sm),
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
                              padding: const EdgeInsets.only(left: TSizes.sm),
                              child: Text(
                                controller.getProductPrice(product) + "€",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
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
            ),
          ],
        ),
      ),
    );
  }
}

class TVerifiedTitle extends StatelessWidget {
  const TVerifiedTitle({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = TColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });
  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: TBrandTitleText(
          title: title,
          color: textColor,
          maxLines: maxLines,
          textAlign: textAlign,
          brandTextSize: brandTextSize,
        )),
        const SizedBox(
          width: TSizes.xs,
        ),
        Icon(Icons.verified, color: iconColor, size: TSizes.iconXs)
      ],
    );
  }
}

class TBrandTitleText extends StatelessWidget {
  const TBrandTitleText(
      {super.key,
      this.color,
      required this.title,
      this.maxLines = 1,
      this.textAlign = TextAlign.center,
      this.brandTextSize = TextSizes.small});

  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: brandTextSize == TextSizes.small
          ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
          : brandTextSize == TextSizes.medium
              ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
              : brandTextSize == TextSizes.large
                  ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
                  : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
    );
  }
}

class TCircularIcon extends StatelessWidget {
  const TCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = TSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });
  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor != null
              ? backgroundColor!
              : TColors.white.withOpacity(0.9),
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            color: color,
            size: size,
          ),
        ));
  }
}
