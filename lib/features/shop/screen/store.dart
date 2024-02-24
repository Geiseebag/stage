import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/common/widgets/custom_shapes/searchbar.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Store",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCartCounterIcon(
            onPressed: () {},
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrollable) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: THelperFunctions.isDarkMode(context)
                  ? TColors.black
                  : TColors.white,
              expandedHeight: 440,
              flexibleSpace: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    //searchbar
                    SizedBox(
                      height: TSizes.spaceBtwItems - 8,
                    ),
                    TSearchBar(
                        padding: 0,
                        text: "Search in Store",
                        backgroundOpacity: 0.8,
                        borderColor: dark ? TColors.white : TColors.darkGrey),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    //featured brands
                    TSectionHeading(
                      title: "Featured Brands",
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems / 1.5,
                    ),
                    TRoundedContainer(
                      padding: const EdgeInsets.all(TSizes.sm),
                      showBorder: true,
                      backgroundColor: Colors.transparent,
                      child: Row(children: [
                        Container(
                          width: 56,
                          height: 56,
                          padding: const EdgeInsets.all(TSizes.sm),
                          decoration: BoxDecoration(
                              color: THelperFunctions.isDarkMode(context)
                                  ? TColors.black
                                  : TColors.white),
                          child: Image(
                            image: AssetImage(TImages.clothIcon),
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: Container(),
      ),
    );
  }
}
