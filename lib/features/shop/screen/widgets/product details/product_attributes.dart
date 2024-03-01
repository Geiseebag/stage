import 'package:app_stage/common/widgets/custom_shapes/choice_chip.dart';
import 'package:app_stage/common/widgets/texts/product_title.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/product_details.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TRoundedContainer(
          padding: EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
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
                            title: 'Price: ',
                            smallSizes: true,
                          ),
                          //actual price
                          TProductPriceText(
                            price: '250',
                            lineThrough: true,
                          ),
                          SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          TProductPriceText(
                            price: '175',
                            isBold: true,
                          )
                        ],
                      ),

                      //stock

                      Row(
                        children: [
                          TProductTitleText(
                            title: 'Stock: ',
                            smallSizes: true,
                          ),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              TProductTitleText(
                title:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin nibh augue, sollicitudin a eleifend et, dictum eget dolor.',
                smallSizes: true,
                maxLines: 4,
              )
            ],
          ),
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //Attributes

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(title: 'Colors'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                children: [
                  TChoiceChip(
                    text: 'Green',
                    selected: true,
                    onSelected: (value) {},
                  ),
                  TChoiceChip(
                      text: 'Blue', selected: false, onSelected: (value) {}),
                  TChoiceChip(
                      text: 'Yellow', selected: false, onSelected: (value) {})
                ],
              ),
            ),
            TSectionHeading(title: 'Size'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                children: [
                  TChoiceChip(
                    text: 'EU 40',
                    selected: true,
                    onSelected: (value) {},
                  ),
                  TChoiceChip(
                      text: 'EU 39', selected: false, onSelected: (value) {}),
                  TChoiceChip(
                      text: 'EU 38', selected: false, onSelected: (value) {})
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
