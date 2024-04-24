import 'package:app_stage/common/widgets/shimmers/boxes_shimmer.dart';
import 'package:app_stage/features/shop/controllers/categoryController.dart';
import 'package:app_stage/features/shop/models/category_model.dart';
import 'package:app_stage/features/shop/screen/widgets/categories/horizental_card.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';

import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubCategory extends StatelessWidget {
  const SubCategory({
    super.key,
    required this.category,
  });
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return FutureBuilder(
        future: controller.getSubCategories(category.id),
        builder: (context, snapshot) {
          const loader = TBoxesShimmer();
          final widget = TCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;
          final subCategories = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: subCategories.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final subCategory = subCategories[index];
              return Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: FutureBuilder(
                    future: controller.getCategoryProducts(subCategory.id),
                    builder: (context, snapshot) {
                      final widget =
                          TCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot, loader: loader);
                      if (widget != null) return widget;
                      final products = snapshot.data!;
                      return Column(
                        children: [
                          //heading
                          TSectionHeading(
                            title: subCategory.name,
                            onPressed: () {},
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems / 2,
                          ),
                          SizedBox(
                            height: 120,
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: TSizes.spaceBtwItems,
                                    ),
                                itemCount: products.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) =>
                                    TProductCardHorizontal(
                                      product: products[index],
                                    ))),
                          )
                        ],
                      );
                    }),
              );
            },
          );
        });
  }
}
