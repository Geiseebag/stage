import 'package:app_stage/common/widgets/shimmers/boxes_shimmer.dart';
import 'package:app_stage/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:app_stage/features/shop/controllers/categoryController.dart';
import 'package:app_stage/features/shop/models/category_model.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/widgets/categories/horizental_card.dart';
import 'package:app_stage/features/shop/screen/widgets/categories/subcategory.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/features/shop/screen/widgets/store/category_brands.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';

import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category,
  });
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(shrinkWrap: true, children: [
      Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //brands
            CategoryBrands(category: category),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            //sub categories
            SubCategory(
              category: category,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            //products
            FutureBuilder(
                future: controller.getCategoryProducts(category.id),
                builder: (context, snapshot) {
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: const TverticalProductShimmer());
                  if (widget != null) return widget;
                  final products = snapshot.data!;
                  return Column(
                    children: [
                      TSectionHeading(
                        title: "You might like",
                        showActionButton: true,
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TGridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) => TProductCardVertical(
                                product: products[index],
                              )),
                    ],
                  );
                }),

            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
          ],
        ),
      ),
    ]);
  }
}
