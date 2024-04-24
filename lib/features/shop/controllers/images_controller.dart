import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();
  //variables
  RxString selectedProductImage = ''.obs;
  final pageController = PageController();
  final RxInt currentPage = 0.obs;
  //functions
  void selectImage(String image, int index) {
    currentPage.value = index;
    selectedProductImage.value = image;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300), // Adjust duration to control speed
      curve: Curves.easeInOut,
    );
  }

  List<String> getAllProductImages(ProductModel product) {
    //a list of UNIQUE images only without duplicates
    Set<String> images = {};

    images.add(product.thumbnail);
    //assign thumbnail image
    selectedProductImage.value = product.thumbnail;

    if (product.images != null) {
      images.addAll(product.images!);
    }
    if (product.productVariations != null ||
        product.productVariations!.isNotEmpty) {
      images.addAll(
          product.productVariations!.map((variation) => variation.image));
    }

    return images.toList();
  }

  void showEnlargedImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.defaultSpace * 2,
                        horizontal: TSizes.defaultSpace),
                    child: Image(image: AssetImage(image)),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                          onPressed: () => Get.back(), child: Text('Close')),
                    ),
                  )
                ],
              ),
            ));
  }
}
