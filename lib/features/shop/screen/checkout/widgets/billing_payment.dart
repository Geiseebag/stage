import 'package:app_stage/features/shop/controllers/cart_controller.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Column(
      children: [
        /// SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('€${controller.totalCartPrice.value}',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ), //Row
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text(
                '€${TPricingCalculator.calculateShippingCost(controller.totalCartPrice.value, 'FR')}',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text(
                '€${TPricingCalculator.calculateTax(controller.totalCartPrice.value, 'FR')}',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ), //Row
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text(
                '€${TPricingCalculator.calculateTotalPrice(controller.totalCartPrice.value, 'FR')}',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ), //Row//Row
      ],
    ); //Column
  }
}
