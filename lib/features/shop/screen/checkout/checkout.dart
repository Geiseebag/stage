import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/data/repositories/authentication/authentication_repository.dart';
import 'package:app_stage/features/authentification/screen/widgets/success_screen.dart';
import 'package:app_stage/features/personalization/controllers/order_controller.dart';
import 'package:app_stage/features/shop/controllers/cart_controller.dart';
import 'package:app_stage/features/shop/models/cart_item_model.dart';
import 'package:app_stage/features/shop/screen/cart/widgets/cart_item.dart';
import 'package:app_stage/features/shop/screen/checkout/widgets/billing_adress.dart';
import 'package:app_stage/features/shop/screen/checkout/widgets/billing_payment.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/product_details.dart';
import 'package:app_stage/features/shop/screen/widgets/navigation_menu.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:app_stage/utils/helpers/pricing_calculator.dart';
import 'package:app_stage/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    final orderController = Get.put(OrderController());

    return Scaffold(
        appBar: TAppBar(
            showBackArrow: true,
            title: Text('Order Review',
                style: Theme.of(context).textTheme.headlineSmall)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(children: [
              /// -- Items in Cart
              Obx(
                () => ListView.separated(
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
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// -- Coupon TextField
              TCouponCode(dark: dark),
              const SizedBox(height: TSizes.spaceBtwSections),
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    /// Pricing
                    TBillingPaymentSection(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Divider
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Address
                    TBillingAddressSection()
                  ],
                ),
              ),
            ]),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ElevatedButton(
            onPressed: controller.totalCartPrice.value > 0
                ? () => orderController.processOrder(
                    TPricingCalculator.calculateTotalPrice(
                        controller.totalCartPrice.value, 'FR'))
                : () => Tloaders.warningSnackBar(
                    title: 'Empty Cart',
                    message: 'Add items in the cart in order to proceed'),
            child: Text(
                'Checkout €${TPricingCalculator.calculateTotalPrice(controller.totalCartPrice.value, 'FR')}'),
          ),
        ));
  }
}

class TCouponCode extends StatelessWidget {
  const TCouponCode({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.white,
      padding: const EdgeInsets.only(
          top: TSizes.sm, bottom: TSizes.sm, right: TSizes.sm, left: TSizes.md),
      child: Row(
        children: [
          /// TextField
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: dark
                    ? TColors.white.withOpacity(0.5)
                    : TColors.dark.withOpacity(0.5),
                backgroundColor: Colors.grey.withOpacity(0.2),
                side: BorderSide(color: Colors.grey.withOpacity(0.1)),
              ),
              child: const Text('Apply'),
            ), // ElevatedButton
          ), // SizedBox
        ], // children
      ), // Row
    );
  }
}
