import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  TGridLayout(
                      itemCount: 10,
                      itemBuilder: (_, index) => const TProductCardVertical(
                            favourite: true,
                          ))
                ],
              )),
        ));
  }
}
