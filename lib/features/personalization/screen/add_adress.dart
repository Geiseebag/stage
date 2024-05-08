import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/features/personalization/controllers/address_controller.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AddUserAdressScreen extends StatelessWidget {
  const AddUserAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Add new Adress",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                    validator: (value) =>
                        TValidator.validateEmptyText(value, 'Name'),
                    controller: controller.name,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user_copy),
                        labelText: 'Name')),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                    validator: (value) => TValidator.validatePhoneNumber(value),
                    controller: controller.phoneNumber,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        labelText: 'Phone Number')),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          validator: (value) => TValidator.validateEmptyText(
                              value, 'Postal Code'),
                          controller: controller.postalCode,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.code_copy),
                              labelText: 'Postal Code')),
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwInputFields,
                    ),
                    Expanded(
                      child: TextFormField(
                          validator: (value) =>
                              TValidator.validateEmptyText(value, 'Street'),
                          controller: controller.street,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.building_3_copy),
                              labelText: 'Street')),
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          validator: (value) =>
                              TValidator.validateEmptyText(value, 'City'),
                          controller: controller.city,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.building_copy),
                              labelText: 'City')),
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwInputFields,
                    ),
                    Expanded(
                      child: TextFormField(
                          validator: (value) =>
                              TValidator.validateEmptyText(value, 'State'),
                          controller: controller.state,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.activity_copy),
                              labelText: 'State')),
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                    controller: controller.country,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.global_copy),
                        labelText: 'Country')),
                const SizedBox(
                  height: TSizes.defaultSpace,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.addNewAddresses(),
                      child: Text(
                        "Save",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: TColors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
