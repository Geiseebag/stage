import 'package:app_stage/common/widgets/custom_shapes/choice_chip.dart';
import 'package:app_stage/common/widgets/texts/product_title.dart';
import 'package:app_stage/features/shop/controllers/variation_controller.dart';
import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/product_details.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Obx(() {
          if (controller.selectedVariation.value.price > 0)
            return TRoundedContainer(
              padding: EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title, price and stock status
                  Row(
                    children: [
                      TSectionHeading(
                        title: 'Variation',
                        showActionButton: false,
                      ),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TProductTitleText(
                                title: 'Price:  ',
                                smallSizes: true,
                              ),
                              //old Price
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                TProductPriceText(
                                  price:
                                      '${controller.selectedVariation.value.price}',
                                  lineThrough: true,
                                ),
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                SizedBox(
                                  width: TSizes.spaceBtwItems,
                                ),

                              //actual price
                              TProductPriceText(
                                price: controller.getVariationPrice(),
                                isBold: true,
                              )
                            ],
                          ),

                          //stock

                          Row(
                            children: [
                              TProductTitleText(
                                title: 'Stock:  ',
                                smallSizes: true,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  TProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSizes: true,
                    maxLines: 4,
                  )
                ],
              ),
            );
          else {
            return Container();
          }
        }),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: product.productAttributes!
              .map((attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                        title: attribute.name ?? '',
                        showActionButton: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Obx(
                          () => Wrap(
                              spacing: 16,
                              children: attribute.values!.map((value) {
                                final isSelected = controller
                                        .selectedAttributes[attribute.name] ==
                                    value;
                                final available = controller
                                    .getAttributesAvailabilityInVariation(
                                        product.productVariations!,
                                        attribute.name!)
                                    .contains(value);

                                return TChoiceChip(
                                  text: value,
                                  selected: isSelected,
                                  onSelected: available
                                      ? (selected) {
                                          if (selected && available) {
                                            controller.onAttributeSelected(
                                                product,
                                                attribute.name ?? "",
                                                value);
                                          }
                                        }
                                      : null,
                                );
                              }).toList()),
                        ),
                      ),
                    ],
                  ))
              .toList(),
        )

        //Attributes
      ],
    );
  }
}
