import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/common/widgets/custom_shapes/searchbar.dart';
import 'package:app_stage/common/widgets/shimmers/shimmers.dart';
import 'package:app_stage/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:app_stage/features/personalization/controllers/user_controller.dart';
import 'package:app_stage/features/personalization/screen/cart.dart';
import 'package:app_stage/features/shop/controllers/HomeController.dart';
import 'package:app_stage/features/shop/controllers/banner_controller.dart';
import 'package:app_stage/features/shop/controllers/product_controller.dart';
import 'package:app_stage/features/shop/screen/widgets/categories/categories.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          FirstSection(
            child: SingleChildScrollView(
              child: Column(children: [
                // appbar
                HomeAppBar(),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                // searchbar
                TSearchBar(
                  text: 'Search in Store',
                  backgroundOpacity: 0.8,
                  showBorder: true,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //categories
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                  child: HomeCategories(),
                )
              ]),
            ),
          ),
          SecondWidget(),
        ],
      ),
    );
  }
}

class CategoryIcons extends StatelessWidget {
  const CategoryIcons({
    super.key,
    required this.name,
    this.backgroundOpacity = 0.8,
    this.onTap,
  });
  final String name;
  final double backgroundOpacity;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: TSizes.md, vertical: TSizes.sm),
                decoration: BoxDecoration(
                    color: TColors.grey.withOpacity(backgroundOpacity),
                    border: Border.all(color: TColors.white),
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color:
                              TColors.darkerGrey, // Set the text color to black
                        ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          TTexts.homeAppbarTitle,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: TColors.lightGrey),
        ),
        Obx(
          () => Text(
            controller.user.value.fullName,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: TColors.white),
          ),
        )
      ]),
      actions: [
        TCartCounterIcon(
          onPressed: () => Get.to(() => const CartScreen()),
          iconColor: TColors.white,
        )
      ],
    );
  }
}

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
  });

  final VoidCallback onPressed;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Stack(children: [
      IconButton(
          onPressed: onPressed,
          icon: Icon(
            Iconsax.shopping_cart_copy,
            color: iconColor == null
                ? dark
                    ? TColors.white
                    : TColors.black
                : iconColor,
          )),
      Positioned(
          top: 0,
          right: 0,
          child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                  color: dark
                      ? TColors.white.withOpacity(0.7)
                      : TColors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Text(
                  "2",
                  style: dark
                      ? Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .apply(color: TColors.black)
                      : Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .apply(color: TColors.white),
                ),
              )))
    ]);
  }
}

class SecondWidget extends StatelessWidget {
  const SecondWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    final dark = THelperFunctions.isDarkMode(context);
    return SliverToBoxAdapter(
      child: Container(
        color: dark ? TColors.dark : TColors.white,
        child: Stack(
          children: [
            Positioned(
              left: TSizes.defaultSpace, // Adjust the left position as needed
              top: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Special Offers",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Text("Explore our exclusive deals",
                        style: Theme.of(context).textTheme.titleMedium),
                  ]),
            ),
            Column(
              children: [
                const SizedBox(
                  height: TSizes.spaceBtwSections * 1.5,
                ),
                Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: TPromoSlider()),
                Obx(
                  () {
                    if (controller.isLoading.value)
                      return TverticalProductShimmer();
                    if (controller.featuredProducts.isEmpty)
                      return Center(
                        child: Text(
                          'No Data Found',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: Colors.white),
                        ),
                      );
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.spaceBtwItems),
                      child: TGridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (_, index) => TProductCardVertical(
                          product: controller.featuredProducts[index],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TGridLayout extends StatelessWidget {
  const TGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 288,
    required this.itemBuilder,
  });
  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: TSizes.gridViewSpacing,
            crossAxisSpacing: TSizes.gridViewSpacing,
            mainAxisExtent: mainAxisExtent),
        itemBuilder: itemBuilder);
  }
}

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      if (controller.isLoading.value) {
        return const TShimmerEffect(width: double.infinity, height: 190);
      }
      if (controller.banners.isEmpty) {
        return const Center(
          child: Text('No Data Found!'),
        );
      } else {
        return Column(children: [
          CarouselSlider(
              items: controller.banners
                  .map(
                    (banner) => Padding(
                      padding:
                          const EdgeInsets.only(right: TSizes.spaceBtwItems),
                      child: TRoundedImage(
                        imageUrl: banner.imageUrl,
                        onPressed: () => Get.toNamed(banner.targetScreen),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  viewportFraction: 0.8,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index))),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Center(
            child: Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    TCircularContainer(
                      margin: const EdgeInsets.only(right: 10),
                      width:
                          controller.carousalCurrentIndex.value == i ? 30 : 15,
                      height: 4,
                      backgroundColor:
                          controller.carousalCurrentIndex.value == i
                              ? Color.fromARGB(255, 252, 145, 154)
                              : TColors.grey,
                    ),
                ],
              ),
            ),
          )
        ]);
      }
    });
  }
}

class TCircularContainer extends StatelessWidget {
  const TCircularContainer(
      {super.key,
      this.width = 400,
      this.height = 400,
      this.radius = 400,
      this.backgroundColor = TColors.white,
      this.padding = 0,
      this.margin,
      this.child});
  final double? width, height;
  final double radius;
  final Color backgroundColor;
  final double padding;
  final EdgeInsets? margin;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: backgroundColor),
      child: child,
    );
  }
}

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer(
      {super.key,
      this.width,
      this.height,
      this.radius = TSizes.cardRadiusLg,
      this.backgroundColor = TColors.white,
      this.padding,
      this.margin,
      this.child,
      this.borderColor = TColors.borderPrimary,
      this.showBorder = false});
  final double? width, height;
  final double radius;
  final Color backgroundColor, borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
          border: showBorder ? Border.all(color: borderColor) : null),
      child: child,
    );
  }
}

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.padding,
    this.width,
    this.height,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.isNetworkImage = false,
    this.onPressed,
    this.applyImageRadius = true,
    this.borderRadius = TSizes.md,
    this.border,
    this.backgroundColor,
  });
  final double? width, height;
  final String imageUrl;
  final BoxFit? fit;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final bool applyImageRadius;
  final double borderRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(TSizes.md),
          border: border,
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
            fit: fit,
            image: isNetworkImage
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl) as ImageProvider,
          ),
        ),
      ),
    );
  }
}

class FirstSection extends StatelessWidget {
  const FirstSection({
    super.key,
    required this.child,
  });
  final child;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return SliverAppBar(
      pinned: true,
      floating: true,
      automaticallyImplyLeading: false,
      expandedHeight: 400.0, // adjust as needed
      flexibleSpace: Stack(
        children: [
          Positioned(
            top: 0,
            width: THelperFunctions.screenWidth() + 20,
            child: dark
                ? Image.asset(
                    "assets/images/banners/Untitled.jpeg",
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/images/banners/istockphoto-1317931909-1024x1024 (1).jpg",
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: dark
                      ? [
                          TColors.dark.withOpacity(0.0),
                          TColors.dark,
                        ]
                      : [
                          Colors.white.withOpacity(0.0),
                          Colors.white,
                        ],
                  stops: [0.8, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
