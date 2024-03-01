import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/common/widgets/custom_shapes/searchbar.dart';
import 'package:app_stage/common/widgets/tabbar.dart';
import 'package:app_stage/features/personalization/screen/cart.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/widgets/products/category_tab.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/enums.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(
              onPressed: () => Get.to(() => CartScreen()),
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
                      TGridLayout(
                          mainAxisExtent: 80,
                          itemCount: 4,
                          itemBuilder: (_, index) => TBrandCard())
                    ],
                  ),
                ),
                bottom: TTabBar(
                  tabs: [
                    Container(
                      width: 100,
                      child: Tab(
                        child: Text('Mode'),
                      ),
                    ),
                    Tab(
                      child: Text('Chaussures'),
                    ),
                    Tab(
                      child: Text('Sport'),
                    ),
                    Tab(
                      child: Text('Enfant'),
                    ),
                    Tab(
                      child: Text('Loisir'),
                    )
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
              children: [TCategoryTab(), TCategoryTab(), TCategoryTab()]),
        ),
      ),
    );
  }
}

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    this.showBorder = true,
    this.onTap,
  });
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(children: [
          Flexible(
            child: TCircularImage(
              image: TImages.clothIcon,
            ),
          ),
          const SizedBox(width: TSizes.spaceBtwItems / 2),
          //Text
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TVerifiedTitle(brandTextSize: TextSizes.medium, title: 'Nike'),
                Text(
                  '256 products',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    required this.image,
    this.padding = TSizes.sm,
    this.fit,
    this.isNetworkImage = false,
    this.onPressed,
    this.applyImageRadius = true,
    this.leaveOriginalColors = false,
  });
  final double padding;
  final double width, height;
  final String image;
  final BoxFit? fit;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final bool applyImageRadius;
  final bool leaveOriginalColors;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: THelperFunctions.isDarkMode(context)
              ? TColors.black
              : TColors.white,
          borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Image(
          fit: fit,
          image: isNetworkImage
              ? NetworkImage(image)
              : AssetImage(image) as ImageProvider,
          color: leaveOriginalColors
              ? null
              : THelperFunctions.isDarkMode(context)
                  ? TColors.white
                  : TColors.black,
        ),
      ),
    );
  }
}
