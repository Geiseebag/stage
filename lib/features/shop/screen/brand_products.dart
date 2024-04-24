import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:app_stage/features/shop/controllers/all_products_controller.dart';
import 'package:app_stage/features/shop/controllers/brand_controller.dart';
import 'package:app_stage/features/shop/models/brand_model.dart';
import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/store.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text(brand.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Detail
              TBrandCard(showBorder: true, brand: brand),
              const SizedBox(height: TSizes.spaceBtwSections),
              FutureBuilder(
                future: controller.getBrandProducts(brand.id),
                builder: (context, snapshot) {
                  /// Handle Loader, No Record, OR Error Message
                  const loader = TverticalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  /// Record Found!
                  final brandProducts = snapshot.data!;
                  return TSortableProducts(products: brandProducts);
                },
              ), // FutureBuilder
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
    required this.products,
  });
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product sorting
    final controller = Get.put(AllProductsController());
    controller.assignProduct(products);

    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            // Sort products based on the selected option
            controller.sortProducts(value!);
          },
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale']
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ), // DropdownButtonFormField
        const SizedBox(height: TSizes.spaceBtwSections),

        /// Products
        Obx(() => TGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>
                TProductCardVertical(product: controller.products[index]))),
      ], // Column
    );
  }
}
