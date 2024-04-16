import 'package:app_stage/common/brand_showcase.dart';
import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';

import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //brands
            TBrandShowcase(
              images: [
                TImages.productImage1,
                TImages.productImage2,
                TImages.productImage3
              ],
            ),
            TBrandShowcase(
              images: [
                TImages.productImage4,
                TImages.productImage5,
                TImages.productImage6,
                TImages.productImage7,
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            //products
            TSectionHeading(
              title: "You might like",
              showActionButton: true,
              onPressed: () {},
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TGridLayout(
                itemCount: 4,
                itemBuilder: (_, index) => TProductCardVertical(
                      product: ProductModel.empty(),
                    )),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
          ],
        ),
      ),
    ]);
  }
}
