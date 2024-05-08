import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/common/widgets/loaders/animation_loader.dart';
import 'package:app_stage/features/shop/controllers/cart_controller.dart';
import 'package:app_stage/features/shop/screen/cart/widgets/add_remove_button.dart';
import 'package:app_stage/features/shop/screen/cart/widgets/cart_item.dart';
import 'package:app_stage/features/shop/screen/checkout/checkout.dart';
import 'package:app_stage/features/shop/screen/product_details.dart';
import 'package:app_stage/features/shop/screen/widgets/navigation_menu.dart';
import 'package:app_stage/utils/constants/image_strings.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title:
              Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(() {
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Cart is Empty.',
          showAction: true,
          actionText: 'Let' 's add something',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );
        if (controller.cartItems.value.isEmpty) {
          return emptyWidget;
        } else {
          return SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ListView.separated(
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: TSizes.spaceBtwSections),
                  shrinkWrap: true,
                  itemCount: controller.cartItems.length,
                  itemBuilder: (_, index) => Obx(() {
                    final item = controller.cartItems[index];
                    return Column(
                      children: [
                        TCartItem(
                          cartItem: item,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ///Extra Space
                                SizedBox(width: 70),

                                ///Add Remove Buttons,
                                TProductQuantityWithRemoverButton(
                                  quantity: item.quantity,
                                  add: () => controller.addOneToCart(item),
                                  remove: () =>
                                      controller.removeOneFromCart(item),
                                ),
                              ],
                            ),

                            ///--Product total price
                            TProductPriceText(
                                price: (item.price * item.quantity)
                                    .toStringAsFixed(1)),
                          ],
                        ),
                      ],
                    );
                  }),
                )),
          );
        }
      }),
      bottomNavigationBar: Obx(
        () {
          return Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: !controller.cartItems.isEmpty
                  ? ElevatedButton(
                      onPressed: () => Get.to(() => CheckoutScreen()),
                      child:
                          Text('Checkout \€${controller.totalCartPrice.value}'),
                    )
                  : SizedBox());
        },
      ),
    );
  }
}
