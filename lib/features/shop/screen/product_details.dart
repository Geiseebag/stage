import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:app_stage/common/widgets/texts/product_title.dart';
import 'package:app_stage/features/shop/controllers/images_controller.dart';
import 'package:app_stage/features/shop/controllers/product_controller.dart';
import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/product_reviews.dart';
import 'package:app_stage/features/shop/screen/widgets/bottom_add_to_cart.dart';
import 'package:app_stage/features/shop/screen/widgets/product%20details/product_attributes.dart';
import 'package:app_stage/features/shop/screen/widgets/products/favourite_icon.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/enums.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(
        product: product,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Product image slider
            TProductImageSlider(
              product: product,
            ),

            //Product Details
            Padding(
              padding: EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  //rating
                  TRating(),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  //price,title & brand
                  TProductMetaData(
                    product: product,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  //attributes
                  if (product.productType == ProductType.variable.toString())
                    TProductAttributes(
                      product: product,
                    ),
                  if (product.productType == ProductType.variable.toString())
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                  //description

                  TSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show More',
                    trimExpandedText: ' Show Less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //reviews

                  Divider(),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TSectionHeading(
                        title: "Review(199)",
                        onPressed: () {},
                        showActionButton: false,
                      ),
                      IconButton(
                          onPressed: () => Get.to(() => ProductReviewsScreen()),
                          icon: const Icon(Iconsax.arrow_right_3_copy))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //price  & sale tag
        Row(
          children: [
            if (salePercentage != null)
              //sale tag
              TRoundedContainer(
                radius: TSizes.sm,
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm,
                  vertical: TSizes.xs,
                ),
                backgroundColor: TColors.secondary.withOpacity(0.8),
                child: Text(
                  "$salePercentage%",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.black),
                ),
              ),
            if (salePercentage != null)
              SizedBox(
                width: TSizes.defaultSpace,
              ),
            //price
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              TProductPriceText(
                price: '${product.price}',
                lineThrough: true,
              ),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
            TProductPriceText(
              price: controller.getProductPrice(product),
              isLarge: true,
            )
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),

        //title

        TProductTitleText(title: product.title),
        SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),

        //Stack Status

        Row(
          children: [
            TProductTitleText(
              title: 'Stock:',
              smallSizes: true,
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              controller.getProductStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

        SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),

        //brand
        if (product.brand != null)
          TVerifiedTitle(
            title: product.brand!.name,
            brandTextSize: TextSizes.medium,
          ),
      ],
    );
  }
}

class TProductPriceText extends StatelessWidget {
  const TProductPriceText({
    super.key,
    this.currentSign = TTexts.euroSign,
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
    this.isBold = false,
  });
  final String currentSign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Text(
      currentSign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null)
          : isBold
              ? Theme.of(context).textTheme.titleLarge!.apply(
                  decoration: lineThrough ? TextDecoration.lineThrough : null)
              : Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}

class TRating extends StatelessWidget {
  const TRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Iconsax.star, color: Colors.amber, size: 24),
        SizedBox(
          width: TSizes.spaceBtwItems / 2,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(text: '5.0 ', style: Theme.of(context).textTheme.bodyLarge),
          TextSpan(text: '(199)', style: Theme.of(context).textTheme.bodyMedium)
        ]))
      ],
    );
  }
}

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);
    final dark = THelperFunctions.isDarkMode(context);

    return TCurvedEdgeWidget(
        child: Container(
      color: dark ? TColors.darkerGrey : TColors.light,
      child: Stack(
        children: [
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: (index) {
                  // This is triggered whenever the page changes
                  controller.selectedProductImage.value = images[index];
                  controller.currentPage.value =
                      index; // Update the current page index
                }, // Add this line
                itemCount: images.length, // Add this line
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => controller.showEnlargedImage(
                        images[index]), // Use index to get the image
                    child: Image(
                      image: NetworkImage(
                          images[index]), // Use index to get the image
                    ),
                  );
                },
              ),
            ),
          ),

          //Image Slider
          Positioned(
            right: 0,
            bottom: 30,
            left: TSizes.defaultSpace,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (_, index) => Obx(() {
                  final selectedImage =
                      controller.selectedProductImage.value == images[index];
                  return TRoundedImage(
                    isNetworkImage: true,
                    onPressed: () =>
                        controller.selectImage(images[index], index),
                    padding: EdgeInsets.all(TSizes.sm),
                    border: Border.all(
                        color: selectedImage
                            ? TColors.primary
                            : Colors.transparent),
                    width: 80,
                    imageUrl: images[index],
                    backgroundColor: dark ? TColors.dark : TColors.white,
                  );
                }),
                separatorBuilder: ((_, __) => SizedBox(
                      width: TSizes.spaceBtwItems,
                    )),
                itemCount: images.length,
              ),
            ),
          ),
          //Appbar
          TAppBar(
            showBackArrow: true,
            actions: [
              TFavouriteIcon(
                productId: product.id,
              )
            ],
          )
        ],
      ),
    ));
  }
}
