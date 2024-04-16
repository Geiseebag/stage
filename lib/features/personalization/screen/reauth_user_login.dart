import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/features/personalization/controllers/user_controller.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ReAuthLoginScreen extends StatelessWidget {
  const ReAuthLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Re-Autheticate to Confirm",
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
                  key: controller.reAuthFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.spaceBtwSections),
                    child: Column(
                      children: [
                        TextFormField(
                            controller: controller.verifyEmail,
                            validator: (value) =>
                                TValidator.validateEmail(value),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.user_copy),
                                labelText: TTexts.email)),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),
                        Obx(
                          () => TextFormField(
                              controller: controller.verifyPassword,
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      value, 'Password'),
                              obscureText: controller.hidePassword.value,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    (Icons.password_rounded),
                                  ),
                                  labelText: TTexts.password,
                                  suffixIcon: IconButton(
                                    icon: Icon(controller.hidePassword.value
                                        ? Iconsax.eye_slash_copy
                                        : Iconsax.eye_copy),
                                    onPressed: () => controller.hidePassword
                                        .value = !controller.hidePassword.value,
                                  ))),
                        ),

                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        //Save Button

                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () =>
                                    controller.reAuthenticateEmailAndPassword(),
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
