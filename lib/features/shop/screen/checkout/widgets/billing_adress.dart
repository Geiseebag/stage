import 'package:app_stage/features/personalization/controllers/address_controller.dart';
import 'package:app_stage/features/shop/controllers/cart_controller.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => controller.selectNewAddressPopup(context)),
      Obx(() {
        if (controller.selectedAddress.value.name.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.selectedAddress.value.name,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              Row(children: [
                const Icon(Icons.phone, color: Colors.grey, size: 16),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(controller.selectedAddress.value.formattedPhoneNo,
                    style: Theme.of(context).textTheme.bodyMedium),
              ]), // Row
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Row(children: [
                const Icon(Icons.location_history,
                    color: Colors.grey, size: 16),
                const SizedBox(width: TSizes.spaceBtwItems),
                Expanded(
                    child: Text(controller.selectedAddress.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        softWrap: true)),
              ])
            ],
          );
        } else {
          return Text(
            'Select Address',
            style: Theme.of(context).textTheme.bodyMedium,
          );
        }
      })

      // Row
    ]);
  }
}
