import 'package:app_stage/common/styles/shadows.dart';
import 'package:app_stage/common/widgets/texts/product_title.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: 180,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            boxShadow: [TShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: TColors.white,
          ),
          child: Column(
            children: [
              //thumbnail
              TRoundedContainer(
                height: 180,
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: TColors.light,
                child: Stack(children: [
                  //thumbnail image
                  TRoundedImage(imageUrl: TImages.productImage1),
                  //Sale tag
                  Positioned(
                    top: 3,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      child: Text(
                        "25%",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),

                  ///favorite icon button
                  const Positioned(
                      top: 0,
                      right: 3,
                      child: TCircularIcon(
                          icon: CupertinoIcons.heart,
                          color: Color.fromARGB(255, 252, 145, 154)))
                ]),
              ),
              SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),

              //details
              Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(
                        title: 'Green Nikes',
                        smallSizes: true,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        children: [
                          Text(
                            'Nike',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(color: TColors.darkGrey),
                          ),
                          const SizedBox(
                            width: TSizes.xs,
                          ),
                          Icon(
                            Icons.verified,
                            color: TColors.primary,
                            size: TSizes.iconXs,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///price
                          Text(
                            '\$35.5',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(color: TColors.darkerGrey),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: TColors.dark,
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(TSizes.cardRadiusMd),
                                    bottomRight: Radius.circular(
                                        TSizes.productImageRadius))),
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
                      )
                    ],
                  ))
            ],
          )),
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
            CupertinoIcons.heart,
            color: color,
            size: size,
          ),
        ));
  }
}
