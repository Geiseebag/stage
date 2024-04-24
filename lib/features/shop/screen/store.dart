import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/common/widgets/custom_shapes/searchbar.dart';
import 'package:app_stage/common/widgets/shimmers/brands_shimmer.dart';
import 'package:app_stage/common/widgets/tabbar.dart';
import 'package:app_stage/features/personalization/screen/cart.dart';
import 'package:app_stage/features/shop/controllers/brand_controller.dart';
import 'package:app_stage/features/shop/controllers/categoryController.dart';
import 'package:app_stage/features/shop/models/brand_model.dart';
import 'package:app_stage/features/shop/screen/brand_products.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/widgets/products/category_tab.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/enums.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen({super.key, this.initialIndex = 0}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToTabBar());
  }
  final int initialIndex;
  final ScrollController scrollController = ScrollController();
  void scrollToTabBar() {
    // You may need to adjust the offset value to match the position of your tab bar
    final double tabBarOffset = 400; // Example offset, adjust as needed
    if (scrollController.hasClients) {
      scrollController.animateTo(
        tabBarOffset,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.parentCategories;
    final brandController = Get.put(BrandController());

    final dark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: categories.length,
      initialIndex: initialIndex,
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
          controller: scrollController,
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
                      Obx(() {
                        if (brandController.isLoading == true)
                          return const TBrandsShimmer();
                        if (brandController.featuredBrands.isEmpty) {
                          return Center(
                            child: Text(
                              'No Data Found',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: Colors.white),
                            ),
                          );
                        }
                        return TGridLayout(
                            mainAxisExtent: 80,
                            itemCount: brandController.featuredBrands.length,
                            itemBuilder: (_, index) {
                              final brand =
                                  brandController.featuredBrands[index];
                              return TBrandCard(
                                brand: brand,
                                onTap: () =>
                                    Get.to(() => BrandProducts(brand: brand)),
                              );
                            });
                      })
                    ],
                  ),
                ),
                bottom: TTabBar(
                    tabs: categories
                        .map((category) => Tab(
                              child: Text(category.name),
                            ))
                        .toList()),
              ),
            ];
          },
          body: TabBarView(
              children: categories
                  .map((category) => TCategoryTab(
                        category: category,
                      ))
                  .toList()),
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
    required this.brand,
  });
  final BrandModel brand;
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
              image: brand.image,
            ),
          ),
          const SizedBox(width: TSizes.spaceBtwItems / 2),
          //Text
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TVerifiedTitle(
                    brandTextSize: TextSizes.medium, title: brand.name),
                Text(
                  '${brand.productsCount ?? 0} products',
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: fit,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
              : Image(
                  fit: fit,
                  image: AssetImage(image) as ImageProvider,
                  color: leaveOriginalColors
                      ? null
                      : THelperFunctions.isDarkMode(context)
                          ? TColors.white
                          : TColors.black,
                ),
        ),
      ),
    );
  }
}
