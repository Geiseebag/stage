import 'package:app_stage/features/shop/models/brand_model.dart';
import 'package:app_stage/features/shop/screen/brand_products.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/store.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({
    super.key,
    required this.images,
    required this.brand,
  });
  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.md),
        showBorder: true,
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(children: [
          TBrandCard(
            brand: brand,
            showBorder: false,
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
              children: images
                  .map((image) => brandTopProductImage(image, context))
                  .toList())
        ]),
      ),
    );
  }

  Widget brandTopProductImage(String image, context) {
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkerGrey.withOpacity(0.5)
            : TColors.light.withOpacity(0.7),
        margin: const EdgeInsets.only(right: TSizes.sm),
        padding: const EdgeInsets.all(TSizes.sm),
        child: Image(
          fit: BoxFit.contain,
          image: AssetImage(image),
        ),
      ),
    );
  }
}
