import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/features/personalization/controllers/update_name_controller.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Change Name",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //logo

                  Text(
                      "This name will appear in several pages. Use your real name for easy verification.",
                      style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
              Form(
                  key: controller.updateUserNameFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.spaceBtwSections),
                    child: Column(
                      children: [
                        TextFormField(
                            controller: controller.firstName,
                            validator: (value) => TValidator.validateEmptyText(
                                value, 'First Name'),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.user_copy),
                                labelText: TTexts.firstName)),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),
                        TextFormField(
                            controller: controller.lastName,
                            validator: (value) => TValidator.validateEmptyText(
                                value, 'Last Name'),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                (Iconsax.user_copy),
                              ),
                              labelText: TTexts.lastName,
                            )),

                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        //Save Button

                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () => controller.updateName(),
                                child: Text("Save"))),

                        const SizedBox(
                          height: TSizes.spaceBtwItems / 2,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
