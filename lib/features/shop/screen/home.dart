import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/common/widgets/custom_shapes/searchbar.dart';
import 'package:app_stage/features/shop/controllers/HomeController.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
                  child: SizedBox(
                    height: 70,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return CategoryIcons(
                            name: 'Mode',
                            backgroundOpacity: 0.8,
                          );
                        }),
                  ),
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
    return TAppBar(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          TTexts.homeAppbarTitle,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: TColors.lightGrey),
        ),
        Text(
          TTexts.homeAppbarSubTitle,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.white),
        )
      ]),
      // Ensure back arrow is hidden
      actions: [
        TCartCounterIcon(
          onPressed: () {},
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
            CupertinoIcons.shopping_cart,
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
    return SliverToBoxAdapter(
      child: Container(
        color: TColors.white,
        child: Stack(
          children: [
            Positioned(
              left: TSizes.defaultSpace, // Adjust the left position as needed
              top: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Special Offers",
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
                            color: TColors.darkerGrey,
                          ),
                    ),
                    Text(
                      "Explore our exclusive deals",
                      style: Theme.of(context).textTheme.subtitle1!.apply(
                            color: TColors.darkerGrey,
                          ),
                    ),
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
                GridView.builder(
                    itemCount: 6,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: TSizes.gridViewSpacing,
                        crossAxisSpacing: TSizes.gridViewSpacing,
                        mainAxisExtent: 288),
                    itemBuilder: (_, index) => TProductCardVertical()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(children: [
      CarouselSlider(
          items: [
            TRoundedImage(
                imageUrl: TImages.promoBanner1,
                padding:
                    EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems / 2)),
            TRoundedImage(
                imageUrl: TImages.promoBanner2,
                padding:
                    EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems / 2)),
            TRoundedImage(
                imageUrl: TImages.promoBanner3,
                padding:
                    EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems / 2))
          ],
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
              for (int i = 0; i < 3; i++)
                TCircularContainer(
                  margin: const EdgeInsets.only(right: 10),
                  width: 20,
                  height: 4,
                  backgroundColor: controller.carousalCurrentIndex.value == i
                      ? Color.fromARGB(255, 252, 145, 154)
                      : TColors.grey,
                ),
            ],
          ),
        ),
      )
    ]);
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
    this.fit,
    this.isNetworkImage = false,
    this.onPressed,
    this.applyImageRadius = true,
  });
  final double? width, height;
  final String imageUrl;
  final BoxFit? fit;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final bool applyImageRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.md),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(TSizes.md)
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
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 400.0, // adjust as needed
      flexibleSpace: Stack(
        children: [
          Positioned(
            top: 0,
            width: THelperFunctions.screenWidth() + 20,
            child: Image.asset(
              "assets/images/banners/istockphoto-1317931909-1024x1024 (1).jpg",
              fit: BoxFit.cover,
            ),
          ),
          child,
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
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
        ],
      ),
    );
  }
}
