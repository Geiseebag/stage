import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:app_stage/features/shop/controllers/favourite_controller.dart';
import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    return Scaffold(
        appBar: TAppBar(
          title: Text('WishList',
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCircularIcon(
                icon: CupertinoIcons.add,
                onPressed: () => Get.to(const HomeScreen())),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Obx(
                    () => FutureBuilder(
                        future: controller.getFavouriteProducts(),
                        builder: (context, snapshot) {
                          const loader = TverticalProductShimmer(itemCount: 6);

                          final widget =
                              TCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,
                            loader: loader,
                          );
                          if (widget != null) return widget;
                          final products = snapshot.data!;
                          return TGridLayout(
                              itemCount: products.length,
                              itemBuilder: (_, index) => TProductCardVertical(
                                    product: products[index],
                                  ));
                        }),
                  )
                ],
              )),
        ));
  }
}
